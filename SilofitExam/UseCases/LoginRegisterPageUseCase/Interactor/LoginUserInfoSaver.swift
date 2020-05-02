//
//  LoginUserInfoSaver.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

enum LoginUserInfoSaverError: LocalizedError {
    case userNotSet
    
    var errorDescription: String? {
        switch self {
        case .userNotSet: return "User Id is not available"
        }
    }
}

protocol LoginUserInfoSaver {
    func saveUserInfo(id: String)
    func readUserInfo() -> ALResult<String>
    func deleteUserInfo()
}

final class LoginUserInfoSaverImp: LoginUserInfoSaver {
    private let userDefaults = UserDefaults()
    private let userIdKey = StaticDataKeyProvider.userId
    
    func saveUserInfo(id: String) {
        userDefaults.set(data: id, at: userIdKey)
    }
    
    func readUserInfo() -> ALResult<String> {
        guard let userId: String = userDefaults.read(at: userIdKey) else {
            return .wrong(LoginUserInfoSaverError.userNotSet)
        }
        return .right(userId)
    }
    
    func deleteUserInfo() {
        userDefaults.set(data: "", at: userIdKey)
    }
}
