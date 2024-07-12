// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SplashScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "SplashScene",
            targets: ["SplashScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit")
    ],
    targets: [
        .target(
            name: "SplashScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "SplashSceneTests",
            dependencies: ["SplashScene"]),
    ]
)
