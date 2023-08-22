//
//  URLSession.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//


import Foundation
public protocol URLSessionProtocol {
  func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

public final class URLSessionMock: URLSessionProtocol {
  var url: URL?
  var request: URLRequest?
  private let dataTaskMock: URLSessionDataTaskMock
  
  public convenience init?(jsonDict: [String: Any], response: URLResponse? = nil, error: Error? = nil) {
    guard let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) else { return nil }
    self.init(data: data, response: response, error: error)
  }
  
  public init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
    dataTaskMock = URLSessionDataTaskMock()
    dataTaskMock.taskResponse = (data, response, error)
  }
  
  public func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
      self.url = url
      self.dataTaskMock.completionHandler = completionHandler
      return self.dataTaskMock
  }
  
  public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
      self.request = request
      self.dataTaskMock.completionHandler = completionHandler
      return self.dataTaskMock
  }
  
  final private class URLSessionDataTaskMock: URLSessionDataTask {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var completionHandler: CompletionHandler?
    var taskResponse: (Data?, URLResponse?, Error?)?
    
    override func resume() {
      DispatchQueue.main.async {
        self.completionHandler?(self.taskResponse?.0, self.taskResponse?.1, self.taskResponse?.2)
      }
    }
  }
}
