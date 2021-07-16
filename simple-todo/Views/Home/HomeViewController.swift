//
//  HomeViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit

class HomeViewController: UIViewController {
    var mainView: HomeView! { return self.view as? HomeView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = HomeView(frame: UIScreen.main.bounds)
    }
}
