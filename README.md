# swift-android-sdk-minimal

Minimal sample for sharing one Swift package with iOS and Android, then calling it from Android with Swift SDK for Android and `swift-java`.

## Structure

```text
android-app/  Android app that calls the Swift library through generated Java wrappers
hello-lib/    Single Swift package, single target, and Android Gradle library module
ios-app/      iOS app that imports the same Swift package directly
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
cd hello-lib
HELLOLIB_ENABLE_JEXTRACT=1 swift package resolve
./.build/checkouts/swift-java/gradlew --project-dir .build/checkouts/swift-java :SwiftKitCore:publishToMavenLocal
```

## Build

Test the shared Swift package without Android bridge dependencies:

```bash
cd hello-lib
swift test
```

Build the Android app. Gradle sets `HELLOLIB_ENABLE_JEXTRACT=1` when compiling Swift so the same `HelloLib` target gets Java wrappers:

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
hello-lib/build/outputs/aar/hello-lib-debug.aar
```
