load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@rules_apple_line//apple:objc_library.bzl", "objc_library")

objc_library(
    name = "Lib1",
    enable_modules = True,
    srcs = glob([
        "Lib1/**/*.m",
    ]),
    hdrs = glob(["Lib1/**/*.h"]),
    umbrella_header = "Lib1/Lib1.h",
    deps = [
        "//Modules/TVLKit:TVLKit",
    ],
    data = [
        ":Lib1ResourceBundle",
    ],
    sdk_frameworks = [
        "UIKit",
    ],
)

objc_library(
    name = "Lib1Tests",
    enable_modules = True,
    testonly = True,
    srcs = glob([
        "Tests/**/*.m",
    ]),
    data = [
        ":Lib1TestsResource"
    ],
    deps = [
        ":Lib1",
    ] + [
        "//Pods/Expecta:Expecta",
        "//Pods/OCMock:OCMock",
        "//Pods/Quick:Quick",
        "//Pods/Nimble:Nimble",
        "//Pods/Specta:Specta",
    ]
)

filegroup(
    name = "Lib1TestsResource",
    srcs = glob([
        "**/*.json"
    ]),
)

ios_unit_test(
    name = "Lib1TestsBundle",
    minimum_os_version = "11.0",
    deps = [
        ":Lib1Tests"
    ]
)

# Resources
apple_resource_bundle(
    name = "Lib1ResourceBundle",
    bundle_name = "Lib1Resources",
    infoplists = [
        'Lib1Resources/Info.plist'
    ],
    resources = glob([
        "Lib1Resources/Images.xcassets/**",
        "Lib1Resources/**/*.xib",
        "Lib1/**/*.xib"
    ])
)
