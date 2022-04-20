//
//  UserListUIComposer.swift
//  IVDI
//
//  Created by Rasik on 29/03/22.
//

import UIKit
import UserList
import UserListiOS

public final class UserListUIComposer {
    private init() {}
    
    public static func userListComposedWith(userLoader: UserLoader) -> UserListViewController {
        let presentationAdapter = UserLoaderPresentationAdapter(userLoader:
            MainQueueDispatchDecorator(decoratee: userLoader))
        
        let userController = makeUserViewController(
            delegate: presentationAdapter,
            title: UserPresenter.title)

        presentationAdapter.presenter = UserPresenter(
            userView: UserViewAdapter(
                controller: userController),
            loadingView: WeakRefVirtualProxy(userController),
            errorView: WeakRefVirtualProxy(userController))
        
        return userController
    }

    private static func makeUserViewController(delegate: UserListViewControllerDelegate, title: String) -> UserListViewController {
        let userController: UserListViewController = UserListViewController.storyboard.instantiate()
        userController.delegate = delegate
        userController.title = title
        return userController
    }
}
