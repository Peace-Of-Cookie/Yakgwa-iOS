// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CreateAppointmentScene",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "InputAppointmentInfoScene",
            targets: ["InputAppointmentInfoScene"]),
        .library(
            name: "SelectAppointmentThemeScene",
            targets: ["SelectAppointmentThemeScene"]),
        .library(
            name: "AddAppointmentLocationScene",
            targets: ["AddAppointmentLocationScene"]),
        .library(
            name: "SelectAppointmentDateScene",
            targets: ["SelectAppointmentDateScene"]),
    ],
    dependencies: [
        .package(path: "./CoreKit"),
    ],
    targets: [
        .target(
            name: "InputAppointmentInfoScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .target(
            name: "SelectAppointmentThemeScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .target(
            name: "AddAppointmentLocationScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .target(
            name: "SelectAppointmentDateScene",
            dependencies: [
                .product(name: "CoreKit", package: "CoreKit")
            ]
        ),
        .testTarget(
            name: "InputAppointmentInfoSceneTests",
            dependencies: ["InputAppointmentInfoScene"]),
        .testTarget(
            name: "SelectAppointmentThemeSceneTests",
            dependencies: ["SelectAppointmentThemeScene"]),
        .testTarget(
            name: "AddAppointmentLocationSceneTests",
            dependencies: ["AddAppointmentLocationScene"]),
        .testTarget(
            name: "SelectAppointmentDateSceneTests",
            dependencies: ["SelectAppointmentDateScene"])
    ]
)
