import XCTest
@testable import TitechKyomuKit

final class TitechKyomuKitTests: XCTestCase {
    func testExample() async throws {
        let html = try! String(contentsOf: Bundle.module.url(forResource: "Dummy", withExtension: "html")!)
        let result = try await TitechKyomu(mockHtml: html).example()
        XCTAssertEqual(result, true)
    }
}
