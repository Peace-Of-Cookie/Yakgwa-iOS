// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyPageScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MyPageScene",
            targets: ["MyPageScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
    ],
    targets: [
        .target(
            name: "MyPageScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "MyPageSceneTests",
            dependencies: ["MyPageScene"]),
    ]
)
