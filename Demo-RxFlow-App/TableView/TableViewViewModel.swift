//
//  TableViewViewModel.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 29/11/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

protocol ListService { }

struct NoneService: ListService { }

class TableViewViewModel: ServicesViewModel {
    typealias Services = ListService

    var services: ListService!


    // MARK: - Private properties

    private let privateDataSource: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()


    // MARK: - Outputs

    public let dataSource: Observable<[String]>


    // MARK: - Initializer

    init(addItemTap: Driver<Void>) {

        // Make the output dataSource an Observable of the privateDataSource
        self.dataSource = privateDataSource.asObservable()

        // Register addButton tap to append a new "Item" to the dataSource on each tap -> onNext
        addItemTap.drive(onNext: { [unowned self] _ in
            self.privateDataSource.accept(self.privateDataSource.value + ["Item"])
        })
        .disposed(by: disposeBag)
        
    }

}

extension TableViewViewModel: Stepper {
    
}
