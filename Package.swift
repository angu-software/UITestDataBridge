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
        .library(
            name: "XCTestDataBridge",
            targets: ["XCTestDataBridge"]
        ),
    ],
    targets: [
        .target(
            name: "UITestDataBridge"
        ),
        .target(
            name: "XCTestDataBridge",
            dependencies: ["UITestDataBridge"]
        ),
        .testTarget(
            name: "UITestDataBridgeTests",
            dependencies: ["UITestDataBridge"]
        ),
    ]
)
