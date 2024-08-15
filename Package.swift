// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TitechKyomuKit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TitechKyomuKit",
            targets: ["TitechKyomuKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "5.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TitechKyomuKit",
            dependencies: ["Kanna"]),
        .testTarget(
            name: "TitechKyomuKitTests",
            dependencies: ["TitechKyomuKit"],
            resources: [
                .process("HTML"),
            ]),
    ]
)
