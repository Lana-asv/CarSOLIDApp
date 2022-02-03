//
//  FirstScreenModel.swift
//  CarAppSOLID
//
//  Created by Sveta on 06.12.2021.
//

import Foundation

protocol IFirstModel {
    func getData()
    func itemsCount() -> Int
    func itemAtIndex(_ index: Int) -> String
}

final class FirstModel {
    private var carInstance: [String] = []
}

extension FirstModel: IFirstModel {

    func itemAtIndex(_ index: Int) -> String {
        return carInstance[index]
    }
    
    func itemsCount() -> Int {
        return carInstance.count
    }

    func getData() {
        carInstance = Car.loadCarModels()
    }
}

