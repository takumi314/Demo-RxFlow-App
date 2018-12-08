//
//  AppFlow.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 28/11/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import UIKit
import RxFlow

struct AppServices { }

final class AppFlow: Flow {

    var root: Presentable {
        return self.rootWindow
    }

    private let rootWindow: UIWindow
    private let services: AppServices

    // MAARK: - Initializer

    init(withWindow window: UIWindow, andServices services: AppServices) {
        self.rootWindow = window
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }

    func navigate(to step: Step) -> NextFlowItems {
        guard let step = step as? DemoStep else { return NextFlowItems.none }

        switch step {
        case .tableView:
            return navigationToTableViewScreen()
        case .tabBar:
            return navigationToTabBarScreen()
        default:
            return .none
        }
    }

    func navigationToTableViewScreen() -> NextFlowItems {
        let tableViewFlow = TableViewFlow(withServices: services)
        Flows.whenReady(flow1: tableViewFlow) { [unowned self](root) in
            self.rootWindow.rootViewController = root
        }
        return .one(flowItem: NextFlowItem(nextPresentable: tableViewFlow,
                                           nextStepper: OneStepper(withSingleStep: DemoStep.tableView)))
    }

    func navigationToTabBarScreen() -> NextFlowItems {
        let tabBarFlow = TabBarFlow(withServices: services)
        Flows.whenReady(flow1: tabBarFlow) { [unowned self](root) in
            self.rootWindow.rootViewController = root
        }
        return .one(flowItem: NextFlowItem(nextPresentable: tabBarFlow,
                                           nextStepper: OneStepper(withSingleStep: DemoStep.tabBar)))
    }


}

/// a Stepper has only one purpose is: emits Steps that correspond to specific navigation states.
/// The Step changes lead to navigation actions in the context of a specific Flow
final class AppStepper: Stepper {

    init() {
        self.step.accept(NoneStep())
    }

//    init(withServices services: AppServices) {
//        if services.preferencesService.isOnboarded() {
//            self.step.accept(DemoStep.dashboard)
//        } else {
//            self.step.accept(DemoStep.onboarding)
//        }
//    }
}

struct NoneStep: Step {
    // default
}

class SplashFlow: Flow {

    var root: Presentable {
        return self.splash
    }

    private let splash  = ViewController()

    // MARK: - Initializer

    init() {
        // No particular
    }

    func navigate(to step: Step) -> NextFlowItems {
        return NextFlowItems.none
    }

}

