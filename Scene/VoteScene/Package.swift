// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VoteScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "VoteScene",
            targets: ["VoteScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./AddCandidateLocationScene")
    ],
    targets: [
        .target(
            name: "VoteScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "AddCandidateLocationScene", package: "AddCandidateLocationScene")
            ]
        ),
        .testTarget(
            name: "VoteSceneTests",
            dependencies: ["VoteScene"]),
    ]
)
