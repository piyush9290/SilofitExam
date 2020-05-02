//
//  RequestType.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

enum RequestType: String {
    case spaces = "Spaces"
    
    var path: String {
        switch self {
        case .spaces: return "spaces"
        }
    }
}

struct FirebaseTransformer {
    static func transform(originalDictionary: [String: Any], with key: String) -> [String: Any]? {
        return originalDictionary[key].flatMap({$0 as? [String: Any]})
            .map { (dictionary) -> [String: Any] in
                var mDict = dictionary
                mDict["id"] = key
                return mDict
        }
    }
}

struct FirebaseArrayResult<T: DictionaryMappable>: DictionaryMappable {
    let data: [T]
    init(dict: [String: Any]) {
        guard let data = dict["data"] else {
            self.data = dict.keys.compactMap({ FirebaseTransformer.transform(originalDictionary: dict, with: $0) })
                .map(T.init)
            return
        }
        
        if let dictionary = data as? [String : Any] {
            self.data = dictionary.keys.compactMap({ FirebaseTransformer.transform(originalDictionary: dictionary, with: $0) })
                .map(T.init)
            return
        }
        
        if let array = data as? [[String: Any]] {
            self.data = array.map(T.init)
            return
        }
        
        if let nestedArray = data as? [[[String: Any]]] {
            self.data = nestedArray.map({["data" : $0]})
                .map(T.init)
            return
        }
        self.data = []
    }
}
