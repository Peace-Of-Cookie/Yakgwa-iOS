//
//  SceneDelegate.swift
//  Yakgwa
//
//  Created by Ekko on 7/5/24.
//

import UIKit

import SceneKit
import Network

import KakaoSDKAuth

import SplashScene
import HomeScene
import LoginScene
import InputAppointmentInfoScene
import SelectAppointmentThemeScene
import AddAppointmentLocationScene
import SelectAppointmentDateScene
import MyPageScene
import MainScene

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//        let splashReactor = SplashReactor()
//        let splashViewController = SplashViewController(reactor: splashReactor)
        appCoordinator = AppCoordinator(window: self.window!)

        appCoordinator?.start()
        
        
        
//        let mainTabBarReactor = MainTabBarViewReactor()
//        let mainTabBarController = MainTabBarController(reactor: mainTabBarReactor)
//        let mainTabBarCoordinator = MainTabBarCoordinator(window: self.window, viewController: mainTabBarController)
//        mainTabBarCoordinator.start()
        
//        let testViewController = MyPageViewController()
//        
//        window.rootViewController = testViewController
//        window.makeKeyAndVisible()
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

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                let _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }

}

