//
//  UserDataDomainRepository.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import Foundation
import RxSwift

class UserDataDomainRepository {
    
    enum UserDataResultType {
        case data(_ data: UserDataResponse)
        case error(_ error: AppError)
    }
    
    private let userDataRepository: IUserDataRepository
    
    init(_ userDataRepository: IUserDataRepository) {
        self.userDataRepository = userDataRepository
    }
    
    public func userDataResult(url: String) -> Single<UserDataResultType> {
        userDataRepository.callUserDataApi(url: url).flatMap { status in
            
            switch status {
                
            case .data(let data):
                return .just(.data(data))
            case .error(let error):
                return .just(.error(error))
            }
        }
    }
    
}
