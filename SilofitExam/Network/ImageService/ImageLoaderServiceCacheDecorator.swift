//
//  ImageLoaderServiceCacheDecorator.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit
import EitherResult

final class ImageLoaderServiceCacheDecorator: ImageLoader {
    private let decorated: ImageLoader
    private let imageStorageService: ImageStorageService
    
    init(decorated: ImageLoader,
         imageStorageService: ImageStorageService) {
        self.decorated = decorated
        self.imageStorageService = imageStorageService
    }
    func loadImage(from urlString: String, completion: @escaping (ALResult<UIImage>) -> Void) {
        imageStorageService.getImage(forURL: urlString)
                           .do(work: { completion(.right($0)) })
                           .onError({ _ in
                            self.decorated.loadImage(from: urlString, completion: {[weak self] (result) in
                                guard let `self` = self else { return }
                                result.map({ (urlString, $0) }).do(work: self.saveImage)
                                completion(result)
                            })
        })
    }
    
    private func saveImage(url: String, image: UIImage) {
        let model = ImageStorageModel(imageURLString: url, image: image)
        imageStorageService.saveImage(model)
    }
}
