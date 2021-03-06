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

    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.navigationBar.topItem?.title = "TableView"
        return viewController
    }()
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
        let tableViewViewModel = TableViewViewModel(addItemTap: viewController.addButton.rx.tap.asDriver())
        viewController.viewModel = tableViewViewModel

        rootViewController.setViewControllers([viewController], animated: false)

        return .one(flowItem: NextFlowItem(nextPresentable: viewController, nextStepper: viewController.viewModel))
    }

}
