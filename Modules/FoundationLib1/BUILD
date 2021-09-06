load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@rules_apple_line//apple:objc_library.bzl", "objc_library")

objc_library(
    name = "FoundationLib1",
    enable_modules = True,
    srcs = glob([
        "FoundationLib1/**/*.m",
    ]),
    hdrs = glob(["FoundationLib1/**/*.h"]),
    umbrella_header = "FoundationLib1/FoundationLib1.h",
    deps = [
        "//Modules/TVLKit:TVLKit",
    ],
    data = [
        ":FoundationLib1ResourceBundle",
    ],
    sdk_frameworks = [
        "UIKit",
    ],
)

objc_library(
    name = "FoundationLib1Tests",
    enable_modules = True,
    testonly = True,
    srcs = glob([
        "Tests/**/*.m",
    ]),
    data = [
        ":FoundationLib1TestsResource"
    ],
    deps = [
        ":FoundationLib1",
    ] + [
        "//Pods/Expecta:Expecta",
        "//Pods/OCMock:OCMock",
        "//Pods/Quick:Quick",
        "//Pods/Nimble:Nimble",
        "//Pods/Specta:Specta",
    ]
)

filegroup(
    name = "FoundationLib1TestsResource",
    srcs = glob([
        "**/*.json"
    ]),
)

ios_unit_test(
    name = "FoundationLib1TestsBundle",
    minimum_os_version = "11.0",
    deps = [
        ":FoundationLib1Tests"
    ]
)

# Resources
apple_resource_bundle(
    name = "FoundationLib1ResourceBundle",
    bundle_name = "FoundationLib1Resources",
    infoplists = [
        'FoundationLib1Resources/Info.plist'
    ],
    resources = glob([
        "FoundationLib1Resources/Images.xcassets/**",
        "FoundationLib1Resources/**/*.xib",
        "FoundationLib1/**/*.xib"
    ])
)
