//
//  ImageStorageService.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit
import EitherResult

enum ImageStorageServiceError: LocalizedError {
    case notFound
    var errorDescription: String? {
        switch self {
        case .notFound: return "Image not found"
        }
    }
}

struct ImageStorageModel {
    let imageURLString: String
    let image: UIImage
}

final class ImageStorageService {
    var storedImage: [ImageStorageModel] = []
    
    func saveImage(_ model: ImageStorageModel) {
        storedImage.append(model)
    }
    
    func getImage(forURL string: String) -> ALResult<UIImage> {
        guard let image = storedImage.first(where: { $0.imageURLString == string })
                                     .map({ $0.image }) else { return .wrong(ImageStorageServiceError.notFound)}
        return .right(image)
    }
}
