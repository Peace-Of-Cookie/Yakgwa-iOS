// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoteScene",
    products: [
        .library(
            name: "VoteScene",
            targets: ["VoteScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
    ],
    targets: [
        .target(
            name: "VoteScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "VoteSceneTests",
            dependencies: ["VoteScene"]),
    ]
)
