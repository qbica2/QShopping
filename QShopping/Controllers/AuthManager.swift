//
//  AuthManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 30.04.2023.
//

import Foundation

class AuthManager {
    
    let baseUrl = "https://fakestoreapi.com/auth"

    func login(with username: String, with password: String, completion: @escaping (Result<String, Error>)-> Void){
        let urlString = "\(baseUrl)/login"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let body = [
            "username" : username,
            "password" : password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                if let jsonDict = json as? [String: Any], let token = jsonDict["token"] as? String {
                    completion(.success(token))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
