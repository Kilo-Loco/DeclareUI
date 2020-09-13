// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "DeclareUI",
    platforms: [.iOS(.v10)],
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
