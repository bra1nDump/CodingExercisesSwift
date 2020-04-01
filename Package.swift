// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodeChef",
    products: [
        .library(
            name: "Problems", 
            targets: ["Problems"])
    ],
    targets: [
        .target(
            name: "CodeChef",
            dependencies: ["Problems"]),
        .target(
            name: "Problems",
            dependencies: []),
        .testTarget(
            name: "ProblemsTests",
            dependencies: ["Problems"]),
    ]
)
