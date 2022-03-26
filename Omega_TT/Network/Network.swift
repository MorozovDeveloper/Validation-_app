//
//  Network.swift
//  Omega_TT
//
//  Created by Oleg on 10.02.2022.
// 

import Foundation


class Network {
    
    static let shared = Network()
    private init() {}
    
    func fetch(urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _ , error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {return}
                completion(.success(data))
            }
        }.resume()
    }
    
}
