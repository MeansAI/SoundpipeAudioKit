// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoundpipeAudioKit",
    platforms: [.macOS(.v14), .iOS(.v17), .tvOS(.v17), .visionOS(.v1)],
    products: [.library(name: "SoundpipeAudioKit", targets: ["SoundpipeAudioKit"])],
    dependencies: [
        .package(url: "https://github.com/AudioKit/KissFFT", from: "1.0.0"),
        .package(url: "https://github.com/MeansAI/AudioKit", branch: "main"),
        .package(url: "https://github.com/MeansAI/AudioKitEX", branch: "main"),
        .package(url: "https://github.com/AudioKit/Tonic", from: "2.0.0"),
    ],
    targets: [
        .target(name: "Soundpipe",
                dependencies: ["KissFFT"],
                exclude: ["lib/inih/LICENSE.txt"],
                cSettings: [
                    .headerSearchPath("lib/inih"),
                    .headerSearchPath("Sources/soundpipe/lib/inih"),
                    .headerSearchPath("modules"),
                    .headerSearchPath("external"),
                ]),
        .target(name: "SoundpipeAudioKit", dependencies: ["AudioKit", "AudioKitEX", "CSoundpipeAudioKit", "Tonic"]),
        .target(name: "CSoundpipeAudioKit", dependencies: ["AudioKit", "AudioKitEX", "Soundpipe"]),
        .testTarget(name: "SoundpipeAudioKitTests", dependencies: ["SoundpipeAudioKit", "Tonic"], resources: [.copy("TestResources/")]),
        .testTarget(name: "CSoundpipeAudioKitTests", dependencies: ["CSoundpipeAudioKit"]),
    ],
    cxxLanguageStandard: .cxx14
)
