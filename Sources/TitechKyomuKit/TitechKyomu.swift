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
    
#if DEBUG
    /// Test時のMock用
    init(mockHtml: String) {
        self.httpClient = HTTPClientMock(html: mockHtml)
    }
#endif
    
    public func fetchRegisteredCoursePage() async throws -> String {
        let html = try await httpClient.send(ReportCheckPageRequest())
        
        return html
    }
    
    public func parse(html: String) async throws -> [Course] {
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
            let periods = periodRegexpResult.map { result -> CoursePeriod in
                        CoursePeriod(
                            day: DayOfWeek.convert(result[0]),
                            start: Int(result[1]) ?? -1,
                            end: Int(result[2]) ?? -1,
                            location: result[3]
                        )
                    }
            
            return Course(name: tds[6], periods: periods, quarters: Course.convert2Quarters(tds[1]), code: tds[5])
        }
    }
}
