//
//  ViewController.swift
//  IVDI
//
//  Created by Rasik on 25/03/22.
//

import UIKit
import CreateUser

public protocol CreateUserViewControllerDelegate {
    func didRequestToCreateUser(name: String, gender: String, email: String)
}

public class CreateUserViewController: UIViewController, CreateUserLoadingView, CreateUserErrorView {
   
    @IBOutlet var nameTxtFld: UITextField!
    @IBOutlet var genderTxtFld: UITextField!
    @IBOutlet var emailAddressTxtFld: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var submitButton: UIButton!
    
    public var delegate: CreateUserViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func display(_ viewModel: CreateUserLoadingViewModel) {
        toggleLoader(isLoading: viewModel.isLoading)
    }
    
    public func display(_ viewModel: CreateUserErrorViewModel) {
        showAlertMessage(message: viewModel.message)
    }
    
    private func toggleLoader(isLoading: Bool) {
        activityIndicator.toggle(shouldHide: isLoading)
        submitButton.isHidden = isLoading
        view.layoutIfNeeded()
    }
    
    public func showAlertMessage(message: String, okTapped: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in okTapped?() })
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    @IBAction func submitTapped() {
        self.view.endEditing(true)
        delegate?.didRequestToCreateUser(
            name: nameTxtFld.text!,
            gender: genderTxtFld.text!,
            email: emailAddressTxtFld.text!)
    }
}
