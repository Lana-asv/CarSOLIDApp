//
//  FirstView.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit
protocol FirstViewDelegate: AnyObject {
    func firstViewNumberOfItems(_ firstView: FirstView) -> Int
    func firstView(_ firstView: FirstView, itemAtIndex index: Int) -> String
    func firstView(_ firstView: FirstView, didSelectItemAtIndex index: Int)
}

final class FirstView: UIView {
    
    weak var delegate: FirstViewDelegate?
    private let choiceLabel = UILabel()
    private let carBrandLabel = UILabel()
    private let collectionView = CarCollectionView()
    
    private enum Metrics {
        static let choiceLabelFontSize: CGFloat = 30.0
        static let carBrandLabelFontSize: CGFloat = 24.0
        static let choiceLabelHeight: CGFloat = 36.0
        static let choiceLabelWidth: CGFloat = 150.0
        static let choiceLabelTop: CGFloat = 60.0
        static let carBrandLabelHeight: CGFloat = 29.0
        static let carBrandLabelLeading: CGFloat = 18.0
        static let carBrandLabelTrailing: CGFloat = -14.0
        static let carBrandLabelTop: CGFloat = 43.0
        static let collectionViewTop: CGFloat = 20.0
        static let collectionViewLeading: CGFloat = 16.0
        static let collectionViewTrailing: CGFloat = -16.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        
        self.addSubview(choiceLabel)
        self.addSubview(carBrandLabel)
        self.addSubview(collectionView)
        
        self.allAppearence()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
 
extension FirstView {
    private func allAppearence() {
        self.viewAppearence()
        self.choiceLabelSetupLayout()
        self.carBrandLabelSetupLayout()
        self.collectionViewSetupLayout()
    }
    private func viewAppearence() {
        self.choiceLabel.text = "Выберите"
        self.choiceLabel.font = UIFont.systemFont(ofSize: Metrics.choiceLabelFontSize, weight: .semibold)
        self.choiceLabel.textAlignment = .center
        self.carBrandLabel.text = "Марку машины"
        self.carBrandLabel.font = UIFont.systemFont(ofSize: Metrics.carBrandLabelFontSize, weight: .medium)
    }
    
    private func choiceLabelSetupLayout() {
        self.choiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.choiceLabel.heightAnchor.constraint(equalToConstant: Metrics.choiceLabelHeight),
            self.choiceLabel.widthAnchor.constraint(equalToConstant: Metrics.choiceLabelWidth),
            self.choiceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.choiceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.choiceLabelTop)
        ])
    }
    
    private func carBrandLabelSetupLayout() {
        self.carBrandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.carBrandLabel.heightAnchor.constraint(equalToConstant: Metrics.carBrandLabelHeight),
            self.carBrandLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.carBrandLabelLeading),
            self.carBrandLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.carBrandLabelTrailing),
            self.carBrandLabel.topAnchor.constraint(equalTo: choiceLabel.bottomAnchor, constant: Metrics.carBrandLabelTop)
        ])
    }
    
    private func collectionViewSetupLayout() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: carBrandLabel.bottomAnchor, constant: Metrics.collectionViewTop),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.collectionViewLeading),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.collectionViewTrailing)
        ])
    }
}

extension FirstView: CarCollectionViewDelegate {
    func carCollectionViewNumberOfItems(_ carCollectionView: CarCollectionView) -> Int {
        guard let delegate = self.delegate else { return 0 }
        return delegate.firstViewNumberOfItems(self)
    }
    
    func carCollectionView(_ carCollectionView: CarCollectionView, itemAtIndex index: Int) -> String {
        guard let delegate = self.delegate else { return "" }
        return delegate.firstView(self, itemAtIndex: index)
    }
    
    func carCollectionView(_ carCollectionView: CarCollectionView, didSelectItemAtIndex index: Int) {
        self.delegate?.firstView(self, didSelectItemAtIndex: index)
    }
}

