//
//  SecondCollectionViewCell.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

final class BodyCollectionViewCell: UICollectionViewCell {
    static let identifier = "BodyCollectionViewCell"

    private let bodyTypeLabel = UILabel()
    private var imageChoice = UIImageView()
    
    private enum Metrics {
        static let bodyTypeLabelFontSize: CGFloat = 16.0
        static let bodyTypeLabelHeight: CGFloat = 19.0
        static let imageChoiceHeight: CGFloat = 12.0
        static let imageChoiceWidth: CGFloat = 12.0
    }
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                imageChoice.image = UIImage(named: "Radio")
            } else {
                imageChoice.image = UIImage(named: "Radio-1")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bodyTypeLabel)
        self.addSubview(imageChoice)
        
        self.allAppearence()
        self.bodyTypeLabelSetupLayout()
        self.imageChoiceSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension BodyCollectionViewCell {

    private func allAppearence() {
        self.bodyTypeLabel.font = UIFont.systemFont(ofSize: Metrics.bodyTypeLabelFontSize, weight: .medium)
        self.imageChoice.image = UIImage(named: "Radio-1")
    }
    
    private func bodyTypeLabelSetupLayout() {
        self.bodyTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.bodyTypeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bodyTypeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.bodyTypeLabel.heightAnchor.constraint(equalToConstant: Metrics.bodyTypeLabelHeight)
        ])
    }
    
    private func imageChoiceSetupLayout() {
        self.imageChoice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageChoice.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageChoice.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.imageChoice.heightAnchor.constraint(equalToConstant: Metrics.imageChoiceHeight),
            self.imageChoice.widthAnchor.constraint(equalToConstant: Metrics.imageChoiceWidth)
        ])
    }
    
    func update(_ item: Car?) {
        self.bodyTypeLabel.text = item?.body.localized()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bodyTypeLabel.text = nil
    }
}
