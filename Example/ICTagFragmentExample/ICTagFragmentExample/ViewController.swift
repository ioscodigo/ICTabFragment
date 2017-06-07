//
//  ViewController.swift
//  ICTagFragmentExample
//
//  Created by Digital Khrisna on 6/7/17.
//  Copyright © 2017 codigo. All rights reserved.
//

import UIKit
import ICTabFragment

class ViewController: UIViewController {

    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tabs = [
            ICTabModel(tabName: "Recommendation", tabView: storyboard?.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController),
            ICTabModel(tabName: "Trending", tabView: storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController),
            ICTabModel(tabName: "Last Week Winner", tabView: storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController)
        ]
        
        let tabFragment = ICTabFragmentViewController(context: self, tabs: tabs, tabView: tabView, containerView: containerView)
        tabFragment.textColorUnselected = UIColor.blue
        tabFragment.textColorSelected = UIColor.cyan
        tabFragment.indicatorColorSelected = UIColor.cyan
        tabFragment.create()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

