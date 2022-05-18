//
//  FoodCollectionViewCell.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    static let identifier = "FoodCollectionViewCell"
    
    // MARK: - Public Properties
    let label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.1882352941, green: 0.2011603713, blue: 0.3214474916, alpha: 1)
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let blurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        view.clipsToBounds = true
        return view
    }()
    
   let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 0
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var cellSelected = false {
        didSet {
            let color: UIColor = cellSelected ? UIColor(#colorLiteral(red: 0.4667439461, green: 0.5091276169, blue: 0.9618265033, alpha: 1)) : .clear
            imageView.layer.borderColor = color.cgColor
        }
    }
    
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBlurEffect()
        setupConstraint()
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
    }
    
    private func setupImageView() {
        imageView.layer.borderWidth = 2.0
        imageView.layer.masksToBounds = true
    }
    
    // MARK: - SetupConstraints
    private func setupConstraint() {
        contentView.addSubview(imageView)
        imageView.addSubview(blurView)
        blurView.contentView.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        blurView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: label.topAnchor,
                                          constant: -8),
            blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: blurView.leadingAnchor,
                                           constant: 8),
            label.trailingAnchor.constraint(equalTo: blurView.trailingAnchor,
                                            constant: -8),
            label.bottomAnchor.constraint(equalTo: blurView.bottomAnchor,
                                          constant: -8),
        ])
    }
}
