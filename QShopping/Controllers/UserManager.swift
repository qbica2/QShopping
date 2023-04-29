//
//  UserManager.swift
//  QShopping
//
//  Created by Mehmet Kubilay Akdemir on 27.04.2023.
//

import Foundation

class UserManager {
    
    let baseUrl = "https://fakestoreapi.com/users"
    var users: [User] = []
    
    func getUsers(completion: @escaping (Error?) -> Void) {
        let url = URL(string: baseUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { data, response, error in
            if let error = error {
                completion(error)
            } else if let data = data {
                let decoder = JSONDecoder()
                self.users = []
                do {
                    let decodedData = try decoder.decode([UserData].self, from: data)
                    
                    for userData in decodedData {
                        let user = User(email: userData.email, username: userData.username, password: userData.password, firstname: userData.name.firstname, lastname: userData.name.lastname)
                        self.users.append(user)
                    }
                    
                    completion(nil)
                } catch {
                    completion(error)
                }
            }
        }
        task.resume()
    }
    
}

