//
//  FirebaseAuthenticator.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol Authenticator {
    func authenticate(withEmail email: String, password: String, completion: @escaping Callback<String>)
    func signOut(completion: @escaping Callback<Bool>)
}

protocol UserCreator {
    func createUser(withEmail email: String, password: String, completion: @escaping Callback<String>)
}

typealias FirebaseAuthenticator = Authenticator & UserCreator

class FirebaseAuthenticatorImp: FirebaseAuthenticator {
    private let auth: Auth
    init() {
        self.auth = Auth.auth()
    }
    
    func authenticate(withEmail email: String, password: String, completion: @escaping Callback<String>) {
        auth.signIn(withEmail: email, password: password, completion: { [weak self] (result, error) in
            self?.processAuthDataResultCallBack(result: result, error: error, completion: completion)
        })
    }
    
    func signOut(completion: @escaping Callback<Bool>) {
        do {
            try auth.signOut()
        } catch {
            completion(.wrong(error))
        }
        completion(.right(true))
    }
    
    func createUser(withEmail email: String, password: String, completion: @escaping Callback<String>) {
        auth.createUser(withEmail: email, password: password, completion: { [weak self] (result, error) in
            self?.processAuthDataResultCallBack(result: result, error: error, completion: completion)
        })
    }
    
    private func processAuthDataResultCallBack(result: AuthDataResult?,
                                               error: Error?,
                                               completion: @escaping Callback<String>) {
        DispatchQueue.main.async {
            error.do({ completion(.wrong($0)) })
            result.map({ $0.user.uid }).do({ completion(.right($0)) })
        }
    }
}
