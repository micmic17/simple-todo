//
//  SignUpService.swift
//  simple-todo
//
//  Created by Mickale Saturre on 7/22/21.
//

import Foundation
import Firebase

protocol SignUpAPIService: AnyObject {
    func signUpUser(
        email: String,
        password: String,
        firstName: String,
        middleName: String,
        lastName: String,
        suffix: String,
        age: String,
        gender: String,
        mobileNumber: String,
        address: String,
        completion: @escaping (Result<String, Error>) -> Void
    )
}

class SignUpService: SignUpAPIService {
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()

    func signUpUser(
        email: String,
        password: String,
        firstName: String,
        middleName: String,
        lastName: String,
        suffix: String,
        age: String,
        gender: String,
        mobileNumber: String,
        address: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            guard let response = authResult else { return }
            
            let userObject: [String: Any] = [
                "userId": response.user.uid,
                "username": email,
                "password": password,
                "firstName": firstName,
                "middleName": middleName,
                "lastName": middleName,
                "suffix": suffix,
                "age": age,
                "gender": gender,
                "mobileNumber": mobileNumber,
                "address": address
            ]
            
            print(response.user.email!)

            self.firestore.collection("users").document("userDetails").setData(userObject) { err in
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.success(response.user.uid))
                }
            }
        }
    }
}
