//
//  TabFlow.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 09/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import Foundation
import RxFlow

final class TabBarFlow: Flow {

    private let rootViewController = { () -> UITabBarController in
        let tabBar = UITabBarController()
        return tabBar
    }()
    private let services: AppServices

    // MAARK: - Initializer

    init(withServices services: AppServices) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    // MARK: - Flow

    var root: Presentable {
        return self.rootViewController
    }

    func navigate(to step: Step) -> NextFlowItems {
        return navigationToTabBarViewScreen()
    }

    private func navigationToTabBarViewScreen() -> NextFlowItems {
        let flow1 = TableViewFlow(withServices: services)
        let flow2 = TableViewFlow(withServices: services)
        let flow3 = TableViewFlow(withServices: services)
        let flow4 = TableViewFlow(withServices: services)
        let flow5 = TableViewFlow(withServices: services)

        Flows.whenReady(flow1: flow1, flow2: flow2, flow3: flow3, flow4: flow4, flow5: flow5) {
            [unowned self](root1, root2, root3, root4, root5) in
            let tabBarItem1 = UITabBarItem(title: "Item1", image: UIImage(named: ""), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "Item2", image: UIImage(named: ""), selectedImage: nil)
            let tabBarItem3 = UITabBarItem(title: "Item3", image: UIImage(named: ""), selectedImage: nil)
            let tabBarItem4 = UITabBarItem(title: "Item4", image: UIImage(named: ""), selectedImage: nil)
            let tabBarItem5 = UITabBarItem(title: "Item5", image: UIImage(named: ""), selectedImage: nil)

            root1.tabBarItem = tabBarItem1
            root2.tabBarItem = tabBarItem2
            root3.tabBarItem = tabBarItem3
            root4.tabBarItem = tabBarItem4
            root5.tabBarItem = tabBarItem5

            self.rootViewController.setViewControllers([root1, root2, root3, root4, root5], animated: false)
            self.rootViewController.selectedIndex = 2
        }

        let item1 = NextFlowItem(nextPresentable: flow1, nextStepper: OneStepper(withSingleStep: DemoStep.tableView))
        let item2 = NextFlowItem(nextPresentable: flow2, nextStepper: OneStepper(withSingleStep: DemoStep.tableView))
        let item3 = NextFlowItem(nextPresentable: flow3, nextStepper: OneStepper(withSingleStep: DemoStep.tableView))
        let item4 = NextFlowItem(nextPresentable: flow4, nextStepper: OneStepper(withSingleStep: DemoStep.tableView))
        let item5 = NextFlowItem(nextPresentable: flow5, nextStepper: OneStepper(withSingleStep: DemoStep.tableView))

        return .multiple(flowItems: [item1, item2, item3, item4, item5])
    }

}

final class TabBarStepper: Stepper {

}
