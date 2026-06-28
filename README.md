# swift-android-sdk-minimal

Minimal sample for calling Swift code from Android with Swift SDK for Android and `swift-java`.

## Structure

```text
android-app/  Android app that calls the Swift library
hello-lib/    Shared Swift package built into an Android AAR
ios-app/      Placeholder iOS app project
```

## Swift API

`hello-lib` exposes a simple Swift function:

```swift
public func greeting() -> String {
    "Hello from Swift!"
}
```

The Android app calls the generated Java wrapper:

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
swift package resolve
./.build/checkouts/swift-java/gradlew --project-dir .build/checkouts/swift-java :SwiftKitCore:publishToMavenLocal
```

## Build

```bash
cd android-app
./gradlew :app:assembleDebug
```

The Swift library AAR is produced at:

```text
hello-lib/build/outputs/aar/hello-lib-debug.aar
```
