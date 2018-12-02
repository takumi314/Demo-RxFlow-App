//
//  AppDelegate.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 19/11/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let disposeBag = DisposeBag()

    var window: UIWindow?

    var coordinator = Coordinator()

    var appFlow: AppFlow!

    lazy var appService: AppServices = {
        return AppServices()
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        // window = UIWindow(frame: UIScreen.main.bounds)
        // listen for Coordinator mechanism is not mandatory
        guard let window = window else { return false }

        // listen for Coordinator mechanism is not mandatory
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            print ("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: disposeBag)

        self.appFlow = AppFlow(withWindow: window, andServices: self.appService)

        // The navigation begins with the AppFlow at TableView Step
        coordinator.coordinate(flow: appFlow, withStepper: OneStepper(withSingleStep: DemoStep.tableView))

        return true
    }

}
