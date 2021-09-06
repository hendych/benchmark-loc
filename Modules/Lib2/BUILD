load("@build_bazel_rules_apple//apple:ios.bzl", "ios_unit_test")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@rules_apple_line//apple:objc_library.bzl", "objc_library")

objc_library(
    name = "Lib2",
    enable_modules = True,
    srcs = glob([
        "Lib2/**/*.m",
    ]),
    hdrs = glob(["Lib2/**/*.h"]),
    umbrella_header = "Lib2/Lib2.h",
    deps = [
        "//Modules/TVLKit:TVLKit",
    ],
    data = [
        ":Lib2ResourceBundle",
    ],
    sdk_frameworks = [
        "UIKit",
    ],
)

objc_library(
    name = "Lib2Tests",
    enable_modules = True,
    testonly = True,
    srcs = glob([
        "Tests/**/*.m",
    ]),
    data = [
        ":Lib2TestsResource"
    ],
    deps = [
        ":Lib2",
    ] + [
        "//Pods/Expecta:Expecta",
        "//Pods/OCMock:OCMock",
        "//Pods/Quick:Quick",
        "//Pods/Nimble:Nimble",
        "//Pods/Specta:Specta",
    ]
)

filegroup(
    name = "Lib2TestsResource",
    srcs = glob([
        "**/*.json"
    ]),
)

ios_unit_test(
    name = "Lib2TestsBundle",
    minimum_os_version = "11.0",
    deps = [
        ":Lib2Tests"
    ]
)

# Resources
apple_resource_bundle(
    name = "Lib2ResourceBundle",
    bundle_name = "Lib2Resources",
    infoplists = [
        'Lib2Resources/Info.plist'
    ],
    resources = glob([
        "Lib2Resources/Images.xcassets/**",
        "Lib2Resources/**/*.xib",
        "Lib2/**/*.xib"
    ])
)
