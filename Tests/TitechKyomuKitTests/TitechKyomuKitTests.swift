import XCTest

@testable import TitechKyomuKit

final class TitechKyomuKitTests: XCTestCase {
    func testParseTopPageJa() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "TopJapanese", withExtension: "html")!)
        let resultJa = try titechkyomu.parseTopPage(html: htmlJa)
        XCTAssertTrue(resultJa)
    }

    func testParseTopPageEn() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "TopEnglish", withExtension: "html")!)
        let resultEn = try titechkyomu.parseTopPage(html: htmlEn)
        XCTAssertTrue(resultEn)
    }

    func testParseTopPageMaintenance() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlMaintenance = try! String(contentsOf: Bundle.module.url(forResource: "TopMaintenance", withExtension: "html")!)
        let resultMaintenance = try titechkyomu.parseTopPage(html: htmlMaintenance)
        XCTAssertFalse(resultMaintenance)
    }

    func testParseReportCheckPageJa() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultJapanese", withExtension: "html")!)

        let resultJa = try titechkyomu.parseReportCheckPage(html: htmlJa)
        
        XCTAssertEqual(
            resultJa[0],
            KyomuCourse(
                name: "情報通信工学統合論基礎",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S4-201(S421)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S4-201(S421)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.A435",
                ocwId: "202536673",
                teachers: ["佐々木 広, ISLAM A K M MAHFUZUL, 一色 剛 他"],
                isValid: false,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[1],
            KyomuCourse(
                name: "現代暗号理論",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "WL2-301(W631)"),
                    KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "WL2-301(W631)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.C401",
                ocwId: "202504669",
                teachers: ["尾形 わかは"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[2],
            KyomuCourse(
                name: "分散アルゴリズム",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 7, end: 8, location: "M-356(H132)"),
                    KyomuCoursePeriod(day: .thursday, start: 7, end: 8, location: "M-356(H132)"),
                ],
                year: 2025,
                quarters: [1],
                code: "CSC.T438",
                ocwId: "202510377",
                teachers: ["DEFAGO XAVIER"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[3],
            KyomuCourse(
                name: "音声情報工学",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 1, end: 2, location: "G1-103 (G114)"),
                    KyomuCoursePeriod(day: .friday, start: 1, end: 2, location: "G1-103 (G114)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.H503",
                ocwId: "202504723",
                teachers: ["篠﨑 隆宏"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[4],
            KyomuCourse(
                name: "仮想世界システム",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "J2-203 (J221)"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "J2-203 (J221)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.H507",
                ocwId: "202504726",
                teachers: ["長谷川 晶一"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[5],
            KyomuCourse(
                name: "人間情報システム概論I",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "G5-105 (G511)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "G5-105 (G511)"),
                ],
                year: 2025,
                quarters: [2],
                code: "ICT.A406",
                ocwId: "202504680",
                teachers: ["船越 孝太郎, 小池 康晴, 山口 雅浩 他"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[6],
            KyomuCourse(
                name: "先端技術を用いた社会課題解決",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "G1-103 (G114)"),
                ],
                year: 2025,
                quarters: [2],
                code: "ICT.D401.L (ESD.E407)",
                ocwId: "202534821",
                teachers: ["中谷 桃子, 山口 雅浩, ※近藤 隆"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[7],
            KyomuCourse(
                name: "無線信号処理",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "S3-215(S321)"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "S3-215(S321)"),
                ],
                year: 2025,
                quarters: [2],
                code: "ICT.S407",
                ocwId: "202504673",
                teachers: ["府川 和彦"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[8],
            KyomuCourse(
                name: "文系エッセンス２０：西洋思想 1",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 3, end: 4, location: "G2-201(G223)"),
                ],
                year: 2025,
                quarters: [2],
                code: "LAH.S420-01",
                ocwId: "202508468",
                teachers: ["BEKTAS YAKUP"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[9],
            KyomuCourse(
                name: "修士キャリア構築基礎 B",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 5, end: 6, location: ""),
                ],
                year: 2025,
                quarters: [2],
                code: "ENT.C401-04",
                ocwId: "202536241",
                teachers: ["若山 浩二, 和泉 章, 伊東 幸子 他"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[10],
            KyomuCourse(
                name: "TOEFL対策セミナー第十四 1",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 7, end: 8, location: "M-155(H1104)"),
                ],
                year: 2025,
                quarters: [2],
                code: "LAE.E452-01",
                ocwId: "202503675",
                teachers: ["DE FERRANTI HUGH BARRY ZIANI"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultJa[11],
            KyomuCourse(
                name: "情報通信工学講究S1",
                periods: [],
                year: 2025,
                quarters: [1, 2],
                code: "ICT.Z491",
                ocwId: "202504683",
                teachers: ["指導教員"],
                isValid: true,
                isForm8: false
            )
        )
    }

    func testParseReportCheckPageEn() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultEnglish", withExtension: "html")!)

        let resultEn = try titechkyomu.parseReportCheckPage(html: htmlEn)
        
        XCTAssertEqual(
            resultEn[0],
            KyomuCourse(
                name: "Communications and Computer Engineering - Fundamentals",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S4-201(S421)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S4-201(S421)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.A435",
                ocwId: "202536673",
                teachers: ["Sasaki Hiroshi, Islam A K M Mahfuzul, Isshiki Tsuyoshi et al."],
                isValid: false,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[1],
            KyomuCourse(
                name: "Modern Cryptography",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "WL2-301(W631)"),
                    KyomuCoursePeriod(day: .thursday, start: 3, end: 4, location: "WL2-301(W631)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.C401",
                ocwId: "202504669",
                teachers: ["Ogata Wakaha"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[2],
            KyomuCourse(
                name: "Distributed Algorithms",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 7, end: 8, location: "M-356(H132)"),
                    KyomuCoursePeriod(day: .thursday, start: 7, end: 8, location: "M-356(H132)"),
                ],
                year: 2025,
                quarters: [1],
                code: "CSC.T438",
                ocwId: "202510377",
                teachers: ["Defago Xavier"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[3],
            KyomuCourse(
                name: "Speech Information Technology",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 1, end: 2, location: "G1-103 (G114)"),
                    KyomuCoursePeriod(day: .friday, start: 1, end: 2, location: "G1-103 (G114)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.H503",
                ocwId: "202504723",
                teachers: ["Shinozaki Takahiro"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[4],
            KyomuCourse(
                name: "Virtual Reality and Interaction",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "J2-203 (J221)"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "J2-203 (J221)"),
                ],
                year: 2025,
                quarters: [1],
                code: "ICT.H507",
                ocwId: "202504726",
                teachers: ["Hasegawa Shoichi"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[5],
            KyomuCourse(
                name: "Human-Centric Information Systems I",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "G5-105 (G511)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "G5-105 (G511)"),
                ],
                year: 2025,
                quarters: [2],
                code: "ICT.A406",
                ocwId: "202504680",
                teachers: ["Funakoshi Kotaro, Koike Yasuharu, Yamaguchi Masahiro et al."],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[6],
            KyomuCourse(
                name: "Solving Social Issues with Cutting-Edge Technology",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 3, end: 4, location: "G1-103 (G114)"),
                ],
                year: 2025,
                quarters: [2],
                code: "ICT.D401.L (ESD.E407)",
                ocwId: "202534821",
                teachers: ["Nakatani Momoko, Yamaguchi Masahiro, ※Kondo Takashi"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[7],
            KyomuCourse(
                name: "Wireless Signal Processing",
                periods: [
                    KyomuCoursePeriod(day: .tuesday, start: 3, end: 4, location: "S3-215(S321)"),
                    KyomuCoursePeriod(day: .friday, start: 3, end: 4, location: "S3-215(S321)"),
                ],
                year: 2025,
                quarters: [2],
                code: "ICT.S407",
                ocwId: "202504673",
                teachers: ["Fukawa Kazuhiko"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[8],
            KyomuCourse(
                name: "Essence of Humanities and Social Sciences20:Western Thought 1",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 3, end: 4, location: "G2-201(G223)"),
                ],
                year: 2025,
                quarters: [2],
                code: "LAH.S420-01",
                ocwId: "202508468",
                teachers: ["Bektas Yakup"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[9],
            KyomuCourse(
                name: "Master's Career Development Basics B",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 5, end: 6, location: ""),
                ],
                year: 2025,
                quarters: [2],
                code: "ENT.C401-04",
                ocwId: "202536241",
                teachers: ["Wakayama Koji, Izumi Akira, Ito Sachiko et al."],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[10],
            KyomuCourse(
                name: "TOEFL Seminar 14 1",
                periods: [
                    KyomuCoursePeriod(day: .wednesday, start: 7, end: 8, location: "M-155(H1104)"),
                ],
                year: 2025,
                quarters: [2],
                code: "LAE.E452-01",
                ocwId: "202503675",
                teachers: ["De Ferranti Hugh Barry Ziani"],
                isValid: true,
                isForm8: false
            )
        )
        
        XCTAssertEqual(
            resultEn[11],
            KyomuCourse(
                name: "Seminar in Information and Communications Engineering S1",
                periods: [],
                year: 2025,
                quarters: [1, 2],
                code: "ICT.Z491",
                ocwId: "202504683",
                teachers: ["Academic Supervisor"],
                isValid: true,
                isForm8: false
            )
        )
    }
    
    func testParseReportCheckPageWhenTemporarySaveJa() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlJa = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultTemporarySaveJapanese", withExtension: "html")!)
        let resultJa = try titechkyomu.parseReportCheckPage(html: htmlJa)
        
        XCTAssertEqual(
            resultJa[0],
            KyomuCourse(
                name: "情報通信工学統合論基礎",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S4-201(S421)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S4-201(S421)"),
                ],
                year: 2024,
                quarters: [1],
                code: "ICT.A435",
                ocwId: "202536673",
                teachers: ["佐々木 広, ISLAM A K M MAHFUZUL, 一色 剛 他"],
                isValid: true,
                isForm8: false
            )
        )
    }

    func testParseReportCheckPageWhenTemporarySaveEn() throws {
        let titechkyomu = TitechKyomu(urlSession: .shared)
        let htmlEn = try! String(contentsOf: Bundle.module.url(forResource: "ReportCheckResultTemporarySaveEnglish", withExtension: "html")!)
        let resultEn = try titechkyomu.parseReportCheckPage(html: htmlEn)
        
        XCTAssertEqual(
            resultEn[0],
            KyomuCourse(
                name: "Communications and Computer Engineering - Fundamentals",
                periods: [
                    KyomuCoursePeriod(day: .monday, start: 1, end: 2, location: "S4-201(S421)"),
                    KyomuCoursePeriod(day: .thursday, start: 1, end: 2, location: "S4-201(S421)"),
                ],
                year: 2024,
                quarters: [1],
                code: "ICT.A435",
                ocwId: "202536673",
                teachers: ["Sasaki Hiroshi, Islam A K M Mahfuzul, Isshiki Tsuyoshi et al."],
                isValid: true,
                isForm8: false
            )
        )
    }
}
