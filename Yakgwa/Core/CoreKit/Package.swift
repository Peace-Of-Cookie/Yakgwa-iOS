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
    targets: [
        .target(
            name: "CoreKit"),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"]),
    ]
)
