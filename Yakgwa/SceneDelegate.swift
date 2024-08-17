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
import DetailScene

import Domain
import Data

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        appCoordinator = AppCoordinator(window: self.window!)

        appCoordinator?.start()
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
        
        guard let url = URLContexts.first?.url else { return }
        handleDeepLinkWithKakao(url)
        // MARK: - URL
        print("SceneDelegate with url: \(url)")
    }
}

extension SceneDelegate {
    private func handleDeepLinkWithKakao(_ url: URL) {
        
        guard let scheme = url.scheme, scheme == "kakao6125fa6ae1efc29d385873c2b891e24e" else { return }
        
        let host = url.host
        
        if host == "kakaolink" {
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            if let items = components?.queryItems?.first(where: { $0.name == "inviteId"})?.value {
                if let meetId: Int = Int(items) {
                    routeToDetailScene(with: MeetID(meetId))
                }
            }
            
        }
    }
    
    private func routeToDetailScene(with meetId: MeetID) {
    }
}

