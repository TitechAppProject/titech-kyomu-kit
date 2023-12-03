import Foundation

struct ReportCheckPageRequest: HTTPRequest {
    let url: URL = URL(string: BaseURL.origin + "/Titech/Student/%E7%A7%91%E7%9B%AE%E7%94%B3%E5%91%8A/PID1_3_1.aspx")!

    let method: HTTPMethod = .get

    let headerFields: [String: String]? = [
        "Connection": "keep-alive",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Encoding": "br, gzip, deflate",
        "Accept-Language": "ja-jp",
    ]
}
