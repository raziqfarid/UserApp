//
//  SceneDelegate.swift
//  IVDI
//
//  Created by Rasik on 25/03/22.
//

import UIKit
import UserList
import UserListiOS
import CreateUser
import CreateUseriOS

@available(iOS 13, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // Access Token should be stored in keychain, placed it here for demo purpose
    let accessToken = "a7e839d7dfe8166d972faa8b5cc407cef75d2fbec3d84e04f370d8661b801f11"
    
    lazy var httpClient: URLSessionHTTPClient = {
      return URLSessionHTTPClient(session: URLSession(configuration: .default))
    }()
    
    lazy var userListController: UserListViewController = {
      return configureUserListController()
    }()
    
    private var navigationController: UINavigationController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        navigationController = UINavigationController(
            rootViewController: userListController
        )
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func configureUserListController() -> UserListViewController {
        let remoteUserLoader = RemoteUserLoader(
            url: APIEndpoint.users.getURL(),
            accessToken: accessToken,
            client: httpClient)
        
        let userListController = UserListUIComposer.userListComposedWith(
            userLoader: remoteUserLoader)
        
        userListController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        return userListController
    }
    
    @objc func addButtonClicked() {
        let createUserController = configureUserCreateController(newUserCreated: { [weak userListController, weak self] in
            
            userListController?.delegate?.didRequestUserRefresh()
            self?.navigationController?.popViewController(animated: true)
        })
        
        navigationController?.pushViewController(createUserController, animated: true)
    }
    
    func configureUserCreateController(newUserCreated: @escaping CreateUserUIComposer.NewUserCreated) -> CreateUserViewController {
        let remoteUserCreator = RemoteUserCreator(
            url: APIEndpoint.users.getURL(),
            accessToken: accessToken,
            client: httpClient)
        
        let createUserController = CreateUserUIComposer.createUserComposedWith(
            userCreator: remoteUserCreator,
            newUserCreated: newUserCreated)
        
        return createUserController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

