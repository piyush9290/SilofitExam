//
//  MapViewInteractor.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation

final class MapViewInteractorImp: Readyable {
    private let output: MapViewOutput
    private let spacesInfoProvider: SpaceInfoStorage

    init(output: MapViewOutput, spacesInfoProvider: SpaceInfoStorage) {
        self.output = output
        self.spacesInfoProvider = spacesInfoProvider
    }
    
    func isReady() {
        spacesInfoProvider.fetchSpaceInfo { [weak self] (result) in
            guard let `self` = self else { return }
            result.map({ $0.map({ $0.addressInfo.location }) })
                  .do(work: { self.output.display($0) })
        }
    }
}
