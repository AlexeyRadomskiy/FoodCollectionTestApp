//
//  SectionTableViewCell.swift
//  FoodCollectionTestApp
//
//  Created by Alexey on 18.05.2022.
//

import UIKit

protocol CellDelegate: AnyObject {
    func didChosen(info: Information)
    func itemSelected(id: String) -> Bool
}

class SectionsTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    private var items: [Information] = []
    private var flowLayout = UICollectionViewFlowLayout()
    
    // MARK: - Lazy Properties
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: flowLayout)
    
    // MARK: - Weak Properties
    weak var delegate: CellDelegate?
    
    // MARK: - Initialisers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupFlowLayout()
        setupCollectionView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func setup(images: [Information]) {
        items = images
        collectionView.reloadData()
    }
    
    // MARK: - Private Methods
    private func setupFlowLayout() {
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = Constants.sectionsMinimumLineSpacing
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: Constants.leftDistanceToView,
                                                   bottom: 0,
                                                   right: Constants.rightDistanceToView)
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(FoodCollectionViewCell.self,
                                forCellWithReuseIdentifier: FoodCollectionViewCell.identifier)
    }
    
    // MARK: - SetupConstraints
    private func setupConstraint() {
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension SectionsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodCollectionViewCell.identifier,
                                                      for: indexPath) as! FoodCollectionViewCell
        
        let info = items[indexPath.row]
        cell.imageView.loadImage(info.image.oneX)
        cell.label.text = info.title
        cell.backgroundColor = .clear
        
        cell.cellSelected = delegate?.itemSelected(id: info.id) ?? false
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension SectionsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let info = items[indexPath.row]
        self.delegate?.didChosen(info: info)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SectionsTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: Constants.sectionsItemWidth, height: frame.height)
    }
}
