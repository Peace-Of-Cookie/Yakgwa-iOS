// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "LoginScene",
            targets: ["LoginScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit")
    ],
    targets: [
        .target(
            name: "LoginScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "LoginSceneTests",
            dependencies: ["LoginScene"]),
    ]
)
