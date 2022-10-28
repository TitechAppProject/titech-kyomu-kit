import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Kanna

public struct TitechKyomu {
    private let httpClient: HTTPClient
    public static let defaultUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1"

    public init(urlSession: URLSession, userAgent: String = TitechKyomu.defaultUserAgent) {
        self.httpClient = HTTPClientImpl(urlSession: urlSession, userAgent: userAgent)
    }
    
    public func fetchTopPage() async throws -> Bool {
        let html = try await httpClient.send(TopPageRequest())
        return try await parseTopPage(html: html)
    }
    
    public func fetchKyomuCourseData() async throws -> [KyomuCourse] {
        let html = try await httpClient.send(ReportCheckPageRequest())
        return try await parseReportCheckPage(html: html)
    }
    
    public func fetchForm8CourseData() async throws -> [KyomuCourse] {
        let html = try await httpClient.send(CourseAdministrationFormPageRequest())
        return try await parseForm8(html: html)
    }

    func parseTopPage(html: String) async throws -> Bool {
        let doc = try HTML(html: html, encoding: .utf8)
        let title = doc.css("title").first?.content ?? ""
        return (title.contains("学生トップ") || title.contains("Top"))
    }

    func parseReportCheckPage(html: String) async throws -> [KyomuCourse] {
        let doc = try HTML(html: html, encoding: .utf8)
        
        return doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_grid tr:not(:first-of-type)").compactMap { row -> KyomuCourse? in
            let tds = row.css("td")
            guard (tds[10].content ?? "").trimmingCharacters(in: .whitespacesAndNewlines) == "OK" else {
                return nil
            }

            let periodTd = tds[2]
            let periodContent = periodTd.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let periodRegexpResult = periodContent
                .matches(#"([日月火水木金土]|Sun|Mon|Tue|Wed|Thu|Fri|Sat)(\d)-(\d)\s?(?:[(（]([^()（）]+)[)）])?"#) ?? []
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
                quarters: KyomuCourse.convert2Quarters(tds[1].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""),
                code: tds[5].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                ocwId: ocwId ?? ""
            )
        }
    }
    
    func parseForm8(html: String) async throws -> [KyomuCourse] {
        let doc = try HTML(html: html, encoding: .utf8)
        
        return doc.css("#ctl00_ContentPlaceHolder1_grd8 tr:not(:first-of-type)").compactMap { row -> KyomuCourse? in
            let tds = row.css("td")
            let status = tds[1].content ?? ""
            guard status.contains("承認済み") || status.contains("Approved") else {
                return nil
            }
            
            let name = tds[4].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            let periodTd = tds[2]
            let periodContent = periodTd.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let periodRegexpResult = periodContent
                .matches(#"([日月火水木金土]|Sun|Mon|Tue|Wed|Thu|Fri|Sat)(\d)-(\d)\s?(?:[(（]([^()（）]+)[)）])?"#) ?? []
            let periods = periodRegexpResult.map { result -> KyomuCoursePeriod in
                KyomuCoursePeriod(
                    day: DayOfWeek.convert(result[0]),
                    start: Int(result[1]) ?? -1,
                    end: Int(result[2]) ?? -1,
                    location: result[3]
                )
            }
            
            let quartersRegexResult = periodContent.matches("(^[^:：]+)[:：]") ?? []
            let quarters = Array(Set(quartersRegexResult.flatMap{ KyomuCourse.convert2Quarters($0[0]) })).sorted()
            let code = tds[3].content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            let ocwId = tds[4].css("a").first?["href"]?.matches("JWC=([0-9]+)")?.first?.first ?? ""
            
            return KyomuCourse(name: name, periods: periods, quarters: quarters, code: code, ocwId: ocwId)
        }
    }

    public static func changeToMockServer() {
        BaseURL.changeToMockServer()
    }
}
