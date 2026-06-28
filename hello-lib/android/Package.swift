// swift-tools-version: 6.3

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
            exclude: ["swift-java.config"],
            plugins: [
                .plugin(name: "JExtractSwiftPlugin", package: "swift-java"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
