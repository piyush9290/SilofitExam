//
//  RequestTaskNode.swift
//  Pods
//
//  Created by Alex Hmelevski on 2017-06-05.
//
//

import Foundation
import Combine

final class RequestTaskNode: BasicTaskNode {
    var responseAdapter: INetworkResponseAdapter = AHNetworkResponseAdapter()
    
    override func send(request: NetworkTaskRequest, completion: completionHandler?, progress: progressTracker?) -> ICancellable {
        guard case .request = request.type else {
            return super.send(request: request, completion: completion, progress: progress)
        }
        
        let task = session.dataTask(with: request.urlRequest, completionHandler: { (data, response, error) in
            self.responseAdapter.response(from: data, with: response, and: error)
                                .do(work: { completion?(.right($0)) })
                                .doIfWrong(work: { completion?(.wrong($0))})
        })
        
        task.resume()
        return task
    }
    
    @available(iOS 13.0, *)
    override func send(request: NetworkTaskRequest) -> AnyPublisher<AHNetworkResponse,URLError> {
        guard case .request = request.type else {
            return super.send(request: request)
        }
        
        return session.dataTaskPublisher(for: request.urlRequest)
                      .map(AHNetworkResponse.init)
                      .eraseToAnyPublisher()
    }
}
