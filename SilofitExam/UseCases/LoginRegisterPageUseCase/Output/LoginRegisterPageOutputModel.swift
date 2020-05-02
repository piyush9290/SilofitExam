//
//  LoginRegisterPageOutputModel.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

struct LoginRegisterPageOutputModel {
    let statusMessageConfig: TextLabelConfig
    let userEmailConfig: TextFieldConfig
    let passwordConfig: TextFieldConfig
    let loginJoinButtonConfig: ButtonConfig
}

struct LoginRegisterInputModel {
    let userEmail: String
    let password: String
}
