//
//  CollectionView.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

protocol ICarCollectionView {
    var collectionView: UICollectionView { get }
    var onTouchedHandler: (() -> Void)? { get set }
}

protocol CarCollectionViewDelegate: AnyObject {
    func carCollectionViewNumberOfItems(_ carCollectionView: CarCollectionView) -> Int
    func carCollectionView(_ carCollectionView: CarCollectionView, itemAtIndex index: Int) -> String
    func carCollectionView(_ carCollectionView: CarCollectionView, didSelectItemAtIndex index: Int)
}

final class CarCollectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    var onTouchedHandler: (() -> Void)?
    weak var delegate: CarCollectionViewDelegate?
 
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CarCollectionViewCell.self, forCellWithReuseIdentifier: CarCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarCollectionView {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}
 
extension CarCollectionView: ICarCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = self.delegate else { return 0 }
        return delegate.carCollectionViewNumberOfItems(self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CarCollectionViewCell.identifier, for: indexPath) as! CarCollectionViewCell
        let item = self.delegate?.carCollectionView(self, itemAtIndex: indexPath.item) ?? ""
        cell.update(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.delegate?.carCollectionView(self, didSelectItemAtIndex: indexPath.item)
    }
}
