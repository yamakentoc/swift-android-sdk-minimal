# swift-android-sdk-minimal

Minimal sample for sharing a Swift package with iOS and Android, then calling it from Android with Swift SDK for Android and `swift-java`.

## Structure

```text
android-app/        Android app that calls the Swift library through generated Java wrappers
hello-lib/          Shared Swift package used directly by iOS
hello-lib/android/  Android-only Swift package and Gradle module for building the AAR
ios-app/            iOS app that imports the shared Swift package
```

## Swift API

`hello-lib` exposes a simple Swift function:

```swift
public func greeting() -> String {
    "Hello from Swift!"
}
```

The iOS app imports `HelloLib` directly. The Android app calls the generated Java wrapper:

```kotlin
import com.example.hellolib.HelloLib

val message = HelloLib.greeting()
```

## Requirements

- Swift 6.3.2
- Swift SDK for Android `swift-6.3.2-RELEASE_android`
- Android SDK / NDK
- `org.swift.swiftkit:swiftkit-core:1.0-SNAPSHOT` published to Maven Local

If `swiftkit-core` is not available locally:

```bash
cd hello-lib/android
swift package resolve
./.build/checkouts/swift-java/gradlew --project-dir .build/checkouts/swift-java :SwiftKitCore:publishToMavenLocal
```

## Build

Test the shared Swift package:

```bash
cd hello-lib
swift test
```

Build the Android app:

```bash
cd android-app
./gradlew :app:assembleDebug
```

Build the iOS app:

```bash
xcodebuild -project ios-app/HelloiOS/HelloiOS.xcodeproj -scheme HelloiOS -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
```

The Swift library AAR is produced at:

```text
hello-lib/android/build/outputs/aar/hello-lib-debug.aar
```
