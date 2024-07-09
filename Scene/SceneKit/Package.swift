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
    dependencies: [
        .package(path: "./LoginScene")
    ],
    targets: [
        .target(
            name: "SceneKit",
            dependencies: [
                .product(name: "LoginScene", package: "LoginScene")
            ]
        ),
        .testTarget(
            name: "SceneKitTests",
            dependencies: ["SceneKit"]),
    ]
)
