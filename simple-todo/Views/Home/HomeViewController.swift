//
//  HomeViewController.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/6/21.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    var mainView: HomeView! { return self.view as? HomeView }
    let viewModel = LoginViewModel()
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViewModelBinding()
        createCallbacks()
    }
    
    override func loadView() {
        self.view = HomeView(frame: UIScreen.main.bounds)
    }
    
    func createViewModelBinding() {
        mainView.logoutButton.rx.tap.do(onNext: { [unowned self] in
            self.mainView.logoutButton.isEnabled = false
        }).subscribe(onNext: { [unowned self] in
            self.viewModel.logoutUser()
            self.mainView.logoutButton.isEnabled = true
        }).disposed(by: disposedBag)
    }
    func createCallbacks() {}
}
