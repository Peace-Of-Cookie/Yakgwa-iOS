//
//  FCMTokenManager.swift
//
//
//  Created by Ekko on 7/13/24.
//

import Foundation

/// FCM Token Manager
public final class FCMTokenManager {
    /// FCM Token을 Keychain에 저장
    public static func saveFCMToken(token: String) {
        KeyChainManager.save(key: "fcmToken", value: token)
    }
    
    /// FCM Token을 Keychain에서 읽어옴
    public static func readFCMToken() -> String? {
        return KeyChainManager.read(key: "fcmToken")
    }
}
