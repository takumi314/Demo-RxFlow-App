//
//  TableViewFlow.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 02/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import Foundation
import RxFlow

class TableViewFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }

    private let rootViewController = UINavigationController()
    private let services: AppServices

    // MARK: - Initializer

    init(withServices services: AppServices) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? DemoStep else { return .none }

        switch step {
        case .tableView:
            return navigationToTableViewScreen()
        default:
            return .none
        }
    }

    func navigationToTableViewScreen() -> NextFlowItems {
        let viewController = TableViewController.instantiate()
        let addItemTap = UIBarButtonItem(barButtonSystemItem: .add, target: viewController, action: nil)
        let tableViewViewModel = TableViewViewModel(addItemTap: addItemTap.rx.tap.asDriver())
        viewController.viewModel = tableViewViewModel
        

        rootViewController.pushViewController(viewController, animated: true)

        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewController.viewModel))
    }

}
