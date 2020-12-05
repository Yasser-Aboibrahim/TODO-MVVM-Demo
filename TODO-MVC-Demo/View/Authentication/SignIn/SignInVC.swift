//
//  SignInVC.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 10/28/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit

// 1-
protocol AuthNavigationDelegate: class {
    func showMainState()
}

protocol SignInVCProtocol: class{
    func showAlert(alertTitle: String, message: String, actionTitle: String)
    func showLoader()
    func hideLoader()
    func goToTodoListVC()
    func goToSignUpVC()
}

class SignInVC: UIViewController {
    

    // MARK:- Properties
    var viewModel: SignInViewModelProtocol!
    @IBOutlet var signInView: SignInView!
    // 2-
    weak var delegate: AuthNavigationDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceHolders()
        UserDefaultsManager.shared().isLoggedIn = false
        signInView.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.viewModel = SignInViewModel(view: signInVC)
        return signInVC
    }
    
    // MARK:- Actions
    @IBAction func signInSubmittBtn(_ sender: UIButton) {
        viewModel.logInUser(email: signInView.userEmailTextField.text!, password: signInView.userPasswordTextField.text!)
        
    }
    
    @IBAction func signUpAccountBtnTapped(_ sender: UIButton) {
        goToSignUpVC()
    }
}

// MARK:- Extension Private Methods
extension SignInVC{
    private func setPlaceHolders(){
        signInView.userEmailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        signInView.userPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    
}

// MARK:- extension SignIn Presenter
extension SignInVC: SignInVCProtocol{
    
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        ShowAlertsManager.showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
    
    func goToTodoListVC(){
        // 3-
        self.delegate?.showMainState()
//        let todoListVC = TodoListVC.create()
//        navigationController?.pushViewController(todoListVC, animated: true)
    }
    
    
    func goToSignUpVC() {
        let signUpVC = SignUpVC.create()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
