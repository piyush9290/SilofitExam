//
//  ImageService.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

enum ImageLoaderError: LocalizedError {
    case corruptedImage
    var errorDescription: String? {
        switch self {
        case .corruptedImage: return "Corrupted image or data"
        }
    }
}

protocol ImageLoader {
    func loadImage(from urlString: String, completion: @escaping (ALResult<UIImage>) -> Void)
}

class ImageLoaderImp: ImageLoader {
    private let networkProvider: CoreNetwork
    
    init(networkProvider: CoreNetwork) {
        self.networkProvider = networkProvider
    }
    
    func loadImage(from urlString: String, completion: @escaping (ALResult<UIImage>) -> Void) {
        networkProvider.send(requestURLString: urlString) {[weak self] (result) in
            guard let `self` = self else { return }
            let imageResult = result.flatMap(self.getImage)
            DispatchQueue.main.async {
                completion(imageResult)
            }
        }
    }
    
    private func getImage(_ data: Data) -> ALResult<UIImage> {
        return UIImage(data: data).map({ .right($0) }) ?? .wrong(ImageLoaderError.corruptedImage)
    }
}
