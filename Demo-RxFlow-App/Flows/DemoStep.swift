//
//  DemoStep.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 02/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import Foundation
import RxFlow

/// As Steps are seen like some navigation states spread across the application,
/// it seems pretty obvious to use an enum to declare them
enum DemoStep: Step {
    case splash         // for Splash
    case tableView      // for TableView

    case webView(target: WebScheme)
}

struct WebScheme {
    // Web
}
