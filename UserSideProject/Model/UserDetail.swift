//
//  UserDetail.swift
//  UserSideProject
//
//  Created by Alvin on 2022/2/7.
//

import Foundation

open class UserDataResponse: Codable {
    private var _userData: [User]?
    var userData: [User] {
        _userData ?? []
    }
    
    enum UserDataCodingKey: String, CodingKey {
        case data
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserDataCodingKey.self)
        _userData = try container.decodeIfPresent([User].self, forKey: .data)
    }
    public func encode(to encoder: Encoder) throws {}
    
    struct User: Codable {
        
        private var _id: Int?
        private var _email: String?
        private var _firstName: String?
        private var _lastName: String?
        private var _avatar: String?
        
        var id: String {
            "\(String(describing: _id ?? 0))"
        }
        var email: String {
            _email ?? ""
        }
        var firstName: String {
            _firstName ?? ""
        }
        var lastName: String {
            _lastName ?? ""
        }
        var avatar: String {
            _avatar ?? ""
        }
        
        enum UserCodingKey: String, CodingKey {
            case id
            case email
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: UserCodingKey.self)
            _id = try container.decodeIfPresent(Int.self, forKey: .id)
            _email = try container.decodeIfPresent(String.self, forKey: .email)
            _firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            _lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            _avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        }
        
    }
}
