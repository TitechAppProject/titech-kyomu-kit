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
    
    /// 実装サンプルです。後で消してください
    public func example() async throws -> Bool {
        let html = try await httpClient.send(ExampleRequest())
        
        return html == "Success\n"
    }
}
