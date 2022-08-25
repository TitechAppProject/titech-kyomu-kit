import Foundation

/// 実装サンプルです。後で消してください
struct ExampleRequest: HTTPRequest {
    let url: URL = URL(string: BaseURL.origin + "/hoge")!
    
    let method: HTTPMethod = .get
    
    let headerFields: [String : String]? = nil
    
    let body: [String : String]? = nil
}
