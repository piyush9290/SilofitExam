//
//  FirebaseFacade.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

final class FirebaseFacade {
    private let firebaseOperation: DatabaseCRUD
    
    init(firebaseOperation: DatabaseCRUD) {
        self.firebaseOperation = firebaseOperation
    }
    
    fileprivate func callCompletion<T>(result:ALResult<T>, function: @escaping (ALResult<T>) -> Void){
        DispatchQueue.main.async {
            function(result)
        }
    }
}

protocol SpacesReader {
    func getSpaces(completion: @escaping Callback<SpaceNetworkResponse>)
}

extension FirebaseFacade: SpacesReader {
    func getSpaces(completion: @escaping Callback<SpaceNetworkResponse>) {
        firebaseOperation.getData(for: .spaces, completion: { [weak self] (result: ALResult<FirebaseArrayResult<SpaceNetworkModel>>) in
            let networkResult = result.map({ $0.data })
                                        .map(SpaceNetworkResponse.init)
            self?.callCompletion(result: networkResult,
                                 function: completion)
        })
    }
}
