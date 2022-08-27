import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Kanna

struct TitechKyomu {
    private let httpClient: HTTPClient
    public static let defaultUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1"

    public init(urlSession: URLSession, userAgent: String = TitechKyomu.defaultUserAgent) {
        self.httpClient = HTTPClientImpl(urlSession: urlSession, userAgent: userAgent)
    }
    
    public func loginToTop() async throws -> Bool {
        let html = try await httpClient.send(TopPageRequest())
        let doc = try HTML(html: html, encoding: .utf8)
        let title = doc.css("title").first?.content ?? ""
        print(title)
        return (title.contains("学生トップ") || title.contains("Top"))
    }
    
    public func fetchKyomuCourseData() async throws -> [KyomuCourse] {
        let html = try await httpClient.send(ReportCheckPageRequest())
        return try await parseReportCheckPage(html: html)
    }
    
    func parseReportCheckPage(html: String) async throws -> [KyomuCourse] {
        let doc = try HTML(html: html, encoding: .utf8)
        
        return doc.css("#ctl00_ContentPlaceHolder1_CheckResult1_grid tr:not(:first-of-type)").compactMap { row in
            let tds = row.css("td").map { td -> String in
                if let courseNameElement = td.css(".showAtPrintDiv").first  {
                    return courseNameElement.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                } else {
                    return td.content?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                }
            }
            if tds[10] != "OK" {
                return nil
            }
            let periodRegexpResult = tds[2].matches(#"([日月火水木金土]|Sun|Mon|Tue|Wed|Thu|Fri|Sat)(\d)-(\d)\s?(?:[(（]([^()（）]+)[)）])?"#) ?? []
            let periods = periodRegexpResult.map { result -> KyomuCoursePeriod in
                KyomuCoursePeriod(
                    day: DayOfWeek.convert(result[0]),
                    start: Int(result[1]) ?? -1,
                    end: Int(result[2]) ?? -1,
                    location: result[3]
                )
            }
            
            return KyomuCourse(name: tds[6], periods: periods, quarters: KyomuCourse.convert2Quarters(tds[1]), code: tds[5])
        }
    }
}
