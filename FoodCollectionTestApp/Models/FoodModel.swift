//
//  FoodModel.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

struct FoodModel: Decodable {
    let sections: [CurrentData]
}

struct CurrentData: Decodable {
    let header: String
    let items: [Information]
}

struct Information: Decodable {
    let id: String
    let image: ImageData
    let title: String
}

struct ImageData: Decodable {
    let oneX: String
    
    enum CodingKeys: String, CodingKey {
        case oneX = "1x"
    }
}

enum Link: String {
    case FoodApi = "https://api.jsonbin.io/b/620ca6bc1b38ee4b33bd9656"
}
