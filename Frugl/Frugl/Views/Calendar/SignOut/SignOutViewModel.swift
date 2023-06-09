//
//  SignOutViewModel.swift
//  Frugl
//
//  Created by Jake Gloschat on 4/27/23.
//

import Foundation
import FirebaseAuth

protocol SignOutViewModelDelegate: AnyObject {
    func signOutSuccessfully()
}

struct SignOutViewModel {
    
    // MARK: - Properties
    var delegate: SignOutViewModelDelegate?
    
    init(delegate: SignOutViewModelDelegate) {
        self.delegate = delegate
    }
    
    func signOutAccount() {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOuterror as NSError {
            print("Error Signing Out: %@", signOuterror)
        }
    }
    
    func deleteUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
            // An error happened.
          } else {
            // Account deleted.
          }
        }
    }
}
