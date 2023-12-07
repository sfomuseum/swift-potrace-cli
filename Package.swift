// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "potrace",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.3"),
        .package(url: "https://github.com/sfomuseum/swift-coregraphics-image", from: "1.0.0"),
        // .package(url: "https://github.com/sfomuseum/swift-text-emboss", from: "0.0.3"),
        // .package(name: "swift-potrace", path: "/usr/local/sfomuseum/swift-potrace")
    ],
    targets: [
        .executableTarget(
            name: "potrace",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                // .product(name: "Potrace", package: "swift-potrace"),
                .product(name: "CoreGraphicsImage", package: "swift-coregraphics-image")
            ]),
    ]
)
