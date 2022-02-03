//
//  SecondViewController.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    private var secondView: SecondView?
    private var secondPresenter: SecondScreenPresenter
    
    struct Dependencies {
        let presenter: SecondScreenPresenter
    }

    init(dependencies: Dependencies) {
        self.secondPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let secondView = SecondView()
        self.view.addSubview(secondView)
        
        self.setupBackButton()
        
        secondView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            secondView.topAnchor.constraint(equalTo: self.view.topAnchor),
            secondView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        self.secondPresenter.loadView(controller: self, view: secondView)
    }
    
    private func setupBackButton() {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.366, green: 0.692, blue: 0.457, alpha: 1)
    }
}



