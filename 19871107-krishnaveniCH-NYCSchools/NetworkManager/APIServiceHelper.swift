//
//  APIServiceHelper.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation

class APIServiceHelper {
    
    private let queue = OperationQueue()
    
    var session: URLSessionProtocol =  URLSession(configuration: .default)
    func fetchResponse(url: URL, shouldCancelOtherOps: Bool, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        if shouldCancelOtherOps {
            queue.cancelAllOperations()
        }
        
        let fetchOperation = BlockOperation { [weak self] in
            let dataTask = self?.session.dataTask(with: url) { (data, response, error) in
                completion(data, response, error)
            }
            dataTask?.resume()
        }
        queue.addOperation(fetchOperation)
    }
    
}

