// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "CoreKit",
            targets: ["CoreKit"]),
    ],
    dependencies: [
        .package(path: "./DesignSystem"),
        .package(path: "./Network"),
        .package(path: "./Local"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", .upToNextMajor(from: "3.0.0"))
    ],
    targets: [
        .target(
            name: "CoreKit",
            dependencies: [
                .product(name: "DesignSystem", package: "DesignSystem"),
                .product(name: "Network", package: "Network"),
                .product(name: "ReactorKit", package: "ReactorKit"),
                .product(name: "Local", package: "Local")
            ]
        ),
        .testTarget(
            name: "CoreKitTests",
            dependencies: ["CoreKit"]),
    ]
)
