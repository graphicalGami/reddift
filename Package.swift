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
        //.package(url: "https://github.com/sonsongithub/HTMLSpecialCharacters.git", from: "1.0.0"),
        //.package(url: "https://github.com/timpickles/MiniKeychain.git", branch: "master")
		// xtool disables automatic package resolution, so specify rev until that is fixed
		.package(url: "https://github.com/sonsongithub/HTMLSpecialCharacters.git", revision: "7797f4cca9f19c54436ad7470222130227cba98d"),
        .package(url: "https://github.com/timpickles/MiniKeychain.git", revision: "9ff7178f1f1369f2f4b2f72be97a0aa903ad5bc7")
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
