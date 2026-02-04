// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UITestDataBridge",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
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
