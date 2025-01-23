//
//  ServiceManager.swift
//  Spotify
//
//  Created by Dwistari on 04/01/25.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    
    func request<T: Decodable>(
        url: String,
        method: String = "GET",
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 404, userInfo: nil)))
                return
            }
            
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding Error: \(error)")
                completion(.failure(error))
            }
        }
        
        task.resume()        
    }
}
