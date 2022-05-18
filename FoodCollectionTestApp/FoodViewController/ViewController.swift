//
//  FoodViewController.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import UIKit

class FoodViewController: UIViewController {
    
    var data: [CurrentData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        NetworkManager.shared.fetchData(from: Link.FoodApi.rawValue) { data in
            self.data = data
        }
    }
}

