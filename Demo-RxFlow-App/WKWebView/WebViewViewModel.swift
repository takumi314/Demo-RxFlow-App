//
//  WebViewViewModel.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 03/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import Foundation

protocol WebService {

}


class WebViewViewModel: ServicesViewModel {
    typealias Services = WebService

    var services: WebService!

    
    // MARK: - Initializer

    init() {

    }


}
