//
//  ICTabProtocol.swift
//  ICTabFragment
//
//  Created by Digital Khrisna on 6/1/17.
//  Copyright © 2017 codigo. All rights reserved.
//

import UIKit

protocol ICTabParentProtocol {
    func didParentButtonTapped(_ row: Int, row previous: Int, parent view: UICollectionView)
}

protocol ICTabChildProtocol {
    func didChildChangeFrame(_ row: Int)
}
