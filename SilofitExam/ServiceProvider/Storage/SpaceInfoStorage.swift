//
//  SpaceInfoStorage.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

protocol SpaceInfoStorage {
    func fetchSpaceInfo(completion: @escaping Callback<[SpaceInfo]>)
}

final class SpaceInfoStorageImp: SpaceInfoStorage {
    private let spacesReader: SpacesReader
    private let converter: SpaceInfoConverter = SpaceInfoConverterImp()
    
    private var spacesInfo: [SpaceInfo] = []
    
    init(spacesReader: SpacesReader) {
        self.spacesReader = spacesReader
    }
    
    func fetchSpaceInfo(completion: @escaping Callback<[SpaceInfo]>) {
        guard spacesInfo.isEmpty else {
            completion(.right(spacesInfo))
            return
        }
        spacesReader.getSpaces {[weak self] (result) in
            guard let `self` = self else {return }
            completion(result.map({ self.converter.convert(spaceNM: $0) }))
        }
    }
}
