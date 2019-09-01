A custom decoder for decoding `RemoteConfig` from Firebase. Work in progress!

## Usage

Declare a simple `struct` that conforms to `Decodable` protocol.

```
struct AppRemoteConfig: Decodable {
    let myUrl: URL
    let myString: String
    let myBool: Bool?
    let myInt: Int

    enum CodingKeys: String, CodingKey {
        case myUrl = "my_url"
        case myString = "my_string"
        case myBool
        case myInt
    }
}
```

Once done, use `FirebaseRemoteConfigDecoder` as follows:

```
let decoder = FirebaseRemoteConfigDecoder()
let decoded = try? decoder.decode(AppRemoteConfig.self, from: self.remoteConfig)    
```

## Roadmap

In the roadmap:
- [] improve the documentation;
- [] ship with CocoaPods or Carthage;
- [] integrate Unit Tests.
