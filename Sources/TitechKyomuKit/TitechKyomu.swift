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
}
