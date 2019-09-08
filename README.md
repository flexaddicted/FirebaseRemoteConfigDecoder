A custom decoder for decoding `RemoteConfig` from Firebase. Work in progress!

## Usage

Declare a simple `struct` that conforms to `Decodable` protocol.

```
struct AppRemoteConfig: Decodable {
    
    enum MyEnum: Int, Decodable {
        case none
        case update
    }

    let myEnum: MyEnum
    let myUrl: URL
    let myString: String
    let myBool: Bool?
    let myInt: Int // Float or Double as well

    enum CodingKeys: String, CodingKey {
        case myUrl = "my_url"
        case myString = "my_string"
        case myBool
        case myInt
        case myEnum = "my_enum"
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
- [] support more data types (e.g. Date);
- [] ship with CocoaPods or Carthage;
- [] integrate Unit Tests.
