load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@rules_apple_line//apple:objc_library.bzl", "objc_library")

objc_library(
    name = "SharedLib1",
    enable_modules = True,
    srcs = glob([
        "SharedLib1/**/*.m",
    ]),
    hdrs = glob(["SharedLib1/**/*.h"]),
    umbrella_header = "SharedLib1/SharedLib1.h",
    deps = [
        "//Modules/TVLKit:TVLKit",
    ],
    data = [
        ":SharedLib1ResourceBundle",
    ],
    sdk_frameworks = [
        "UIKit",
    ],
)

objc_library(
    name = "SharedLib1Tests",
    enable_modules = True,
    testonly = True,
    srcs = glob([
        "Tests/**/*.m",
    ]),
    data = [
        ":SharedLib1TestsResource"
    ],
    deps = [
        ":SharedLib1",
    ] + [
        "//Pods/Expecta:Expecta",
        "//Pods/OCMock:OCMock",
        "//Pods/Quick:Quick",
        "//Pods/Nimble:Nimble",
        "//Pods/Specta:Specta",
    ]
)

filegroup(
    name = "SharedLib1TestsResource",
    srcs = glob([
        "**/*.json"
    ]),
)

ios_unit_test(
    name = "SharedLib1TestsBundle",
    minimum_os_version = "11.0",
    deps = [
        ":SharedLib1Tests"
    ]
)

# Resources
apple_resource_bundle(
    name = "SharedLib1ResourceBundle",
    bundle_name = "SharedLib1Resources",
    infoplists = [
        'SharedLib1Resources/Info.plist'
    ],
    resources = glob([
        "SharedLib1Resources/Images.xcassets/**",
        "SharedLib1Resources/**/*.xib",
        "SharedLib1/**/*.xib"
    ])
)
