//
//  FirstViewController.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import UIKit

//protocol IFirstViewController {
//    func didSelectItemAtIndex(indexPath: IndexPath)
//}

final class FirstViewController: UIViewController {
    private var firstView: FirstView?
    private var firstPresenter: FirstScreenPresenter
    
    struct Dependencies {
        let presenter: FirstScreenPresenter
    }

    init(dependencies: Dependencies) {
        self.firstPresenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstView = FirstView()

        self.view.addSubview(firstView)
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            firstView.topAnchor.constraint(equalTo: self.view.topAnchor),
            firstView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        self.firstPresenter.loadView(controller: self, view: firstView)
    }
}


