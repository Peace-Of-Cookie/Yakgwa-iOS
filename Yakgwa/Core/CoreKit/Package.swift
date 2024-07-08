// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreKit",
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]),
    ],
    dependencies: [
        .package(path: "./DesignSystem"),
        .package(path: "./Network")
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Network", package: "Network")
            ]
        ),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"]),
    ]
)
