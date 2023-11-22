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
        let title = doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_ctl08_ctl13_lblTerm")
            .first?
            .content?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let year = Int(title.matches(#"^(\d+)"#)?.first?.first ?? "") ?? 0
        
        return doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_grid tr:not(:first-of-type)").compactMap { row -> KyomuCourse? in
            let tds = row.css("td")
            guard let resultContent = tds[9].content, resultContent.contains("OK") || resultContent.contains("○") else {
                return nil
            }

            let periodTd = tds[2]
            let periodContent = periodTd.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let periodRegexpResult = periodContent
                .matches("([日月火水木金土]|Sun|Mon|Tue|Wed|Thu|Fri|Sat)(\\d+)-(\\d+)\\s?(?:\\(([^()（）]+(\\([^()（）]+\\)[^()（）]*)*)\\))?") ?? []
            print(periodRegexpResult)
            let periods = periodRegexpResult.map { result -> KyomuCoursePeriod in
                KyomuCoursePeriod(
                    day: DayOfWeek.convert(result[0]),
                    start: Int(result[1]) ?? -1,
                    end: Int(result[2]) ?? -1,
                    location: result[3]
                )
            }

            let ocwId = tds[6].css("a").first?["href"]?.matches("JWC=([0-9]+)")?.first?.first

            return KyomuCourse(
                name: tds[6].css(".showAtPrintDiv").first?.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                periods: periods,
                year: year,
                quarters: KyomuCourse.convert2Quarters(tds[1].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""),
                code: tds[5].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                ocwId: ocwId ?? "",
                isForm8: tds[12].content?.contains("Form No.8") ?? false || tds[12].content?.contains("様式第８号") ?? false
            )
        }
    }

    public static func changeToMockServer() {
        BaseURL.changeToMockServer()
    }
}
