//
//  UserViewModel.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import Foundation
import RxSwift

class UserViewModel {
    
    enum Status {
        case loadstart
        case loadEnd
        case error(errorMessage: AppError)
        case data(data: UserDataResponse)
    }
    
    private let url = "https://reqres.in/api/users?page=2"
    private let userDataDomainRepository: UserDataDomainRepository
    private let compositeDisposable: CompositeDisposable
    private var disposeKey: CompositeDisposable.DisposeKey?
    
    init(_ userDataDomainRepository: UserDataDomainRepository,
         _ compositeDisposable: CompositeDisposable) {
        self.userDataDomainRepository = userDataDomainRepository
        self.compositeDisposable = compositeDisposable
    }
    
    public func readUserData() -> BehaviorSubject<UserViewModel.Status> {
        if let key = disposeKey {
            compositeDisposable.remove(for: key)
        }
        let userDataBehavior = BehaviorSubject<UserViewModel.Status>(value: .loadstart)
        disposeKey = compositeDisposable.insert(userDataDomainRepository.userDataResult(url: url).observe(on: MainScheduler.instance).subscribe(onSuccess: { status in
            switch status {
                
            case .data(let data):
                userDataBehavior.onNext(.data(data: data))
            case .error(let error):
                userDataBehavior.onNext(.error(errorMessage: error))
            }
            userDataBehavior.onNext(.loadEnd)
        }, onFailure: { error in
            userDataBehavior.onNext(.error(errorMessage: AppError.init(error)))
            userDataBehavior.onNext(.loadEnd)
        }))
        return userDataBehavior
    }
}

