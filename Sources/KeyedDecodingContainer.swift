//
//  FirebaseRemoteConfigDecoder.swift
//  FirebaseRemoteConfigDecoder
//
//  Created by Boaro Lorenzo on 01/09/2019.
//  Copyright © 2019 Boaro Lorenzo. All rights reserved.
//

import Foundation
import Firebase

extension _FirebaseRemoteConfigDecoder {
    final class KeyedContainer<Key> where Key: CodingKey {
        var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
        
        let remoteConfig: RemoteConfig
        init(remoteConfig: RemoteConfig, codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
            self.remoteConfig = remoteConfig
        }
        
        func checkCanDecodeValue(forKey key: Key) throws {
            guard self.contains(key) else {
                let context = DecodingError.Context(codingPath: codingPath, debugDescription: "key not found: \(key)")
                throw DecodingError.keyNotFound(key, context)
            }
        }
    }
}

extension _FirebaseRemoteConfigDecoder.KeyedContainer: KeyedDecodingContainerProtocol {
    var allKeys: [Key] {
        fatalError()
    }
    
    func contains(_ key: Key) -> Bool {
        let allKeys = remoteConfig.allKeys(from: .remote, namespace: NamespaceGoogleMobilePlatform)
        return allKeys.contains(key.stringValue)
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        let remoteConfigValue = remoteConfig[key.stringValue]
        if remoteConfigValue.numberValue == nil || remoteConfigValue.stringValue == nil {
            return true
        }
        return false
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try checkCanDecodeValue(forKey: key)
        
        return remoteConfig[key.stringValue].boolValue
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try checkCanDecodeValue(forKey: key)
        
        guard let value = remoteConfig[key.stringValue].stringValue else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try checkCanDecodeValue(forKey: key)
        
        guard let value = remoteConfig[key.stringValue].numberValue else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value.doubleValue
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try checkCanDecodeValue(forKey: key)
        
        guard let value = remoteConfig[key.stringValue].numberValue else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value.floatValue
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try checkCanDecodeValue(forKey: key)
        
        guard let value = remoteConfig[key.stringValue].numberValue else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value.intValue
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        fatalError()
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        fatalError()
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        fatalError()
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        fatalError()
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        fatalError()
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        fatalError()
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        fatalError()
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        fatalError()
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        fatalError()
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        try checkCanDecodeValue(forKey: key)
        
        guard let value = remoteConfig[key.stringValue].stringValue else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        
        guard let url = URL(string: value) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "invalid url from value: \(value)")
            throw DecodingError.dataCorrupted(context)
        }
        
        return url as! T
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        fatalError()
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        fatalError()
    }
    
    func superDecoder() throws -> Decoder {
        fatalError()
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        fatalError()
    }
}

extension _FirebaseRemoteConfigDecoder.KeyedContainer: FirebaseRemoteConfigDecodingContainer {}

