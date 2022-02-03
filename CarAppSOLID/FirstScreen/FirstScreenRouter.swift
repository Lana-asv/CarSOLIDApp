//
//  FirstScreenRouter.swift
//  CarAppSOLID
//
//  Created by Sveta on 04.12.2021.
//

import Foundation
import UIKit

protocol IFirstScreenRouter {
    func setRootController(controller: UIViewController)
    func setTargetController(controller: UIViewController)
    func next()
}

final class FirstScreenRouter {
    private var controller: UIViewController?
    private var targertController: UIViewController?
}

extension FirstScreenRouter: IFirstScreenRouter {
    func setRootController(controller: UIViewController) {
        self.controller = controller
    }

    func setTargetController(controller: UIViewController) {
        self.targertController = controller
    }

    func next() {
        guard let next = self.targertController else {
            return
        }
        self.controller?.navigationController?.pushViewController(next, animated: true)
    }
}
