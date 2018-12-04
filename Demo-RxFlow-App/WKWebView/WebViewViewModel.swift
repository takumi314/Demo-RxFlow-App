//
//  WebViewViewModel.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 03/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

protocol WebService {

}


class WebViewViewModel: ServicesViewModel {
    typealias Services = WebService

    var services: WebService!

    var webScheme: WebScheme!

    
    // MARK: - Initializer

    init(addItemTap: Driver<Void>) {

        // Register addButton tap to append a new "Item" to the dataSource on each tap -> onNext
        addItemTap.drive(onNext: { [unowned self] _ in
            // next event
        }).dispose()

    }

}

extension WebViewViewModel: Stepper {

    func open() {
        self.step.accept(DemoStep.tableView)
    }

}
