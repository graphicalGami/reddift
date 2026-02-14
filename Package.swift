// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "reddift",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "reddift", targets: ["reddift"]),
    ],
    targets: [
        .target(
            name: "reddift",
            path: "reddift",         // source files live here
            exclude: []
        ),
    ]
)
