//
//  FirebaseCRUD.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult
import FirebaseDatabase

enum DatabaseError: LocalizedError {
    case notFound(String)
    var errorDescription: String? {
        switch self {
        case let .notFound(serviceName): return "Object not found at Service: \(serviceName)"
        }
    }
}

typealias DatabaseCRUD = FirebaseReader

class FirebaseCRUD: DatabaseCRUD {
    private let reference: DatabaseReference
    
    init(reference: DatabaseReference = Database.database().reference()) {
        self.reference = reference
    }
}

protocol FirebaseReader {
    func getData<T>(for requestType: RequestType, completion: @escaping (ALResult<T>) -> Void) where T : DictionaryMappable
}

extension FirebaseCRUD {
    func getData<T>(for requestType: RequestType, completion: @escaping (ALResult<T>) -> Void) where T : DictionaryMappable {
        reference.child(requestType.path).observeSingleEvent(of: .value) { (snapshot) in
            guard snapshot.exists() else {
                completion(.wrong(DatabaseError.notFound(requestType.rawValue)))
                return
            }
            let dict = snapshot.value as? [String: Any] ?? [:]
            completion(.right(T.init(dict: dict)))
        }
    }
}
