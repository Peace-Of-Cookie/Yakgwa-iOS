//
//  LoginUseCase.swift
//
//
//  Created by Kim Dongjoo on 7/12/24.
//
import RxSwift

protocol LoginUseCaseProtocol {
    func kakaoLogin() -> Observable<Bool>
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let loginService: LoginServiceType
    
    init(loginService: LoginServiceType) {
        self.loginService = loginService
    }
    
    func kakaoLogin() -> Observable<Bool> {
        return loginService.requestKakaoLogin()
    }
}
