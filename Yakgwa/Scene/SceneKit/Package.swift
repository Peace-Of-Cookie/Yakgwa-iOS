// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SceneKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SceneKit",
            targets: ["SceneKit"]),
    ],
    targets: [
        .target(
            name: "SceneKit"),
        .testTarget(
            name: "SceneKitTests",
            dependencies: ["SceneKit"]),
    ]
)
