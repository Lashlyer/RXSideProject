//
//  IUserDataRepository.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import Foundation
import RxSwift

protocol IUserDataRepository {
    func callUserDataApi(url: String) -> Single<HttpStatus<UserDataResponse>>
}

class UserDataRepository: IUserDataRepository {
    var http: HttpRequest
    
    init(_ httpRequest: HttpRequest) {
        self.http = httpRequest
    }
    
    func callUserDataApi(url: String) -> Single<HttpStatus<UserDataResponse>> {
        http.decodeApiResult(url: url)
    }
}
