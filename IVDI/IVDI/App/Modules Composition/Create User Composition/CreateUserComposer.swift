//
//  CreateUserComposer.swift
//  IVDI
//
//  Created by Rasik on 25/03/22.
//

import UIKit
import CreateUser
import CreateUseriOS

public final class CreateUserUIComposer {
    public typealias NewUserCreated = () -> Void
    
    
    private init() {}
    
    public static func createUserComposedWith(userCreator: UserCreator, newUserCreated: @escaping NewUserCreated) -> CreateUserViewController {
        let presentationAdapter = UserCreatorPresentationAdapter(
            userCreator: MainQueueDispatchDecorator(decoratee: userCreator))
        
        let createUserController = makeCreateUserViewController(
            delegate: presentationAdapter,
            title: CreateUserPresenter.title)
        
        let userView = CreateUserViewAdapter(controller: createUserController, userCreated: newUserCreated)
        
        presentationAdapter.presenter = CreateUserPresenter(
            userView: userView,
            loadingView: WeakRefVirtualProxy(createUserController),
            errorView: WeakRefVirtualProxy(createUserController))
        
        return createUserController
    }

    private static func makeCreateUserViewController(delegate: CreateUserViewControllerDelegate, title: String) -> CreateUserViewController {
        let bundle = Bundle(for: CreateUserViewController.self)
        let storyboard = UIStoryboard(name: "CreateUser", bundle: bundle)
        let createUserController: CreateUserViewController = storyboard.instantiate()
        createUserController.delegate = delegate
        createUserController.title = title
        return createUserController
    }
}


