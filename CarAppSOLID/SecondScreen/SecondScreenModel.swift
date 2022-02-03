//
//  SecondScreenModel.swift
//  CarAppSOLID
//
//  Created by Sveta on 06.12.2021.
//

import Foundation

protocol ISecondScreenModel {
    var selectedItemIndex: Int { get set }

    func getData()
    func itemsCount() -> Int
    func itemAtIndex(_ index: Int) -> Car

    func getSelectedItem(completion: @escaping (Car) -> Void)
}

final class SecondScreenModel {
    private var carArray: [Car] = []
    private let type: String
    
    var selectedItemIndex = 0
    
    init(type: String) {
        self.type = type
    }
}

extension SecondScreenModel: ISecondScreenModel {
    
    func itemAtIndex(_ index: Int) -> Car {
        return carArray[index]
    }
    
    func itemsCount() -> Int {
        return carArray.count
    }

    func getData() {
        carArray = Car.loadCars(key: self.type)
    }
        
    func getSelectedItem(completion: @escaping (Car) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let item = self.carArray[self.selectedItemIndex]
            completion(item)
        }
    }
}
