// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Network",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Network",
            targets: ["Network"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: [
                .product(name: "RxMoya", package: "Moya"),
                .product(name: "RxSwift", package: "RxSwift")
            ]
        ),
        .testTarget(
            name: "NetworkTests",
            dependencies: ["Network"]),
    ]
)
