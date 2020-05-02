//
//  LoginRegisterPagePresenterModel.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

enum ActionType: String {
    case login = "Sign in"
    case join = "Join"
}

struct LoginRegisterPagePresenterModel {
    let buttonType: ActionType
}
