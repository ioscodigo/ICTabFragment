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

internal protocol ICTabFragmentProtocol {
    var textColorSelected: UIColor { get set }
    
    var textColorUnselected: UIColor { get set }
    
    var indicatorColorSelected: UIColor { get set }
    
    var indicatorHeight: CGFloat { get set }
    
    var indicatorTopSpace: CGFloat { get set }
    
    var textFont: UIFont { get set }
    
    var tabSize: ICTabSize { get set }
    
    var tabFitSize: CGFloat { get set }
    
    var tabLineSpacing: CGFloat { get set }
    
    var tabInterSpacing: CGFloat { get set }
}

open class ICTabFragmentViewController: NSObject, ICTabFragmentProtocol {
    fileprivate var context: UIViewController
    
    fileprivate var tabs: [ICTabModel]
    
    fileprivate var tabView: UIView
    
    fileprivate var containerView: UIView
    
    fileprivate var collectionView: UICollectionView?
    
    internal var parentDelegate: ICTabParentProtocol?
    
    open var textColorSelected: UIColor = UIColor.blue
    
    open var textColorUnselected: UIColor = UIColor.black
    
    open var indicatorColorSelected: UIColor = UIColor.blue
    
    open var indicatorHeight: CGFloat = 5
    
    open var indicatorTopSpace: CGFloat = 0
    
    open var textFont: UIFont = UIFont.systemFont(ofSize: 12)
    
    open var tabSize: ICTabSize = ICTabSize.dynamic
    
    open var tabFitSize: CGFloat = 1
    
    open var tabLineSpacing: CGFloat = 0
    
    open var tabInterSpacing: CGFloat = 0
    
    required public init(context: UIViewController, tabs: [ICTabModel], tabView: UIView, containerView: UIView) {
        self.context = context
        self.tabs = tabs
        self.tabView = tabView
        self.containerView = containerView
    }
}

extension ICTabFragmentViewController {
    public func create() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 10, height: 10)
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView = UICollectionView(frame: tabView.frame, collectionViewLayout: collectionViewLayout)
        self.collectionView?.isScrollEnabled = true
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.backgroundColor = UIColor.clear
        
        if let cv = self.collectionView {
            tabView.addSubview(cv)
            
            cv.translatesAutoresizingMaskIntoConstraints = false
            
            cv.widthAnchor.constraint(equalTo: tabView.widthAnchor, multiplier: 1.0).isActive = true
            cv.heightAnchor.constraint(equalTo: tabView.heightAnchor, multiplier: 1.0).isActive = true
            cv.centerXAnchor.constraint(equalTo: tabView.centerXAnchor).isActive = true
            cv.centerYAnchor.constraint(equalTo: tabView.centerYAnchor).isActive = true
            cv.register(ICTabCollectionViewCell.self, forCellWithReuseIdentifier: "ictabcollectionviewcell")
            cv.delegate = self
            cv.dataSource = self
            
            setupChildView()
        }
    }
    
    private func setupChildView() {
        let vc = ICTabPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.childDelegate = self
        
        var viewController = [UIViewController]()
        
        for (index, value) in tabs.enumerated() {
            viewController.append(value.tabView)
            
            if index == 0 {
                value.isSelected = true
            }
        }
        
        vc.listViewController = viewController
        vc.context = self
        
        context.addChildViewController(vc)
        vc.view.frame = self.containerView.bounds
        self.containerView.addSubview(vc.view)
        vc.didMove(toParentViewController: context)
    }
}

extension ICTabFragmentViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ictabcollectionviewcell", for: indexPath) as! ICTabCollectionViewCell
        
        cell.tabNameLabel.text = tabs[indexPath.row].tabName
        cell.tabNameLabel.font = self.textFont
        cell.indicatorHeight = self.indicatorHeight
        cell.indicatorTopSpace = self.indicatorTopSpace
        
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
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.tabLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.tabInterSpacing
    }
}

extension ICTabFragmentViewController: ICTabChildProtocol {
    func didChildChangeFrame(_ row: Int) {
        guard let previous = tabs.index(where: {$0.isSelected }) else { return }
        
        tabs[previous].isSelected = false
        tabs[row].isSelected = true
        
        let indexPath = IndexPath(row: row, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if indexPath.row != previous {
            collectionView?.reloadItems(at: [IndexPath(row: previous, section: 0), indexPath])
        }
    }
}
