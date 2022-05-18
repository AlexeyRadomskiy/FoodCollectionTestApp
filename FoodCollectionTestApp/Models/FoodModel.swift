//
//  FoodModel.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import UIKit

enum Link: String {
    case FoodApi = "https://api.jsonbin.io/b/620ca6bc1b38ee4b33bd9656"
}

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

struct Constants {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let sectionsMinimumLineSpacing: CGFloat = 16
    static let sectionsItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.sectionsMinimumLineSpacing / 2)) / 2
}
