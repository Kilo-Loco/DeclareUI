// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeclareUI",
    products: [
        .library(
            name: "DeclareUI",
            targets: ["DeclareUI"]
        )
    ],
    targets: [
        .target(
            name: "DeclareUI",
            path: "Source"
        ),
        .testTarget(
            name: "DeclareUITests",
            dependencies: ["DeclareUI"],
            path: "Tests"
        ),
    ]
)
