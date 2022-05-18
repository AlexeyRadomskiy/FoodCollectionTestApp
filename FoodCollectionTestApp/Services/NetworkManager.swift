//
//  NetworkManager.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(from url: String?, with completion: @escaping ([CurrentData]) -> Void) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let data = try JSONDecoder().decode(FoodModel.self, from: data)
                DispatchQueue.main.async {
                    completion(data.sections)
                }
            } catch let error {
                print("Failed to decode JSON", error)
            }
        }.resume()
    }
}
