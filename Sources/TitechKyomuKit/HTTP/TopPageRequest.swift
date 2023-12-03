import Foundation

struct TopPageRequest: HTTPRequest {
    let url: URL = URL(string: BaseURL.origin + "/Titech/Default.aspx")!

    let method: HTTPMethod = .get

    let headerFields: [String: String]? = [
        "Connection": "keep-alive",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Encoding": "br, gzip, deflate",
        "Accept-Language": "ja-jp",
    ]
}
