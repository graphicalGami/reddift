// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "reddift",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "reddift",
            targets: ["reddift"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/sonsongithub/HTMLSpecialCharacters.git", from: "1.0.0"),
        .package(url: "https://github.com/timpickles/MiniKeychain.git", branch: "master")
    ],
    targets: [
        .target(
            name: "reddift",
            dependencies: [
                .product(name: "HTMLSpecialCharacters", package: "HTMLSpecialCharacters"),
                .product(name: "MiniKeychain", package: "MiniKeychain"),
            ],
            path: "framework",
            sources: ["."]
        )
    ]
)
