import XCTest
@testable import TitechKyomuKit

final class TitechKyomuKitTests: XCTestCase {
    func testParseTopPageJa() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "TopJapanese", withExtension: "html")!)
        let resultJa = try await titechkyomu.parseTopPage(html: htmlJa)
        XCTAssertTrue(resultJa)
    }
    
    func testParseTopPageEn() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "TopEnglish", withExtension: "html")!)
        let resultEn = try await titechkyomu.parseTopPage(html: htmlEn)
        XCTAssertTrue(resultEn)
    }
    
    func testParseTopPageMaintenance() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlMaintenance = try! String(contentsOf: Bundle.module.url(forResource: "TopMaintenance", withExtension: "html")!)
        let resultMaintenance = try await titechkyomu.parseTopPage(html: htmlMaintenance)
        XCTAssertFalse(resultMaintenance)
    }
    
    func testParseReportCheckPageJa() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultJapanese", withExtension: "html")!)
        
        let resultJa = try await titechkyomu.parseReportCheckPage(html: htmlJa)
        XCTAssertEqual(
            resultJa[0],
            KyomuCourse(
                name: "分光学",
                periods: [KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
                          KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")],
                quarters: [1],
                code: "MAT.C302",
                ocwId: "202202171"
            )
        )
        XCTAssertFalse(resultJa.contains { $0.name == "固体物理学(格子系)" })
        XCTAssertEqual(
            resultJa[6],
            KyomuCourse(
                name: "アルゴリズムとデータ構造",
                periods: [],
                quarters: [2],
                code: "MCS.T213",
                ocwId: "202202382"
            )
        )
    }
    
    func testParseReportCheckPageEn() async throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultEnglish", withExtension: "html")!)
        
        let resultEn = try await titechkyomu.parseReportCheckPage(html: htmlEn)
        XCTAssertEqual(
            resultEn[0],
            KyomuCourse(
                name: "Spectroscopy",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S7-202"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S7-202")
                ],
                quarters: [1],
                code: "MAT.C302",
                ocwId: "202202171"
            )
        )
        XCTAssertFalse(resultEn.contains { $0.name == "Solid State Physics (Lattice)" })
        XCTAssertEqual(
            resultEn[6],
            KyomuCourse(
                name: "Introduction to Algorithms and Data Structures",
                periods: [],
                quarters: [2],
                code: "MCS.T213",
                ocwId: "202202382"
            )
        )
    }
}
