// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UITestDataBridge",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "UITestDataBridge",
            targets: ["UITestDataBridge"]
        ),
    ],
    targets: [
        .target(
            name: "UITestDataBridge"
        ),
        .testTarget(
            name: "UITestDataBridgeTests",
            dependencies: ["UITestDataBridge"]
        ),
    ]
)
