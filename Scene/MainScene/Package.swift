// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MainScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MainScene",
            targets: ["MainScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
    ],
    targets: [
        .target(
            name: "MainScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "MainSceneTests",
            dependencies: ["MainScene"]),
    ]
)
