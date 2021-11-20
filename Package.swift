// swift-tools-version:5.5
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
        .library(name: "AnyEquatable", targets: ["AnyEquatable"]),
        .library(name: "Builders", targets: ["Builders"]),
        .library(name: "DateTimeOnly", targets: ["DateTimeOnly"]),
        .library(name: "Doo", targets: ["Doo"]),
        .library(name: "EnumTag", targets: ["EnumTag"]),
        .library(name: "Knowable", targets: ["Knowable"]),
        .library(name: "NilGuardingOperators", targets: ["NilGuardingOperators"]),
        .library(name: "UnwrapTuple", targets: ["UnwrapTuple"]),
    ],
    targets: [
        .target(name: "FoundationEncore", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .target(name: "AnyEquatable"),
            .target(name: "Builders"),
            .product(name: "CasePaths", package: "swift-case-paths"),
            .product(name: "CustomDump", package: "swift-custom-dump"),
            .target(name: "DateTimeOnly"),
            .target(name: "Doo"),
            .target(name: "EnumTag"),
            .target(name: "Knowable"),
            .product(name: "LegibleError", package: "LegibleError"),
            .product(name: "MobileProvision", package: "MobileProvision", condition: .when(platforms: [.iOS, .macOS, .tvOS])),
            .target(name: "NilGuardingOperators"),
            .product(name: "NonEmpty", package: "swift-nonempty"),
            .product(name: "PeriodDuration", package: "PeriodDuration"),
            .product(name: "PhoneNumberKit", package: "PhoneNumberKit"),
            .product(name: "PreciseDecimal", package: "PreciseDecimal"),
            .product(name: "Tagged", package: "swift-tagged"),
            .target(name: "UnwrapTuple"),
            .product(name: "Version", package: "Version"),
        ]),
        .testTarget(name: "FoundationEncoreTests", dependencies: [
            .target(name: "FoundationEncore"),
        ]),

        .target(name: "AnyEquatable"),
        .testTarget(name: "AnyEquatableTests", dependencies: [
            .target(name: "AnyEquatable"),
        ]),

        .target(name: "Builders"),
        .testTarget(name: "BuildersTests", dependencies: [
            .target(name: "Builders"),
        ]),

        .target(name: "DateTimeOnly"),
        .testTarget(name: "DateTimeOnlyTests", dependencies: [
            .target(name: "DateTimeOnly"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ]),

        .target(name: "Doo", exclude: ["Doo.swift.gyb"]),
        .testTarget(name: "DooTests", dependencies: [
            .target(name: "Doo"),
        ]),

        .target(name: "EnumTag"),

        .target(name: "Knowable"),
        .testTarget(name: "KnowableTests", dependencies: [
            .target(name: "Knowable"),
            .product(name: "XCTJSONKit", package: "XCTJSONKit"),
        ]),

        .target(name: "NilGuardingOperators"),
        .testTarget(name: "NilGuardingOperatorsTests", dependencies: [
            .target(name: "NilGuardingOperators"),
            .product(name: "CwlPreconditionTesting", package: "CwlPreconditionTesting", condition: .when(platforms: [.iOS, .macOS])),
        ]),

        .target(name: "UnwrapTuple", exclude: ["UnwrapTuple.swift.gyb"]),
    ]
)

package.dependencies = [
    .package(name: "CwlPreconditionTesting", url: "https://github.com/mattgallagher/CwlPreconditionTesting", from: "2.0.2"),
    .package(name: "LegibleError", url: "https://github.com/mxcl/LegibleError", from: "1.0.6"),
    .package(name: "MobileProvision", url: "https://github.com/CrazyFanFan/MobileProvision", branch: "master"),
    .package(name: "PeriodDuration", url: "https://github.com/davdroman/PeriodDuration", from: "0.2.0"),
    .package(name: "PhoneNumberKit", url: "https://github.com/davdroman/PhoneNumberKit", branch: "davdroman-improvements"),
    .package(name: "PreciseDecimal", url: "https://github.com/davdroman/PreciseDecimal", from: "1.0.0"),
    .package(name: "swift-algorithms", url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    .package(name: "swift-case-paths", url: "https://github.com/pointfreeco/swift-case-paths", from: "0.7.0"),
    .package(name: "swift-custom-dump", url: "https://github.com/pointfreeco/swift-custom-dump", from: "0.2.1"),
    .package(name: "swift-nonempty", url: "https://github.com/pointfreeco/swift-nonempty", from: "0.3.1"),
    .package(name: "swift-tagged", url: "https://github.com/pointfreeco/swift-tagged", from: "0.6.0"),
    .package(name: "Version", url: "https://github.com/mxcl/Version", from: "2.0.1"),
    .package(name: "XCTJSONKit", url: "https://github.com/davdroman/XCTJSONKit", branch: "main"),
]
