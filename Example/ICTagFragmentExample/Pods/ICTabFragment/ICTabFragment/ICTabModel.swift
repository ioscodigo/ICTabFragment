//
//  ICTabModel.swift
//  ICTabFragment
//
//  Created by Digital Khrisna on 6/1/17.
//  Copyright © 2017 codigo. All rights reserved.
//

import UIKit

open class ICTabModel {
    var tabName: String
    var tabView: UIViewController
    var isSelected: Bool = false
    
    public init(tabName: String, tabView: UIViewController) {
        self.tabName = tabName
        self.tabView = tabView
    }
}
