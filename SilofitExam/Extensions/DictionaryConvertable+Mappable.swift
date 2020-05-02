//
//  DictionaryConvertable+Mappable.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

protocol DictionaryConvertable: Encodable {
    var dictionary: [String: Any] { get }
}

protocol DictionaryMappable {
    init(dict: [String: Any])
}

extension DictionaryConvertable {
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return object.flatMap({ $0 as? [String: Any] }) ?? [:]
    }
}

extension DictionaryMappable {
    static var empty: Self {
        return Self(dict: [:])
    }
}

extension Dictionary {
    func value<T>(for key: Key, defaultValue: T) -> T {
           return self[key] as? T ?? defaultValue
    }
}
