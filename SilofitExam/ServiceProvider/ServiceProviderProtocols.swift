//
//  ServiceProviderProtocols.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

typealias ServiceProviderType = AuthenticateServiceProvider &
                                UserCreatorServiceProvider &
                                LoginUserInfoSaverService &
                                UserInfoServiceProvider &
                                ThemeProvider &
                                SpacesInfoProvider &
                                ImageLoaderService

protocol AuthenticateServiceProvider {
    var authenticateService: Authenticator { get }
}

protocol UserCreatorServiceProvider {
    var userCreatorService: UserCreator { get }
}

protocol LoginUserInfoSaverService {
    var userInfoSaverService: LoginUserInfoSaver { get }
}

protocol UserInfoServiceProvider {
    var userInfo: ALResult<UserInfo> { get }
}

protocol ThemeProvider {
    var theme: Theme { get }
}

protocol SpacesInfoProvider {
    var spaceInfoStorage: SpaceInfoStorage { get }
}

protocol ImageLoaderService {
    var imageLoaderService: ImageLoader { get }
}
