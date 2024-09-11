// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AddCandidateLocationScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AddCandidateLocationScene",
            targets: ["AddCandidateLocationScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./Domain"),
        .package(path: "./Data")
    ],
    targets: [
        .target(
            name: "AddCandidateLocationScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Data", package: "Data")
            ]
        ),
        .testTarget(
            name: "AddCandidateLocationSceneTests",
            dependencies: ["AddCandidateLocationScene"]),
    ]
)
