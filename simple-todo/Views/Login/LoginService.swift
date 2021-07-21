//
//  LoginService.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/16/21.
//

import Foundation
import Firebase

class LoginService: LoginAPIService {
    private let auth = Auth.auth()
    
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let auth = authResult {
                completion(.success(auth))
            }
        }
    }
    
    func logoutUser(completion: @escaping (Result<String, Error>) -> Void) {
        do {
            try auth.signOut()
            
            DispatchQueue.main.async {
                completion(.success("Logout succesfully"))
            }
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
}

protocol LoginAPIService: AnyObject {
    func loginUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void)
    func logoutUser(completion: @escaping (Result<String, Error>) -> Void)
}
