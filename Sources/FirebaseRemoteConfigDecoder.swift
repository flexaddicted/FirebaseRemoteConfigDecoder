//
//  FirebaseRemoteConfigDecoder.swift
//  FirebaseRemoteConfigDecoder
//
//  Created by Boaro Lorenzo on 01/09/2019.
//  Copyright © 2019 Boaro Lorenzo. All rights reserved.
//

import Foundation
import Firebase

final public class FirebaseRemoteConfigDecoder {
    func decode<T>(_ type: T.Type, from remoteConfig: RemoteConfig) throws -> T where T: Decodable {
        let decoder = _FirebaseRemoteConfigDecoder(remoteConfig: remoteConfig)
        return try T(from: decoder)
    }
}

fileprivate final class _FirebaseRemoteConfigDecoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    
    fileprivate var stack: _Stack<RemoteConfigValue>
    
    let remoteConfig: RemoteConfig
    
    init(remoteConfig: RemoteConfig) {
        self.stack = _Stack()
        self.remoteConfig = remoteConfig
    }
}

extension _FirebaseRemoteConfigDecoder: Decoder {
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedDecodingContainer<Key> where Key: CodingKey {
        let container = KeyedContainer<Key>(referencing: self, remoteConfig: remoteConfig)
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedDecodingContainer {
        fatalError()
    }
    
    func singleValueContainer() -> SingleValueDecodingContainer {
        return self
    }
}

class KeyedContainer<Key: CodingKey>: KeyedDecodingContainerProtocol {
    
    var codingPath: [CodingKey]
    
    var allKeys: [Key] {
        fatalError()
    }
    
    fileprivate let decoder: _FirebaseRemoteConfigDecoder
    
    let remoteConfig: RemoteConfig
    
    fileprivate init(referencing decoder: _FirebaseRemoteConfigDecoder, remoteConfig: RemoteConfig) {
        self.decoder = decoder
        self.remoteConfig = remoteConfig
        self.codingPath = decoder.codingPath
    }
    
    func checkCanDecodeValue(forKey key: Key) throws {
        guard self.contains(key) else {
            let context = DecodingError.Context(codingPath: self.decoder.codingPath, debugDescription: "key not found: \(key)")
            throw DecodingError.keyNotFound(key, context)
        }
    }
    
    func contains(_ key: Key) -> Bool {
        let allKeys = remoteConfig.allKeys(from: .remote, namespace: NamespaceGoogleMobilePlatform)
        return allKeys.contains(key.stringValue)
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        let remoteConfigValue = remoteConfig[key.stringValue]
        return remoteConfigValue.isNil()
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try checkCanDecodeValue(forKey: key)
        
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }
        
        guard let value = try self.decoder.unbox(remoteConfig[key.stringValue], as: Bool.self) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try checkCanDecodeValue(forKey: key)
        
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }
        
        guard let value = try self.decoder.unbox(remoteConfig[key.stringValue], as: String.self) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        try checkCanDecodeValue(forKey: key)
        
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }
        
        guard let value = try self.decoder.unbox(remoteConfig[key.stringValue], as: Double.self) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        try checkCanDecodeValue(forKey: key)
        
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }
        
        guard let value = try self.decoder.unbox(remoteConfig[key.stringValue], as: Float.self) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try checkCanDecodeValue(forKey: key)
        
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }
        
        guard let value = try self.decoder.unbox(remoteConfig[key.stringValue], as: Int.self) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value
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
        
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }
        
        if type != URL.self {
            guard let value = try self.decoder.unbox(self.remoteConfig[key.stringValue], as: T.self) else {
                let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
                throw DecodingError.valueNotFound(type, context)
            }
            return value
        }
        
        guard let value = try self.decoder.unbox(remoteConfig[key.stringValue], as: URL.self) else {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "nil value for key: \(key)")
            throw DecodingError.valueNotFound(type, context)
        }
        return value as! T
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

extension _FirebaseRemoteConfigDecoder: SingleValueDecodingContainer {
    
    private func expectNonNull<T>(_ type: T.Type) throws {
        guard !self.decodeNil() else {
            let context = DecodingError.Context(codingPath: self.codingPath,
                                                debugDescription: "Expected \(type) but found null value instead.")
            throw DecodingError.valueNotFound(type, context)
        }
    }
    
    func decodeNil() -> Bool {
        return self.stack.topContainer.isNil()
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try expectNonNull(Bool.self)
        return try self.unbox(self.stack.topContainer, as: Bool.self)!
    }
    
    func decode(_ type: String.Type) throws -> String {
        try expectNonNull(String.self)
        return try self.unbox(self.stack.topContainer, as: String.self)!
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        try expectNonNull(Double.self)
        return try self.unbox(self.stack.topContainer, as: Double.self)!
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        try expectNonNull(Float.self)
        return try self.unbox(self.stack.topContainer, as: Float.self)!
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try expectNonNull(Int.self)
        return try self.unbox(self.stack.topContainer, as: Int.self)!
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        fatalError()
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        fatalError()
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        fatalError()
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        fatalError()
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        fatalError()
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        fatalError()
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        fatalError()
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        fatalError()
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        fatalError()
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        fatalError()
    }
}

extension _FirebaseRemoteConfigDecoder {
    
    func unbox(_ value: RemoteConfigValue, as type: Bool.Type) throws -> Bool? {
        return value.boolValue
    }
    
    func unbox(_ value: RemoteConfigValue, as type: Int.Type) throws -> Int? {
        guard let value = value.numberValue else {
            return nil
        }
        return value.intValue
    }
    
    func unbox(_ value: RemoteConfigValue, as type: Float.Type) throws -> Float? {
        guard let value = value.numberValue else {
            return nil
        }
        return value.floatValue
    }
    
    func unbox(_ value: RemoteConfigValue, as type: Double.Type) throws -> Double? {
        guard let value = value.numberValue else {
            return nil
        }
        return value.doubleValue
    }
    
    func unbox(_ value: RemoteConfigValue, as type: String.Type) throws -> String? {
        return value.stringValue
    }
    
    func unbox(_ value: RemoteConfigValue, as type: URL.Type) throws -> URL? {
        guard let value = value.stringValue, let url = URL(string: value) else {
            return nil
        }
        return url
    }
    
    func unbox<T: Decodable>(_ value: RemoteConfigValue, as type: T.Type) throws -> T? {
        return try unbox_(value, as: type) as? T
    }
    
    func unbox_(_ value: RemoteConfigValue, as type: Decodable.Type) throws -> Any? {
        self.stack.push(container: value)
        defer { self.stack.popContainer() }
        return try type.init(from: self)
    }
}

fileprivate struct _Stack<T> {
    var containers: [T] = []
    
    init() {}
    
    var count: Int {
        return self.containers.count
    }
    
    var topContainer: T {
        precondition(!self.containers.isEmpty, "Empty container stack.")
        return self.containers.last!
    }
    
    mutating func push(container: T) {
        self.containers.append(container)
    }
    
    mutating func popContainer() {
        precondition(!self.containers.isEmpty, "Empty container stack.")
        self.containers.removeLast()
    }
}

extension RemoteConfigValue {
    func isNil() -> Bool {
        if numberValue == nil || stringValue == nil {
            return true
        }
        return false
    }
}
