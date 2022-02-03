//
//  SecondCollectionView.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

protocol BodyCollectionViewDelegate: AnyObject {
    func bodyCollectionViewNumberOfItems(_ bodyCollectionView: BodyCollectionView) -> Int
    func bodyCollectionView(_ bodyCollectionView: BodyCollectionView, itemAtIndex index: Int) -> Car?
    func bodyCollectionView(_ bodyCollectionView: BodyCollectionView, didSelectItemAt index: Int)
}

final class BodyCollectionView: UIView {
    
    weak var delegate: BodyCollectionViewDelegate?
    private var secondView: SecondView?
    private let spinner = UIActivityIndicatorView()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BodyCollectionViewCell.self, forCellWithReuseIdentifier: BodyCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func select(_ index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    }
}

extension BodyCollectionView {
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension BodyCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = self.delegate else { return 0 }
        return delegate.bodyCollectionViewNumberOfItems(self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: BodyCollectionViewCell.identifier, for: indexPath) as! BodyCollectionViewCell
        let item = self.delegate?.bodyCollectionView(self, itemAtIndex: indexPath.item)
        cell.update(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.bodyCollectionView(self, didSelectItemAt: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
