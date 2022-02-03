//
//  SecondScreenPresenter.swift
//  CarAppSOLID
//
//  Created by Sveta on 06.12.2021.
//

import Foundation

protocol ISecondScreenPresenter {
    func loadView(controller: SecondViewController, view: SecondView)
}

final class SecondScreenPresenter {
    private weak var controller: SecondViewController?
    private weak var secondView: SecondView?
    private let model: SecondScreenModel

    struct Dependencies {
        let model: SecondScreenModel
    }

    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.model.getData()
    }
}

extension SecondScreenPresenter: ISecondScreenPresenter  {
    func loadView(controller: SecondViewController, view: SecondView) {
        self.controller = controller
        self.secondView = view
        self.secondView?.delegate = self

        let selectedIndex = self.model.selectedItemIndex
        self.secondView?.update(nil, selectedIndex: selectedIndex)
        self.selectItem(selectedIndex)
    }
}
extension SecondScreenPresenter: SecondViewDelegate{
    
    func secondViewNumberOfItems(_ secondView: SecondView) -> Int {
        return self.model.itemsCount()
    }
    
    func secondView(_ secondView: SecondView, itemAtIndex index: Int) -> Car? {
        return self.model.itemAtIndex(index)
    }
    
    func secondView(_ secondView: SecondView, didSelectItemAt index: Int) {
        self.model.selectedItemIndex = index
    }
    
    func secondViewPriceButtonTouched(_ secondView: SecondView) {
        let selectedIndex = self.model.selectedItemIndex
        self.selectItem(selectedIndex)
    }
    
    private func selectItem(_ index: Int) {
        self.secondView?.setLoadingState(true)
        self.model.getSelectedItem { [weak self] item in
            self?.secondView?.update(item, selectedIndex: index)
            self?.secondView?.setLoadingState(false)
        }
    }
}
