load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@rules_apple_line//apple:objc_library.bzl", "objc_library")

objc_library(
    name = "FoundationLib2",
    enable_modules = True,
    srcs = glob([
        "FoundationLib2/**/*.m",
    ]),
    hdrs = glob(["FoundationLib2/**/*.h"]),
    umbrella_header = "FoundationLib2/FoundationLib2.h",
    deps = [
        "//Modules/TVLKit:TVLKit",
    ],
    data = [
        ":FoundationLib2ResourceBundle",
    ],
    sdk_frameworks = [
        "UIKit",
    ],
)

objc_library(
    name = "FoundationLib2Tests",
    enable_modules = True,
    testonly = True,
    srcs = glob([
        "Tests/**/*.m",
    ]),
    data = [
        ":FoundationLib2TestsResource"
    ],
    deps = [
        ":FoundationLib2",
    ] + [
        "//Pods/Expecta:Expecta",
        "//Pods/OCMock:OCMock",
        "//Pods/Quick:Quick",
        "//Pods/Nimble:Nimble",
        "//Pods/Specta:Specta",
    ]
)

filegroup(
    name = "FoundationLib2TestsResource",
    srcs = glob([
        "**/*.json"
    ]),
)

ios_unit_test(
    name = "FoundationLib2TestsBundle",
    minimum_os_version = "11.0",
    deps = [
        ":FoundationLib2Tests"
    ]
)

# Resources
apple_resource_bundle(
    name = "FoundationLib2ResourceBundle",
    bundle_name = "FoundationLib2Resources",
    infoplists = [
        'FoundationLib2Resources/Info.plist'
    ],
    resources = glob([
        "FoundationLib2Resources/Images.xcassets/**",
        "FoundationLib2Resources/**/*.xib",
        "FoundationLib2/**/*.xib"
    ])
)
