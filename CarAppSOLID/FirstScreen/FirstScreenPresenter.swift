//
//  FirstScreenPresenter.swift
//  CarAppSOLID
//
//  Created by Sveta on 05.12.2021.
//

import Foundation

protocol IFirstScreenPresenter {
    var onDidSelectType: ((String) -> Void)? { get }
    func loadView(controller: FirstViewController, view: FirstView)
}

final class FirstScreenPresenter {
    private let model: FirstModel
    private weak var controller: FirstViewController?
    private weak var firstView: FirstView?

    var onDidSelectType: ((String) -> Void)?

    struct Dependencies {
        let model: FirstModel
    }

    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.model.getData()
    }
}

extension FirstScreenPresenter: IFirstScreenPresenter {
    func loadView(controller: FirstViewController, view: FirstView) {
        self.controller = controller
        self.firstView = view
        self.firstView?.delegate = self
    }
}
extension FirstScreenPresenter: FirstViewDelegate {
    func firstViewNumberOfItems(_ firstView: FirstView) -> Int {
        return self.model.itemsCount()
    }
    
    func firstView(_ firstView: FirstView, itemAtIndex index: Int) -> String {
        return self.model.itemAtIndex(index)
    }
    
    func firstView(_ firstView: FirstView, didSelectItemAtIndex index: Int) {
        let item = self.model.itemAtIndex(index)
        self.onDidSelectType?(item)
    }
}
