//
//  FirstScreenAssembly.swift
//  CarAppSOLID
//
//  Created by Sveta on 04.12.2021.
//

import UIKit

final class FirstScreenAssembly {
    static func build() -> UIViewController {
        let router = FirstScreenRouter()
        let presenter = FirstScreenPresenter(
            dependencies: .init(model: FirstModel())
        )

        let controller = FirstViewController(
            dependencies: .init(presenter: presenter)
        )

        router.setRootController(controller: controller)

        presenter.onDidSelectType = { type in
            let targetController = SecondScreenAssembly.build(type: type)
            router.setTargetController(controller: targetController)
            router.next()
        }

        return controller
    }
}
