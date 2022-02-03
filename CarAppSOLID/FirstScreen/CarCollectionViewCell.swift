//
//  CarCollectionViewCell.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

final class CarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CarCollectionViewCell"
    
    private let iconImage = UIImageView()
    private let brandLabel = UILabel()
    private let selectLabel = UILabel()
    
    private enum Metrics {
        static let brandLabelFontSize: CGFloat = 16.0
        static let selectLabelFontSize: CGFloat = 14.0
        static let iconImageHeight: CGFloat = 16
        static let iconImageWidth: CGFloat = 16.0
        static let iconImageTopConst: CGFloat = 8.0
        static let brandLabelLeading: CGFloat = 32.0
        static let brandLabelHeight: CGFloat = 19.0
        static let brandLabelTopConst: CGFloat = 8.0
        static let selectLabelTopConst: CGFloat = 8.0
    }
    
    override var isSelected: Bool {
         didSet {
             if self.isSelected {
                 backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
             } else {
                 backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
             }
         }
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(iconImage)
        self.addSubview(brandLabel)
        self.addSubview(selectLabel)
        
        self.allAppearence()
        self.iconImageSetupLayout()
        self.brandLabelSetupLayout()
        self.selectLabelSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarCollectionViewCell {
    private func allAppearence() {
        self.backgroundColor = .white
        self.brandLabel.text = "BMW"
        self.brandLabel.font = UIFont.systemFont(ofSize: Metrics.brandLabelFontSize, weight: .medium)
        self.selectLabel.text = "Select"
        self.selectLabel.textAlignment = .right
        self.selectLabel.font = UIFont.systemFont(ofSize: Metrics.selectLabelFontSize, weight: .regular)
        self.iconImage.image = UIImage(named: "green")
    }
    
    private func iconImageSetupLayout() {
        self.iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.iconImage.heightAnchor.constraint(equalToConstant: Metrics.iconImageHeight),
            self.iconImage.widthAnchor.constraint(equalToConstant: Metrics.iconImageWidth),
            self.iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.iconImage.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.iconImageTopConst),
        ])
    }
    
    private func brandLabelSetupLayout() {
        self.brandLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.brandLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.brandLabelLeading),
            self.brandLabel.heightAnchor.constraint(equalToConstant: Metrics.brandLabelHeight),
            self.brandLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.brandLabelTopConst)
        ])
    }
    
    private func selectLabelSetupLayout() {
        self.selectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.selectLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.selectLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.selectLabelTopConst),
        ])
    }
    func update(_ item: String) {
        self.brandLabel.text = item
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.brandLabel.text = nil
    }
}
