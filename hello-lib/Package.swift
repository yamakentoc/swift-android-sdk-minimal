// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "HelloLib",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "HelloLib",
            targets: ["HelloLib"]
        ),
    ],
    targets: [
        .target(
            name: "HelloLib",
            exclude: ["swift-java.config"]
        ),
        .testTarget(
            name: "HelloLibTests",
            dependencies: ["HelloLib"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
