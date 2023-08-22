//
//  NetworkManager.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    let apiHelper = APIServiceHelper()
    private init() {}
    
    func getNYCSchoolList(completion: @escaping ([NYCHighSchool]?) -> ()) {
        guard let url = addQueryParams(urlString: AppConstants.API.schoolList) else {
            return
        }
        
        apiHelper.fetchResponse(url: url, shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let nycHighSchoolResponse = try jsonDecoder.decode([NYCHighSchool].self, from: data!)
                    completion(nycHighSchoolResponse)
                } catch {
                    print("Error occured while parsing school response")
                    completion(nil)
                }
            }
        }
    }
    
    func getNYCSchoolDetail(completion: @escaping ([NYCSchoolDetail]?) -> ()) {
        guard let url = addQueryParams(urlString: AppConstants.API.schoolDetail) else {
            return
        }
        
        apiHelper.fetchResponse(url: url, shouldCancelOtherOps: true) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                completion(nil)
            } else {
                let jsonDecoder = JSONDecoder()
                do {
                    let nycHighSchoolResponse = try jsonDecoder.decode([NYCSchoolDetail].self, from: data!)
                    completion(nycHighSchoolResponse)
                } catch {
                    print("Error occured while parsing school response")
                    completion(nil)
                }
            }
        }
    }
    
    func addQueryParams(urlString: String, params: [URLQueryItem]? = nil) -> URL? {
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = params
        return urlComponents?.url
    }
    
}
