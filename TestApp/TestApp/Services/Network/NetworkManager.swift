//
//  NetworkManager.swift
//  TestApp
//
//  Created by Oleynik Gennady on 27/03/2018.
//  Copyright © 2018 Oleynik Gennady. All rights reserved.
//

import Foundation

class NetworkManger {
    // MARK: - Inner types
    enum Endpoints : String {
        case searchByDate = "/api/v1/search_by_date"
    }
    
    // MARK: - Properties
    static let shared = NetworkManger()
    
    static private let scheme: String = "https"
    static private let baseURL = "hn.algolia.com"
    
    private var urlComponents = URLComponents()
    
    // MARK: - Constructors
    
    private init() {
        urlComponents.scheme = NetworkManger.scheme
        urlComponents.host = NetworkManger.baseURL
    }

    // MARK: - Methods
    
    func fetchStories(completionHander:@escaping (Data?, URLResponse?, Error?) -> ()) {
        urlComponents.path = Endpoints.searchByDate.rawValue
        
        let queryItem = URLQueryItem(name: "tags", value: "story")
        urlComponents.queryItems = [queryItem]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            completionHander(data, response, error)
        }.resume()
    }
}
