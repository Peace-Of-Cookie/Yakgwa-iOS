//
//  LoginUseCase.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//
import RxSwift

public protocol LoginUseCaseProtocol {
    func kakaoLogin() -> Observable<Bool>
}

public final class LoginUseCase: LoginUseCaseProtocol {
    private let loginService: LoginServiceType
    
    public init(loginService: LoginServiceType) {
        self.loginService = loginService
    }
    
    public func kakaoLogin() -> Observable<Bool> {
        return loginService.requestKakaoLogin()
    }
}
