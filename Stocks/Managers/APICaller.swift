//
//  APICaller.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation

final class APICaller { /* 9 */
    static let shared = APICaller() /* 10 */
    
    //chlm9spr01qs8kipcii0chlm9spr01qs8kipciig
    
    private struct Constants { /* 34 */
        static let apiKey = "c3c6me2ad3iefuuilms0" /* 35 */
        static let sandboxApiKey = "sandbox_c3c6me2ad3iefuuilmsg" /* 36 */
        static let baseUrl = "https://finnhub.io/api/v1/" /* 37 */
    }
    
    private init() {} /* 11 */
    
    //MARK: - Public
    
    public func search(
        query: String,
        completion: @escaping (Result<SearchResponse, Error>) -> Void /* 132 change String */
    ) { /* 122 */
        //        guard let url = url(for: .search, queryParams: ["q":query]) else { /* 123 */ return /* 124 */}
        guard let safeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { /* 155 */
            return /* 156 */
        }
        request(
            url: url(
                for: .search,
                queryParams: ["q":safeQuery] /* 157 change query */
            ),
            expecting: SearchResponse.self,
            completion: completion
        ) /* 133 */
    }
    
    
    //get stock info
    
    //search stocks
    
    //MARK: - Private
    
    private enum Endpoint: String { /* 12 */
        case search /* 13 */
        
    }
    
    private enum APIError: Error { /* 29 */
        case noDataReturned /* 30 */
        case invalidUrl /* 30 */
    }
    
    private func url(
        for endpoint: Endpoint,
        queryParams: [String: String] = [:]
    ) -> URL? { /* 14 */
        var urlString = Constants.baseUrl + endpoint.rawValue /* 115 */
        
        var queryItems = [URLQueryItem]() /* 116 */
        //Add any parameters
        for (name, value) in queryParams { /* 118 */
            queryItems.append(.init(name: name, value: value)) /* 119 */
        }
        
        //Add token
        queryItems.append(.init(name: "token", value: Constants.apiKey)) /* 117 */
        
        //Convert query items to suffix string
        urlString += "?" + queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&") /* 121 */
        
        print("\n\(urlString)\n") /* 125 */
        
        return URL(string: urlString) /* 120 */
    }
    
    private func request<T: Codable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) { /* 15 */
        guard let url = url else { /* 16 */
            completion(.failure(APIError.invalidUrl)) /* 31 */
            return /* 17 */
        }
        
        let task = URLSession.shared.dataTask(with: url) { data , _, error in /* 18 */
            guard let data = data, error == nil else { /* 19 */
                if let error = error { /* 20 */
                    completion(.failure(error)) /* 21 */
                } else { /* 32 */
                    completion(.failure(APIError.noDataReturned)) /* 33 */
                }
                return /* 22 */
            }
            
            do { /* 23 */
                let result = try JSONDecoder().decode(expecting, from: data) /* 24 */
                completion(.success(result)) /* 25 */
            }
            
            catch { /* 26 */
                completion(.failure(error)) /* 27 */
            }
        }
        task.resume() /* 28 */
    }
}
