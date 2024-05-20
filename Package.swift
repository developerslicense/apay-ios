// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
        name: "AirbaPay",
        platforms: [
            .iOS(.v14),
        ],
        products: [
            // Products define the executables and libraries a package produces, making them visible to other packages.
            .library(
                    name: "AirbaPay",
                    targets: ["AirbaPay"]
            )
        ],
        dependencies: [
            .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.8.0")),
            .package(url: "https://github.com/sanzaru/SimpleToast.git", from: "0.0.1"),
            .package(url: "https://github.com/finn-no/BottomSheet.git", from: "5.2.0")
        ],
        targets: [
            // Targets are the basic building blocks of a package, defining a module or a test suite.
            // Targets can depend on other targets in this package and products from dependencies.
            .target(
                    name: "AirbaPay",
                    dependencies: [
                        "Alamofire", "SimpleToast", "FINNBottomSheet"
                    ],
                    resources: [
                        .process("resources"),
                    ]
            ),
            .testTarget(
                    name: "AirbaPayTests",
                    dependencies: ["AirbaPay"])
        ]
)
