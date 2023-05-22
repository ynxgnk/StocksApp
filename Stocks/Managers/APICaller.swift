//
//  APICaller.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation

final class APICaller { /* 9 */
    static let shared = APICaller() /* 10 */
    
    private struct Constants { /* 34 */
        static let apiKey = "" /* 35 */
        static let sandboxApiKey = "" /* 36 */
        static let baseUrl = "" /* 37 */
    }
    
    private init() {} /* 11 */
    
    //MARK: - Public
    
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
        return nil
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
