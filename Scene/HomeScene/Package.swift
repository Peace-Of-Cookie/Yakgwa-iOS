// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "HomeScene",
            targets: ["HomeScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
        .package(path: "./CreateAppointmentScene")
    ],
    targets: [
        .target(
            name: "HomeScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit"),
                .product(name: "InputAppointmentInfoScene", package: "CreateAppointmentScene")
            ],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "HomeSceneTests",
            dependencies: ["HomeScene"]),
    ]
)
