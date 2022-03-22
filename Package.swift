// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoundationEncore",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "FoundationEncore", targets: ["FoundationEncore"]),
    ],
    targets: [
        .target(name: "FoundationEncore", dependencies: [
            .target(name: "DateTimeOnly"),
            .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
            .target(name: "Knowable"),
            .product(name: "LegibleError", package: "LegibleError"),
            .product(name: "MobileProvision", package: "MobileProvision", condition: .when(platforms: [.iOS, .macOS, .tvOS])),
            .product(name: "PeriodDuration", package: "PeriodDuration"),
            .product(name: "PhoneNumberKit", package: "PhoneNumberKit"),
            .product(name: "PreciseDecimal", package: "PreciseDecimal"),
            .product(name: "SwiftEncore", package: "swift-encore"),
            .product(name: "Version", package: "Version"),
        ]),
        .testTarget(name: "FoundationEncoreTests", dependencies: [
            .target(name: "FoundationEncore"),
        ]),

        .target(name: "DateTimeOnly"),
        .testTarget(name: "DateTimeOnlyTests", dependencies: [
            .target(name: "DateTimeOnly"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ]),

        .target(name: "Knowable"),
        .testTarget(name: "KnowableTests", dependencies: [
            .target(name: "Knowable"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ]),
    ]
)

package.dependencies = [
    .package(url: "https://github.com/mxcl/LegibleError", from: "1.0.6"),
    .package(url: "https://github.com/CrazyFanFan/MobileProvision", from: "0.0.2"),
    .package(url: "https://github.com/davdroman/PeriodDuration", from: "0.2.0"),
    .package(url: "https://github.com/davdroman/PhoneNumberKit", branch: "master"),
    .package(url: "https://github.com/davdroman/PreciseDecimal", branch: "main"),
    .package(url: "https://github.com/rythmico/swift-encore", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "0.3.2"),
    .package(url: "https://github.com/mxcl/Version", from: "2.0.1"),
    .package(url: "https://github.com/davdroman/XCTJSONKit", branch: "main"),
]
