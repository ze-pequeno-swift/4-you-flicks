//
//  LoginController.swift
//  ZPMAPP
//
//  Created by Vitor Lentos on 12/10/21.
//

import Foundation
import Alamofire
import FacebookLogin
import GoogleSignIn
import CryptoKit

protocol LoginControllerProtocol: AnyObject {
    func sucess()
    func failure(error: String)
}

class LoginController {
    
    weak var delegate: LoginControllerProtocol?
    let firebase: FirebaseDataService!
    
    init() {
        self.firebase = FirebaseDataService()
        self.firebase.delegate = self
    }
    
    func userIsLogged() -> Bool {
        return FirebaseDataService.userIsLoggedIn()
    }
    
    func login(email: String, password: String) {
        self.firebase.login(email: email, password: password)
    }
    
    func getClientIdFirebase() -> String? {
        return self.firebase.getClientID()
    }
    
    func loginWithFacebook(token: AccessToken) {
        self.firebase.facebookLogin(token: token)
    }

    func loginWithGoogle(user: GIDGoogleUser?) {
        self.firebase.googleLogin(user: user)
    }
    
    func loginWithApple(idTokenString: String, nonce: String) {
        self.firebase.appleLogin(idTokenString: idTokenString, nonce: nonce)
    }
    
    func errorLoginFirebase(error: Error?) -> String {
        guard let _error = error else { return "Houve um erro na autenticação" }
        switch _error._code {
        case 17010:
            return "O acesso a esta conta foi temporariamente desativado devido a muitas tentativas de login malsucedidas. Você pode restaurá-lo imediatamente redefinindo sua senha ou pode tentar novamente mais tarde."
        default:
            print("CODE: \(_error._code)")
            return "Usuário ou senha são inválidos."
        }
    }
    
    func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
              print("Ocorreu um erro com apple login code \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

extension LoginController: FirebaseDataServiceProtocol {
    func success(_ collection: String) {
        if collection == "login" {
            self.delegate?.sucess()
        }
    }
    
    func failure(error: Error?) {
        let message = self.errorLoginFirebase(error: error)
        self.delegate?.failure(error: message)
    }
}
