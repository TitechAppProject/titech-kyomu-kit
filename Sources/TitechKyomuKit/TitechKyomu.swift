import Foundation
import Kanna
import RegexBuilder

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public enum TitechKyomuError: Error {
    case failedLogin
}

public struct TitechKyomu {
    private let httpClient: HTTPClient
    public static let defaultUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1"

    public init(urlSession: URLSession, userAgent: String = TitechKyomu.defaultUserAgent) {
        self.httpClient = HTTPClientImpl(urlSession: urlSession, userAgent: userAgent)
    }

    public func loginTopPage() async throws {
        let html = try await httpClient.send(TopPageRequest())
        if !(try parseTopPage(html: html)) {
            throw TitechKyomuError.failedLogin
        }
    }

    public func fetchKyomuCourseData() async throws -> [KyomuCourse] {
        let html = try await httpClient.send(ReportCheckPageRequest())
        return try parseReportCheckPage(html: html)
    }

    func parseTopPage(html: String) throws -> Bool {
        let doc = try HTML(html: html, encoding: .utf8)
        let title = doc.css("title").first?.content ?? ""
        return (title.contains("学生トップ") || title.contains("Top"))
    }

    func parseReportCheckPage(html: String) throws -> [KyomuCourse] {
        let doc = try HTML(html: html, encoding: .utf8)
        let title =
            doc.css("[id$='_lblTerm']") // 科学大変更前後・一時保存の全ケースに対応
            .first?
            .content?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let yearReference = Reference<Int>()
        let year =
            title.firstMatch(
                of: Regex {
                    Anchor.startOfLine
                    TryCapture(as: yearReference) {
                        OneOrMore(.digit)
                    } transform: {
                        Int($0)
                    }
                }
            )?[yearReference] ?? 0

        return doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_grid tr:not(:first-of-type):not(.timetableFukyoka)").compactMap { row -> KyomuCourse? in
            let tds = row.css("td")

            guard tds.count == 13 else {
                return nil
            }

            let isValid = if let resultContent = tds[9].text, resultContent.contains("OK") || resultContent.contains("○") {
                true
            } else {
                false
            }

            let periodTd = tds[2]
            let periodContent = periodTd.innerHTML?.trimmingCharacters(in: .whitespacesAndNewlines).filter({ !$0.isNewline }) ?? ""

            let dayReference = Reference<DayOfWeek>()
            let startReference = Reference<Int>()
            let endReference = Reference<Int>()
            let locationReference = Reference<String>()
            let regex = Regex {
                Capture(as: dayReference) {
                    ChoiceOf {
                        One(.anyOf("日月火水木金土"))
                        "Sun"
                        "Mon"
                        "Tue"
                        "Wed"
                        "Thu"
                        "Fri"
                        "Sat"
                    }
                } transform: {
                    DayOfWeek.convert(String($0))
                }
                TryCapture(as: startReference) {
                    OneOrMore(.digit)
                } transform: {
                    Int($0)
                }
                "-"
                TryCapture(as: endReference) {
                    OneOrMore(.digit)
                } transform: {
                    Int($0)
                }
                Optionally(.whitespace)
                Capture(as: locationReference) {
                    ZeroOrMore {
                        NegativeLookahead {
                            "<br"
                        }
                        CharacterClass.any
                    }
                } transform: {
                    if let first = $0.first,
                        let last = $0.last,
                        first == "(",
                        last == ")"
                    {
                        String($0.dropFirst().dropLast())
                    } else {
                        String($0)
                    }
                }
            }
            let periods = periodContent.matches(of: regex).map { result in
                KyomuCoursePeriod(
                    day: result[dayReference],
                    start: result[startReference],
                    end: result[endReference],
                    location: result[locationReference]
                )
            }

            let ocwIdReference = Reference<String>()
            let ocwId =
                tds[5].css("a").first?["href"]?
                .firstMatch(
                    of: Regex {
                        "jwc="
                        TryCapture(as: ocwIdReference) {
                            OneOrMore(.word)
                        } transform: {
                            String($0)
                        }
                    }
                )?[ocwIdReference] ?? ""

            let teachers =
                tds[8]
                .innerHTML?
                .components(separatedBy: "<br>")
                .map {
                    $0
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .replacingOccurrences(of: "  他", with: "")
                        .replacingOccurrences(of: "  et al.", with: "")
                } ?? []

            return KyomuCourse(
                name: tds[5].css(".showAtPrintDiv").first?.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                periods: periods,
                year: year,
                quarters: KyomuCourse.convert2Quarters(tds[1].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""),
                code: tds[4].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                ocwId: ocwId,
                teachers: teachers,
                isValid: isValid,
                isForm8: tds[12].content?.contains("Form No.8") ?? false || tds[12].content?.contains("様式第８号") ?? false
            )
        }
    }

    public static func changeToMockServer() {
        BaseURL.changeToMockServer()
    }
}
