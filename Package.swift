// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "PackageKit",
  platforms: [
    .iOS(.v10)
  ],
  products: [
    .library(name: "MagazineKit", targets: ["MagazineKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/sereivoanyong/MagazineLayout", .branch("master"))
  ],
  targets: [
    .target(name: "MagazineKit", dependencies: ["MagazineLayout"])
  ]
)
