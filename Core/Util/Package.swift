// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Util",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Util",
            targets: ["Util"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Util",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "UtilTests",
            dependencies: ["Util"]),
    ]
)
