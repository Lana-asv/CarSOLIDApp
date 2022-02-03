//
//  SecondView.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

protocol SecondViewDelegate: AnyObject {
    func secondViewNumberOfItems(_ secondView: SecondView) -> Int
    func secondView(_ secondView: SecondView, itemAtIndex index: Int) -> Car?
    func secondView(_ secondView: SecondView, didSelectItemAt index: Int)
    func secondViewPriceButtonTouched(_ secondView: SecondView)
}

final class SecondView: UIView {
    weak var delegate: SecondViewDelegate?
    private let imageCar = UIImageView()
    private let priceLabel = UILabel()
    private let priceNumbersLabel = UILabel()
    private let bodyChoiceLabel = UILabel()
    private let collectionView = BodyCollectionView()
    private var spinner: UIActivityIndicatorView?
    
    private enum Metrics {
        static let priceButtonTitleFontSize: CGFloat = 16.0
        static let priceButtonCorner: CGFloat = 25.0
        static let priceLabelFontSize: CGFloat = 24.0
        static let priceNumbersLabelFont: CGFloat = 16.0
        static let bodyChoiceLabelFontSize: CGFloat = 24.0
        static let leadingConst: CGFloat = 16.0
        static let trailingConst: CGFloat = -16.0
        static let imageCarTopConst: CGFloat = 76.0
        static let imageCarHeight: CGFloat = 200.0
        static let priceLabelTopConst: CGFloat = 23.0
        static let priceLabelHeight: CGFloat = 29.0
        static let priceNumbersLabelTopConst: CGFloat = 60.0
        static let priceNumbersLabelHeight: CGFloat = 19.0
        static let bodyChoiceLabelTopConst: CGFloat = 102.0
        static let bodyChoiceLabelHeight: CGFloat = 29.0
        static let collectionViewTopConst: CGFloat = 149.0
        static let collectionViewHeight: CGFloat = 188.0
        static let priceButtonTopConst: CGFloat = -95.0
        static let priceButtonHeight: CGFloat = 51.0
        static let buttonRed:CGFloat = 0.306
        static let buttonGreen: CGFloat = 0.692
        static let buttonBlue: CGFloat = 0.457
        static let buttonAlpha: CGFloat = 1.0
        static let spinnerHeight: CGFloat = 30.0
        static let spinnerWidth: CGFloat = 30.0
        
    }
    
    private var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Рассчитать цену", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.backgroundColor = UIColor(
            red: Metrics.buttonRed,
            green: Metrics.buttonGreen,
            blue: Metrics.buttonBlue,
            alpha: Metrics.buttonAlpha).cgColor
        button.titleLabel?.font = .systemFont(ofSize: Metrics.priceButtonTitleFontSize, weight: .semibold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Metrics.priceButtonCorner
        button.addTarget(self, action: #selector(priceButtonTouched), for: .touchDown)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        self.allAppearence()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
extension SecondView {
    
    private func allAppearence() {
        self.addSubview(imageCar)
        self.addSubview(priceLabel)
        self.addSubview(priceNumbersLabel)
        self.addSubview(bodyChoiceLabel)
        self.addSubview(collectionView)
        self.addSubview(priceButton)
        
        self.allSetup()
        self.imageCarSetupLayout()
        self.priceLabelSetupLayout()
        self.priceNumbersLabelSetupLayout()
        self.bodyChoiceLabelSetupLayout()
        self.collectionViewSetupLayout()
        self.priceButtonSetupLayout()
    }
    
    @objc private func priceButtonTouched() {
        self.delegate?.secondViewPriceButtonTouched(self)
    }
    
    func update(_ item: Car?, selectedIndex: Int) {
        self.priceNumbersLabel.text = item?.price
        guard let image = item?.image else { return }
        self.imageCar.image = UIImage(named: image)
        self.collectionView.select(selectedIndex)
    }
    
    func setLoadingState(_ state: Bool) {
        if state == true {
            createAndShowSpinner()
            return
        }
        
        self.hideSpinner()
    }
    
    private func createAndShowSpinner() {
        if let spinner = self.spinner {
            spinner.removeFromSuperview()
        }
        
        let spinner = UIActivityIndicatorView()
        self.addSubview(spinner)

        spinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.heightAnchor.constraint(equalToConstant: Metrics.spinnerHeight),
            spinner.widthAnchor.constraint(equalToConstant: Metrics.spinnerWidth)
        ])
        spinner.startAnimating()
        self.spinner = spinner
    }
    
    private func hideSpinner() {
        self.spinner?.stopAnimating()
        self.spinner?.removeFromSuperview()
        self.spinner = nil
    }
    
    private func allSetup() {
        self.imageCar.contentMode = .scaleAspectFit
        self.priceLabel.text = "Цена"
        self.priceLabel.textAlignment = .left
        self.priceLabel.font = UIFont.systemFont(ofSize: Metrics.priceLabelFontSize, weight: .medium)
        self.priceNumbersLabel.font = UIFont.systemFont(ofSize: Metrics.priceNumbersLabelFont, weight: .semibold)
        self.bodyChoiceLabel.text = "Выберите тип кузова"
        self.bodyChoiceLabel.font = UIFont.systemFont(ofSize: Metrics.bodyChoiceLabelFontSize, weight: .medium)
    }
    
    private func imageCarSetupLayout() {
        self.imageCar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imageCar.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.imageCarTopConst),
            self.imageCar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConst),
            self.imageCar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConst),
            self.imageCar.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/3)
        ])
    }
    
    private func priceLabelSetupLayout() {
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: imageCar.bottomAnchor, constant: Metrics.priceLabelTopConst),
            self.priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConst),
            self.priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConst),
            self.priceLabel.heightAnchor.constraint(equalToConstant: Metrics.priceLabelHeight)
        ])
    }
    
    private func priceNumbersLabelSetupLayout() {
        self.priceNumbersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.priceNumbersLabel.topAnchor.constraint(equalTo: imageCar.bottomAnchor, constant: Metrics.priceNumbersLabelTopConst),
            self.priceNumbersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConst),
            self.priceNumbersLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConst),
            self.priceNumbersLabel.heightAnchor.constraint(equalToConstant: Metrics.priceNumbersLabelHeight)
        ])
    }
    
    private func bodyChoiceLabelSetupLayout() {
        self.bodyChoiceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.bodyChoiceLabel.topAnchor.constraint(equalTo: imageCar.bottomAnchor, constant: Metrics.bodyChoiceLabelTopConst),
            self.bodyChoiceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConst),
            self.bodyChoiceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConst),
            self.bodyChoiceLabel.heightAnchor.constraint(equalToConstant: Metrics.bodyChoiceLabelHeight)
        ])
    }
    
    private func collectionViewSetupLayout() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: imageCar.bottomAnchor, constant: Metrics.collectionViewTopConst),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConst),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConst),
            self.collectionView.heightAnchor.constraint(equalToConstant: Metrics.collectionViewHeight)
        ])
    }
    
    private func priceButtonSetupLayout() {
        self.priceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.priceButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Metrics.priceButtonTopConst),
            self.priceButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.leadingConst),
            self.priceButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.trailingConst),
            self.priceButton.heightAnchor.constraint(equalToConstant: Metrics.priceButtonHeight)
        ])
    }
}

extension SecondView: BodyCollectionViewDelegate {
    func collectionView(_ bodyCollectionView: BodyCollectionView, shouldSelectItemAt index: Int) {
        self.delegate?.secondView(self, didSelectItemAt: index)
    }
    
    func bodyCollectionViewNumberOfItems(_ bodyCollectionView: BodyCollectionView) -> Int {
        guard let delegate = self.delegate else { return 0 }
        return delegate.secondViewNumberOfItems(self)
    }
    
    func bodyCollectionView(_ bodyCollectionView: BodyCollectionView, itemAtIndex index: Int) -> Car? {
        guard let delegate = self.delegate else { return nil }
        return delegate.secondView(self, itemAtIndex: index)
    }
    
    func bodyCollectionView(_ bodyCollectionView: BodyCollectionView, didSelectItemAt index: Int) {
        self.delegate?.secondView(self, didSelectItemAt: index)
    }
}
