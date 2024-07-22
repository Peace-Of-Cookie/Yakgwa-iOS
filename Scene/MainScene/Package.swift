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
        .package(path: "./HomeScene"),
        .package(path: "./MyPageScene")
    ],
    targets: [
        .target(
            name: "MainScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "HomeScene", package: "HomeScene"),
                .product(name: "MyPageScene", package: "MyPageScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "MainSceneTests",
            dependencies: ["MainScene"]),
    ]
)
