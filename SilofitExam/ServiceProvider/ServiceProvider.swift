//
//  ServiceProvider.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-01.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

class ServiceProvider {
    var databaseCRUD: DatabaseCRUD {
        FirebaseCRUD()
    }
    
    var authenticator: FirebaseAuthenticator {
        FirebaseAuthenticatorImp()
    }
    
    var colorProvider: ColorProvider {
        BasicColorProvider()
    }
    
    var fontProvider: FontProvider {
        BasicFontProvider()
    }
    
    var firebaseFacade: FirebaseFacade {
        FirebaseFacade(firebaseOperation: databaseCRUD)
    }
    
    var spacesReader: SpacesReader { firebaseFacade }
    
    var imageStorage: ImageStorageService { ImageStorageService() }
    
    var coreNetwork: CoreNetwork {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return CoreNetworkImp(urlSession: session)
    }
}

extension ServiceProvider: ServiceProviderType {
    var authenticateService: Authenticator { authenticator }
    var userCreatorService: UserCreator { authenticator }
    var userInfoSaverService: LoginUserInfoSaver {
        LoginUserInfoSaverImp()
    }
    var theme: Theme {
        BasicThemeProvider(colorProvider: colorProvider,
                           fontProvider: fontProvider)
    }
    
    var userInfo: ALResult<UserInfo> {
        userInfoSaverService.readUserInfo().map(UserInfo.init)
    }
    
    var spaceInfoStorage: SpaceInfoStorage {
        SpaceInfoStorageImp(spacesReader: spacesReader)
    }
    
    var imageLoaderService: ImageLoader {
        let loader = ImageLoaderImp(networkProvider: coreNetwork)
        return ImageLoaderServiceCacheDecorator(decorated: loader,
                                                imageStorageService: imageStorage)
    }
}
