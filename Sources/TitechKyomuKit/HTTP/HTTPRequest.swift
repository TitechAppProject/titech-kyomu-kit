import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum BaseURL {
    #if TEST
    static var origin = "https://titech-kyomu-mock.s3.ap-northeast-1.amazonaws.com"
    static var host = "titech-kyomu-mock.s3.ap-northeast-1.amazonaws.com"

    static func changeToMockServer() {}
    #else
    static var origin = "https://kyomu0.gakumu.titech.ac.jp"
    static var host = "kyomu0.gakumu.titech.ac.jp"

    static func changeToMockServer() {
        origin = "https://titech-kyomu-mock.s3.ap-northeast-1.amazonaws.com"
        host = "titech-kyomu-mock.s3.ap-northeast-1.amazonaws.com"
    }
    #endif
}

enum HTTPMethod: String {
    case get = "GET"
}

protocol HTTPRequest {
    var url: URL { get }

    var method: HTTPMethod { get }

    var headerFields: [String: String]? { get }
}

extension HTTPRequest {
    func generate(userAgent: String) -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        switch method {
        case .get:
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpShouldHandleCookies = true
            request.allHTTPHeaderFields = headerFields?.merging(["User-Agent" : userAgent], uniquingKeysWith: { key1, _ in key1}) ?? [:]
            return request
        }
    }
}

