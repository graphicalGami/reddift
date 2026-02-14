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
            name: "reddiftObjC",
            path: "reddift/vendor/Google",
            publicHeadersPath: "."
        ),
        .target(
            name: "reddift",
            dependencies: ["reddiftObjC"],
            path: "reddift",
            exclude: ["vendor/Google"]
        ),
    ]
)
