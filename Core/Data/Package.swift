// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Data",
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "./Network"),
        .package(path: "./Local"),
        .package(path: "./Domain")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                .product(name: "Network", package: "Network"),
                .product(name: "Local", package: "Local"),
                .product(name: "Domain", package: "Domain")
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]),
    ]
)
