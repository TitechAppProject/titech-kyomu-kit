import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Kanna

public enum TitechKyomuError: Error {
    case failedLogin
}

public struct TitechKyomu {
    private let httpClient: HTTPClient
    public static let defaultUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1"

    public init(urlSession: URLSession, userAgent: String = TitechKyomu.defaultUserAgent) {
        self.httpClient = HTTPClientImpl(urlSession: urlSession, userAgent: userAgent)
    }
    
    public func loginTopPage() async throws {
        let html = try await httpClient.send(TopPageRequest())
        if !(try await parseTopPage(html: html)) {
            throw TitechKyomuError.failedLogin
        }
    }
    
    public func fetchKyomuCourseData() async throws -> [KyomuCourse] {
        let html = try await httpClient.send(ReportCheckPageRequest())
        return try await parseReportCheckPage(html: html)
    }

    func parseTopPage(html: String) async throws -> Bool {
        let doc = try HTML(html: html, encoding: .utf8)
        let title = doc.css("title").first?.content ?? ""
        return (title.contains("学生トップ") || title.contains("Top"))
    }

    func parseReportCheckPage(html: String) async throws -> [KyomuCourse] {
        let doc = try HTML(html: html, encoding: .utf8)
        let title = doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_ctl08_ctl13_lblTerm")
            .first?
            .content?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let year = Int(title.firstMatch(of: #/^(\d{4})/#)?.0 ?? "") ?? 0
        
        return doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_grid tr:not(:first-of-type)").compactMap { row -> KyomuCourse? in
            let tds = row.css("td")
            guard let resultContent = tds[9].content, resultContent.contains("OK") || resultContent.contains("○") else {
                return nil
            }

            let periodTd = tds[2]
            let periodContent = periodTd.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let periodsRegex = #/(?<day>[日月火水木金土]|Sun|Mon|Tue|Wed|Thu|Fri|Sat)(?<start>\d)-(?<end>\d)\s?(?:[(（](?<location>[^()（）]+)[)）])?/#
            let periods = periodContent.matches(of: periodsRegex).compactMap { result in
                KyomuCoursePeriod(
                    day: DayOfWeek.convert(String(result.day)),
                    start: Int(result.start) ?? -1,
                    end: Int(result.end) ?? -1,
                    location: String(result.location ?? "")
                )
            }

            let ocwId = String(tds[6].css("a").first?["href"]?.matches(of: #/JWC=(?<id>[0-9]+)/#).first?.id ?? "")

            return KyomuCourse(
                name: tds[6].css(".showAtPrintDiv").first?.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                periods: periods,
                year: year,
                quarters: KyomuCourse.convert2Quarters(tds[1].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""),
                code: tds[5].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                ocwId: ocwId,
                isForm8: tds[12].content?.contains("Form No.8") ?? false || tds[12].content?.contains("様式第８号") ?? false
            )
        }
    }

    public static func changeToMockServer() {
        BaseURL.changeToMockServer()
    }
}
