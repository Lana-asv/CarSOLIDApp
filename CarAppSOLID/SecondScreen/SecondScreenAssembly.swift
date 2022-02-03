//
//  SecondScreenAssembly.swift
//  CarAppSOLID
//
//  Created by Sveta on 05.12.2021.
//

import UIKit

final class SecondScreenAssembly {
    static func build(type: String) -> UIViewController {
        let model = SecondScreenModel(type: type)
        let presenter = SecondScreenPresenter(dependencies: .init(model: model))
        return SecondViewController(dependencies: .init(presenter: presenter))
    }
}
