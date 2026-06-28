// swift-tools-version: 6.3

import CompilerPluginSupport
import Foundation
import PackageDescription

let enableJExtract = ProcessInfo.processInfo.environment["HELLOLIB_ENABLE_JEXTRACT"] == "1"

var dependencies: [Package.Dependency] = []
var helloLibDependencies: [Target.Dependency] = []
var helloLibPlugins: [Target.PluginUsage] = []

if enableJExtract {
    dependencies.append(
        .package(url: "https://github.com/swiftlang/swift-java", exact: "0.4.2")
    )
    helloLibDependencies.append(
        .product(name: "SwiftJava", package: "swift-java")
    )
    helloLibPlugins.append(
        .plugin(name: "JExtractSwiftPlugin", package: "swift-java")
    )
}

let package = Package(
    name: "HelloLib",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "HelloLib",
            type: .dynamic,
            targets: ["HelloLib"]
        ),
    ],
    dependencies: dependencies,
    targets: [
        .target(
            name: "HelloLib",
            dependencies: helloLibDependencies,
            exclude: ["swift-java.config"],
            plugins: helloLibPlugins
        ),
        .testTarget(
            name: "HelloLibTests",
            dependencies: ["HelloLib"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
