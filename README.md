# swift-android-sdk-minimal

1つのSwift PackageをSwift SDK for Androidとswift-javaを用いてiOS / Androidで共有可能とした最小構成です。

- iOSでは同じ`HelloLib`をSwift Packageとして直接importして呼び出します。
- Android向けにはSwift SDK for AndroidでAndroid target向けにビルドし、dynamic library productのため`.so`が成果物になります。
- Kotlinからはswift-java / JExtractが生成するJava wrapper経由で`HelloLib`を呼び出します。

## 構成

```text
android-app/  生成された Java wrapper 経由で Swift ライブラリを呼び出す Android アプリ
hello-lib/    Swift Package / Swift target / Android Gradle library module
ios-app/      同じ Swift Package を直接 import して使う iOS アプリ
```

## Swift API

`hello-lib` はシンプルな Swift 関数を公開しています。

```swift
public func greeting() -> String {
    "Hello from Swift!"
}
```

iOS アプリは `HelloLib` を直接 import します。Android アプリは生成された Java wrapper を呼び出します。

```kotlin
import com.example.hellolib.HelloLib

val message = HelloLib.greeting()
```

## 環境

- Swift 6.3.2
- Swift SDK for Android `swift-6.3.2-RELEASE_android`

環境構築の詳細：[Getting Started with the Swift SDK for Android](https://www.swift.org/documentation/articles/swift-sdk-for-android-getting-started.html)

## トラブルシューティング

### Swift の変更が Android 側に反映されない

`hello-lib` の Swift コードを変更したあと、Android アプリをビルドしても古い実装が使われる場合があります。

その場合は `hello-lib/.build` を削除してから、Android アプリをもう一度ビルドします。

```bash
rm -rf hello-lib/.build
```
