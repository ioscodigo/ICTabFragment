//
//  ICTabFragmentViewController.swift
//  ICTabFragment
//
//  Created by Digital Khrisna on 6/1/17.
//  Copyright © 2017 codigo. All rights reserved.
//

import UIKit

public enum ICTabSize {
    case fit
    case dynamic
}

open class ICTabFragmentViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView!
    
    fileprivate lazy var tabs = [ICTabModel]()
    
    fileprivate var textColorSelected = UIColor.blue
    
    fileprivate var textColorUnselected = UIColor.black
    
    fileprivate var indicatorColorSelected = UIColor.blue
    
    fileprivate var indicatorColorUnselected = UIColor.black
    
    fileprivate var tabSize = ICTabSize.dynamic
    
    fileprivate var tabFitSize: CGFloat = 2
    
    internal var parentDelegate: ICTabParentProtocol?
    
    public func create(tabView: UIView, containerView: UIView, tabModel: [ICTabModel], tabProperties: [String : UIColor]? = nil, tabSizeProperties: [String : Any]? = nil) {
        
        self.tabs = tabModel
        
        if let properties = tabProperties {
            self.textColorSelected = properties["textColorSelected"]!
            self.textColorUnselected = properties["textColorUnselected"]!
            self.indicatorColorSelected = properties["indicatorColorSelected"]!
            self.indicatorColorUnselected = properties["indicatorColorUnselected"]!
        }
        
        if let sizeProperties = tabSizeProperties {
            self.tabSize = sizeProperties["tabSize"] as! ICTabSize
            self.tabFitSize = CGFloat(sizeProperties["tabFitSize"] as! Int)
        }
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 10, height: 10)
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: tabView.frame, collectionViewLayout: collectionViewLayout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.clear
        
        tabView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.widthAnchor.constraint(equalTo: tabView.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: tabView.heightAnchor, multiplier: 1.0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: tabView.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: tabView.centerYAnchor).isActive = true
        
        let nib = UINib(nibName: "ICTabCollectionViewCell", bundle: Bundle(for: ICTabCollectionViewCell.self))
        collectionView.register(nib, forCellWithReuseIdentifier: "ictabcollectionviewcell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupChildView(container: containerView)
    }
    
    private func setupChildView(container: UIView){
        let vc = ICTabPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.childDelegate = self
        
        var viewController = [UIViewController]()
        var initialSelected = 0
        
        for (index, value) in tabs.enumerated() {
            viewController.append(value.tabView)
            
            if value.isSelected {
                initialSelected = index
            }
        }
        
        vc.initialSelected = initialSelected
        vc.listViewController = viewController
        
        addChildViewController(vc)
        vc.view.frame = container.bounds
        container.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
}

extension ICTabFragmentViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ictabcollectionviewcell", for: indexPath) as! ICTabCollectionViewCell
        
        cell.tabNameLabel.text = tabs[indexPath.row].tabName
        
        if tabs[indexPath.row].isSelected {
            cell.tabNameLabel.textColor = self.textColorSelected
            cell.indicatorView.isHidden = false
            cell.indicatorView.backgroundColor = self.indicatorColorSelected
        } else {
            cell.indicatorView.isHidden = true
            cell.tabNameLabel.textColor = self.textColorUnselected
        }
        
        return cell
    }
}

extension ICTabFragmentViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let previous = tabs.index(where: {$0.isSelected }) else { return }
        
        parentDelegate?.didParentButtonTapped(indexPath.row, row: previous, parent: collectionView)
        
        tabs[previous].isSelected = false
        tabs[indexPath.row].isSelected = true
        
        if indexPath.row != previous {
            collectionView.reloadItems(at: [IndexPath(row: previous, section: 0), indexPath])
        }
    }
}

extension ICTabFragmentViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.tabSize == .dynamic {
            let heigth = (tabs[indexPath.row].tabName as NSString).size(attributes: nil).height + 10
            let width = (tabs[indexPath.row].tabName as NSString).size(attributes: nil).width + 50
            
            return CGSize(width: width, height: heigth)
        } else {
            return CGSize(width: collectionView.frame.width / self.tabFitSize, height: collectionView.frame.height)
        }
    }
}

extension ICTabFragmentViewController: ICTabChildProtocol {
    func didChildChangeFrame(_ row: Int) {
        guard let previous = tabs.index(where: {$0.isSelected }) else { return }
        
        tabs[previous].isSelected = false
        tabs[row].isSelected = true
        
        let indexPath = IndexPath(row: row, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if indexPath.row != previous {
            collectionView.reloadItems(at: [IndexPath(row: previous, section: 0), indexPath])
        }
    }
}
