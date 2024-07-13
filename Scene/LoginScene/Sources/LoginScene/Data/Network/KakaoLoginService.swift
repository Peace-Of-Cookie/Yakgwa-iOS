//
//  KakaoLoginService.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//

import Foundation

import Network
import Util
import Local

import RxSwift
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

public protocol LoginServiceType {
    func requestKakaoLogin() -> Observable<Bool>
}

public class KakaoLoginService: LoginServiceType {
    private let apiDataSource: BaseRemoteDataSource<LoginAPI>
    private let disposeBag = DisposeBag()
    
    public init(apiDataSource: BaseRemoteDataSource<LoginAPI>) {
        self.apiDataSource = apiDataSource
    }
    
    public func requestKakaoLogin() -> Observable<Bool> {
            return Observable<Bool>.create { observer in
                if UserApi.isKakaoTalkLoginAvailable() {
                    UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            observer.onError(error)
                        } else if let token = oauthToken?.accessToken {
                            // Configure Request Body
                            let fcmToken: String = FCMTokenManager.readFCMToken() ?? ""
                            
                            let body: [String: Any] = [
                                "loginType": "KAKAO",
                                "fcmToken" : fcmToken
                            ]
                            guard let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                                observer.onError(NSError(domain: "KakaoLoginService",
                                                         code: 0,
                                                         userInfo: [NSLocalizedDescriptionKey: "Failed to serialize body."]))
                                return
                            }
                            
                            // Call the login API using the BaseRemoteDataSource
                            self.apiDataSource.request(.login(token: token, body: bodyData))
                                .subscribe(onSuccess: { response in
                                    do {
                                        let loginResponse = try JSONDecoder().decode(LoginResponseDTO.self, from: response.data)
                                        let tokenSet = loginResponse.result.tokenSet
                                        
                                        AccessTokenManager.saveAccessToken(token: tokenSet.accessToken)
                                        AccessTokenManager.saveRefreshToken(token: tokenSet.refreshToken)
                                        
                                        observer.onNext(true)
                                        observer.onCompleted()
                                    } catch {
                                        observer.onError(error)
                                    }
                                }, onFailure: { error in
                                    observer.onError(error)
                                })
                                .disposed(by: self.disposeBag)
                        }
                    }
                } else {
                    observer.onError(
                        NSError(domain: "KakaoLoginService",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "KakaoTalk login is not available."]))
                }
                return Disposables.create()
            }
        }
}


