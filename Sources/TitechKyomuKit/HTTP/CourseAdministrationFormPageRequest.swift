import Foundation

struct CourseAdministrationFormPageRequest: HTTPRequest {
    let url: URL = URL(string: BaseURL.origin + "/Titech/Student/%e6%89%bf%e8%aa%8d%e7%94%b3%e8%ab%8b/PID1_8.aspx")!
    
    let method: HTTPMethod = .get
    
    let headerFields: [String : String]? = [
        "Connection": "keep-alive",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Encoding": "br, gzip, deflate",
        "Accept-Language": "ja-jp"
    ]
    
    let body: [String : String]? = nil
}
