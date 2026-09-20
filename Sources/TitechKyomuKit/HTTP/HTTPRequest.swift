import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

enum BaseURL {
    #if TEST
    static var origin = "https://kyomu-mock.isct.app"
    static var host = "kyomu-mock.isct.app"

    static func changeToMockServer() {}
    #else
    static var origin = "https://kyomu0.gakumu.titech.ac.jp"
    static var host = "kyomu0.gakumu.titech.ac.jp"

    static func changeToMockServer() {
        origin = "https://kyomu-mock.isct.app"
        host = "kyomu-mock.isct.app"
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
        switch method {
        case .get:
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpShouldHandleCookies = true
            request.allHTTPHeaderFields = headerFields?.merging(["User-Agent": userAgent], uniquingKeysWith: { key1, _ in key1 }) ?? [:]
            return request
        }
    }
}
