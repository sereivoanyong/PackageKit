// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "PackageKit",
  platforms: [.iOS(.v10)],
  products: [
    .library(name: "LocalizationKit", targets: ["LocalizationKit"]),
    .library(name: "MagazineKit", targets: ["MagazineKit"]),
  ],
  dependencies: [
    .package(url: "https://github.com/sereivoanyong/MagazineLayout", .branch("master")),
  ],
  targets: [
    .target(name: "LocalizationKit", dependencies: [], path: "Sources/LocalizationKit"),
    .target(name: "MagazineKit", dependencies: ["MagazineLayout"], path: "Sources/MagazineKit"),
  ],
  swiftLanguageVersions: [.v5]
)
