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

final class _FirebaseRemoteConfigDecoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey: Any] = [:]
    
    var container: FirebaseRemoteConfigDecodingContainer?
    fileprivate var remoteConfig: RemoteConfig
    
    init(remoteConfig: RemoteConfig) {
        self.remoteConfig = remoteConfig
    }
}

extension _FirebaseRemoteConfigDecoder: Decoder {
    fileprivate func assertCanCreateContainer() {
        precondition(self.container == nil)
    }
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedDecodingContainer<Key> where Key: CodingKey {
        assertCanCreateContainer()
        
        let container = KeyedContainer<Key>(remoteConfig: remoteConfig, codingPath: codingPath, userInfo: userInfo)
        self.container = container
        
        return KeyedDecodingContainer(container)
    }
    
    func unkeyedContainer() -> UnkeyedDecodingContainer {
        fatalError()
    }
    
    func singleValueContainer() -> SingleValueDecodingContainer {
        fatalError()
    }
}

protocol FirebaseRemoteConfigDecodingContainer: class { }
