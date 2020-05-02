//
//  CoreNetworkService.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import EitherResult

enum CoreNetworkError: LocalizedError {
    case emptyURL
    case emptyData
    case responseError(Int)
    
    var errorDescription: String? {
        switch self {
        case .emptyURL: return "Empty URL String"
        case .emptyData: return "Data not available"
        case let .responseError(statusCode): return "Network status response: \(statusCode))"
        }
    }
}

protocol CoreNetwork {
    func send(requestURLString: String, completion: @escaping (ALResult<Data>) -> Void)
}

final class CoreNetworkImp: CoreNetwork {
    private let urlSession: URLSession
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func send(requestURLString: String, completion: @escaping (ALResult<Data>) -> Void) {
        guard let url = URL(string: requestURLString), !requestURLString.isEmpty else {
            completion(.wrong(CoreNetworkError.emptyURL))
            return
        }
        urlSession.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            error.do({ completion(.wrong($0)) })
            data.do({ completion(.right($0)) })
                .onNone { completion(.wrong(CoreNetworkError.emptyData)) }
        }
    }
}
