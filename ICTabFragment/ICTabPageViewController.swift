//
//  ICTabPageViewController.swift
//  ICTabFragment
//
//  Created by Digital Khrisna on 6/1/17.
//  Copyright © 2017 codigo. All rights reserved.
//

import UIKit

class ICTabPageViewController: UIPageViewController {
    
    lazy var listViewController = [UIViewController]()
    
    internal var context: ICTabFragmentViewController?
    
    var childDelegate: ICTabChildProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        if let first = listViewController.first {
            setViewControllers([first], direction: .forward, animated: false, completion: nil)
        }
        
        guard let parent = context else { return }
        parent.parentDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//Mark: Extension class
extension ICTabPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = listViewController.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return listViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = listViewController.index(of: viewController) else{
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard listViewController.count > nextIndex else {
            return nil
        }
        
        return listViewController[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed {
            return
        }
        
        let currentIndex = listViewController.index(where: {$0 == pageViewController.viewControllers?.first})
        childDelegate?.didChildChangeFrame(currentIndex!)
        childDelegate?.didChildCurrentView(listViewController[currentIndex!])
    }
}

extension ICTabPageViewController: UIPageViewControllerDelegate{
    
}

extension ICTabPageViewController: ICTabParentProtocol {
    func didParentButtonTapped(_ row: Int, row previous: Int, parent view: UICollectionView) {
        if row > previous {
            setViewControllers([listViewController[row]], direction: .forward, animated: true, completion: nil)
        } else {
            setViewControllers([listViewController[row]], direction: .reverse, animated: true, completion: nil)
        }
        
        let indexPath = IndexPath(row: row, section: 0)
        view.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        childDelegate?.didChildCurrentView(listViewController[row])
    }
}
