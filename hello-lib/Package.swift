// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "HelloLib",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "HelloLib",
            type: .dynamic,
            targets: ["HelloLib"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-java", exact: "0.4.2"),
    ],
    targets: [
        .target(
            name: "HelloLib",
            dependencies: [
                .product(name: "SwiftJava", package: "swift-java"),
            ],
            plugins: [
                .plugin(name: "JExtractSwiftPlugin", package: "swift-java"),
            ]
        ),
        .testTarget(
            name: "HelloLibTests",
            dependencies: ["HelloLib"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
