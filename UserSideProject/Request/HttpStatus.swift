//
//  HttpStatus.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import Foundation

public enum HttpStatus<T> {
    case data(_ data: T)
    case error(_ error: AppError)
}

public enum AppError: Error, CustomStringConvertible{

    case message(String)
    case generic(Error)
    public var description: String { 
        switch self {
        case let .message(message):
            return message
        case let .generic(error):
            return "網路連線異常 錯誤代碼 : \((error as NSError).localizedDescription)"
        }
    }
    public init(_ message: String) {
        self = .message(message)
        
    }

    public init(_ error: Error) {
        if let error = error as? AppError {
            self = error
        } else {
            self = .generic(error)
        }
    }

}
