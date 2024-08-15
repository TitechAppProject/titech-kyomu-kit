import Foundation

#if canImport(os)
import os
#endif

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol HTTPClient {
    func send(_ request: HTTPRequest) async throws -> String
}

struct HTTPClientImpl: HTTPClient {
    private let urlSession: URLSession
    #if !canImport(FoundationNetworking)
    private let urlSessionDelegate: URLSessionTaskDelegate
    #endif
    private let userAgent: String

    init(urlSession: URLSession, userAgent: String) {
        self.urlSession = urlSession
        #if !canImport(FoundationNetworking)
        self.urlSessionDelegate = HTTPClientDelegate()
        #endif
        self.userAgent = userAgent
    }

    func send(_ request: HTTPRequest) async throws -> String {
        let data = try await fetchData(request: request.generate(userAgent: userAgent))

        return String(data: data, encoding: .utf8) ?? ""
    }

    func fetchData(request: URLRequest) async throws -> Data {
        #if canImport(FoundationNetworking)
        return try await withCheckedThrowingContinuation { continuation in
            urlSession.dataTask(with: request) { data, _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: data ?? Data())
                }
            }.resume()
        }
        #else
        return try await urlSession.data(for: request, delegate: urlSessionDelegate).0
        #endif
    }
}

struct HTTPClientMock: HTTPClient {
    let html: String

    func send(_ request: HTTPRequest) async throws -> String {
        html
    }
}

class HTTPClientDelegate: URLProtocol, URLSessionTaskDelegate {
    #if DEBUG && canImport(os)
    private let logger = Logger(subsystem: "app.titech.titech-kyomu-kit", category: "HTTPClientDelegate")
    #endif

    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Swift.Void
    ) {
        #if DEBUG && canImport(os)
        logger.debug(
            """
            \(response.statusCode) \(task.currentRequest?.httpMethod ?? "") \(task.currentRequest?.url?.absoluteString ?? "")
              requestHeader: \(task.currentRequest?.allHTTPHeaderFields ?? [:])
              requestBody: \(String(data: task.originalRequest?.httpBody ?? Data(), encoding: .utf8) ?? "")
              responseHeader: \(response.allHeaderFields)
              redirect -> \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")
            """
        )
        #endif

        completionHandler(request)
    }

    func urlSession(_: URLSession, task: URLSessionTask, didFinishCollecting _: URLSessionTaskMetrics) {
        #if DEBUG && canImport(os)
        logger.debug(
            """
            200 \(task.currentRequest!.httpMethod!) \(task.currentRequest!.url!.absoluteString)
              requestHeader: \(task.currentRequest!.allHTTPHeaderFields ?? [:])
              requestBody: \(String(data: task.originalRequest!.httpBody ?? Data(), encoding: .utf8) ?? "")
            """
        )
        #endif
    }
}
