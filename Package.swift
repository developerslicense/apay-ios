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
            .package(url: "https://github.com/alexdremov/PathPresenter.git", from: "1.1.3")
        ],
        targets: [
            // Targets are the basic building blocks of a package, defining a module or a test suite.
            // Targets can depend on other targets in this package and products from dependencies.
            .target(
                    name: "AirbaPay",
                    dependencies: [
                        "Alamofire", "PathPresenter", "SimpleToast"
                    ],
                    resources: [
                        .process("Sources/ui/resources/**"),
                    ]
            ),
            .testTarget(
                    name: "AirbaPayTests",
                    dependencies: ["AirbaPay"])
        ]
)
