//
//  ProfileVC.swift
//  TODO-MVC-Demo
//
//  Created by yasser on 10/31/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import SDWebImage

// 1-
protocol MainNavigationDelegate: class {
    func showAuthState()
}

protocol ProfileVCProtocol: class{
    func updateUserDataAlert()
    func successfullyLoggedOut()
    func showAlert(alertTitle: String, message: String, actionTitle: String)
    func setUserData(userData: UserData)
    func setUserImage(image: UIImage)
    func userNameWithNoImage(nameInitials: String)
    func showLoader()
    func hideLoader()
}

class ProfileVC: UITableViewController {

    // MARK:- Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameWithNoImage: UILabel!
    
    // MARK:- Properties
    var userData: UserData?
    let imagepicker = UIImagePickerController()
    var viewModel: ProfileViewModelProtocol!
    // 2-
    weak var delegate: MainNavigationDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavbar()
        imagepicker.delegate = self
        viewModel.getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK:- Public Methods
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.profileVC)
        profileVC.viewModel = ProfileViewModel(view: profileVC)
        return profileVC
    }
    
    
    // MARK:- Actions
    @IBAction func logOutBtn(_ sender: UIButton) {
        viewModel.logOut()
    }
    
    @IBAction func updateUserDataBtnTapped(_ sender: UIButton) {
        updateUserDataAlert()
    }
}

// MARK:- Extension Image Picker
extension ProfileVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            viewModel.uploadUserImage(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- Extension Private Methods
extension ProfileVC{
    private func goToSignInVC() {
        // 3-
        self.delegate?.showAuthState()
    }
    
    private func setNavbar(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Upload Photo", style: .plain, target: self, action: #selector(tapRightBtn))
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 15.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.white],for: .normal)
    }
    
    @objc private func tapRightBtn(){
        imagepicker.allowsEditing = true
        imagepicker.sourceType = .photoLibrary
        present(imagepicker, animated: true, completion: nil)
    }
}

extension ProfileVC: ProfileVCProtocol{
    func updateUserDataAlert(){
        let alertController = UIAlertController(title: "Update Age", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "New Age"
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let taskTextField = alertController.textFields![0] as UITextField
            if let taskTF = Int(taskTextField.text ?? ""){
               self.viewModel.updateUserData(age: taskTF)
            }else{
                self.showAlert(alertTitle: "Error",message: "Please try again",actionTitle: "Dismiss")
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController,animated:  true, completion: nil)
    }
    
    func successfullyLoggedOut() {
        goToSignInVC()
    }
    
    
    func showAlert(alertTitle: String, message: String, actionTitle: String) {
        ShowAlertsManager.showAlertWithCancel(alertTitle: alertTitle, message: message, actionTitle: actionTitle)
    }
    
    func setUserData(userData: UserData) {
        nameLabel.text = userData.name
        emailLabel.text = userData.email
        ageLabel.text = "\(userData.age)"
    }
    
    func setUserImage(image: UIImage) {
        userImageView.image = image
    }
    
    func userNameWithNoImage(nameInitials: String) {
        userNameWithNoImage.text = nameInitials
    }
    
    func showLoader() {
        self.view.showLoading()
    }
    
    func hideLoader() {
        self.view.hideLoading()
    }
}

