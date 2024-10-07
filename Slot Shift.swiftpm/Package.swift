// swift-tools-version: 5.9

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Slot Shift",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Slot Shift",
            targets: ["AppModule"],
            bundleIdentifier: "de.tobiaspott.playground.slotshift",
            teamIdentifier: "LR2W97LX43",
            displayVersion: "0.3",
            bundleVersion: "12",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.brown),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .puzzleGames
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        )
    ]
)
