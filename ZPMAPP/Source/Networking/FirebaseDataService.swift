//
//  FirebaseDataService.swift
//  ZPMAPP
//
//  Created by Felipe Rocha Oliveira on 11/10/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin
import GoogleSignIn
import AuthenticationServices
import CodableFirebase

enum Model: Codable {
    case customer
    case myMovie
    case friend
}

protocol FirebaseRecoveryPasswordProtocol: AnyObject {
    func recovery()
    func errorRecovery(error: Error?)
}

protocol FirebaseDataServiceProtocol: AnyObject {
    func success(_ collection: String)
    func failure(error: Error?)
}

class FirebaseDataService {
    
    private let firebaseDB = Firestore.firestore()
    private let storage = Storage.storage()
    private let firebaseDBRealTime: DatabaseReference!

    private var user: User?
    private var friends: Friend?
    private var customer: Customer?
    private var myMovies: [MyMovie]? = []
    
    weak var delegate: FirebaseDataServiceProtocol?
    weak var delegateRecovery: FirebaseRecoveryPasswordProtocol?
    
    init() {
        self.firebaseDBRealTime = Database.database().reference()
        self.user = getUser()
    }
    
    static func userIsLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    // MARK: - Helper functions for creating encoders and decoders
    
    func loadCustomer() -> Customer? {
        return self.customer
    }
    
    func loadMyMovies() -> [MyMovie]? {
        return self.myMovies
    }
    
    func loadFriends() -> Friend? {
        return self.friends
    }
    
    func updateUser(
        customerData: Customer,
        password: String?
    ) {
        if Auth.auth().currentUser != nil {
            return
        }

        self.updateEmail(email: customerData.email)

        if let _name = customerData.name {
            self.updateName(name: _name)
        }
        
        if let _password = password {
            self.updatePass(password: _password)
        }
        
        self.delegate?.success("users")
    }
    
    func resetPassword(password: String, oldPassword: String) {
        self.updatePass(password: password, oldPassword: oldPassword)
    }
    
    func addDocument(collection: String, data: [String: Any]) {
        firebaseDB.collection(collection).addDocument(data: data) { error in
            if error != nil {
                self.delegate?.failure(error: error)
                return
            }
            print("Insert executed with success")
            self.delegate?.success(collection)
        }
    }
    
    func addDocumentWithId(collection: String, id: String, data: [String: Any]) {
        firebaseDB.collection(collection).document(id).setData(data, merge: true) { error in
            if error != nil {
                self.delegate?.failure(error: error)
                return
            }
            print("Insert executed with success")
            self.delegate?.success(collection)
        }
    }
    
    func firebaseDecodable(response: [String: Any], collection: String) {
        var data: [String: Any] = response
        do {
            switch collection {
            case "users":
                data.removeValue(forKey: "myMovies")
                data.removeValue(forKey: "friends")
                self.customer = try FirestoreDecoder().decode(Customer.self, from: data)
            case "users_movies":
                for (movieID, myMoviesData) in data {
                    guard let _myMoviesData = myMoviesData as? Array<AnyObject> else { return }
                    let dict: [String: Any] = ["tag": _myMoviesData[0], "id": movieID]
                    let myMovie = try FirestoreDecoder().decode(MyMovie.self, from: dict)
                    
                    if let movies = self.myMovies {
                        for (key, _myMovie) in movies.enumerated() {
                            if myMovie.id == _myMovie.id {
                                self.myMovies?.remove(at: key)
                            }
                        }
                    }
                    
                    self.myMovies?.append(myMovie)
                    
                    self.getDocumentWithId(collection: "movies", id: movieID)
                }
            case "movies":
                let movie = try FirestoreDecoder().decode(Movie.self, from: data)
                let movieID = String(movie.id)
                
                if let index = self.myMovies?.firstIndex(where: {$0.id == movieID}) {
                    self.myMovies?[index].movie = movie
                }
            case "friends":
                let friends = try FirebaseDecoder().decode(Friend.self, from: data)
                self.friends = friends
            default :
                print("\(collection) is not found")
            }
        } catch {
            print("Error decode \(error.localizedDescription)")
        }
    }
    
    func getDocumentWithId(collection: String, id: String) {
        let docRef = self.firebaseDB.collection(collection).document(id)
        docRef.getDocument(completion: { (document, error) in
            if error != nil {
                self.delegate?.failure(error: error)
                return
            }
            
            guard let response = document?.data() else { return }
            self.firebaseDecodable(response: response, collection: collection)
            self.delegate?.success(collection)
        })
    }
    
    func getDocumentRefWithId(collection: String, id: String) -> DocumentReference? {
        let subRef = firebaseDB.collection(collection).document(id)

        return subRef
    }
    
    func getSubDocumentRefWithId(collection: String, id: String, subCollection: String, subDocument: String) -> DocumentReference {
        let subRef = firebaseDB
            .collection(collection).document(id)
            .collection(subCollection).document(subDocument)

        return subRef
    }
    
    func getReference() -> StorageReference {
        let storageRef = storage.reference()
        let avatarRef = storageRef.child("avatar")
        return avatarRef
    }
    
    func uploadAvatar(localFile: URL) {
        guard let user = self.user else { return }
        let fileExtension = localFile.pathExtension
        let fileName = "\(user.uid).\(fileExtension)"
        let avatarRef = self.getReference()

        avatarRef.child(fileName).putFile(from: localFile, metadata: nil) {
            metadata, error in
            
            guard let metadata = metadata else {
                print("Error metadata")
                return
            }

            let size = metadata.size
            print(size)
            avatarRef.child("\(user.uid).jpeg").downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                
                if let error = error {
                    print(error)
                }
                
                self.addDocumentWithId(collection: "users", id: user.uid, data: ["avatar": downloadURL.absoluteString])
            }
        }
    }

    func getUser() -> User? {
        let user = Auth.auth().currentUser
        guard let _user = user else {
            return nil
        }

        return _user
    }
    
    func createUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let _self = self else { return }

            if error != nil {
                _self.delegate?.failure(error: error)
                return
            }
            
            if let userData = authResult?.user {
                _self.createUserData(userData: userData, name: name, email: email)
            }
            
            _self.login(email: email, password: password)
        }
    }
    
    private func createUserData(userData: User, name: String, email: String) {
        let username = email.components(separatedBy: "@")
        self.addDocumentWithId(collection: "users_movies", id: userData.uid, data: [:])
        self.addDocumentWithId(collection: "friends", id: userData.uid, data: [
            "followers": [],
            "followings": []
        ])
        self.addDocumentWithId(collection: "users", id: userData.uid, data: [
            "name": name,
            "email": email,
            "username": "@\(username[0])-\(userData.uid)",
            "friends": [self.getDocumentRefWithId(collection: "friends", id: userData.uid)],
            "myMovies": [self.getDocumentRefWithId(collection: "users_movies", id: userData.uid)]
        ])
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let _self = self else { return }
            
            if error != nil {
                _self.delegate?.failure(error: error)
                return
            }

            guard let _auth = authResult else { return }
            _self.user = _auth.user
            _self.delegate?.success("login")
        }
    }
    
    func facebookLogin(token: AccessToken) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let _self = self else { return }
            _self.socialLogin(authResult: authResult, error: error)
        }
    }
    
    func googleLogin(user: GIDGoogleUser?) {
        guard let authentication = user?.authentication,
              let idToken = authentication.idToken
        else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )
        
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let _self = self else { return }
            _self.socialLogin(authResult: authResult, error: error)
        }
    }
    
    func appleLogin(idTokenString: String, nonce: String) {
      let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                idToken: idTokenString,
                                                rawNonce: nonce)

      Auth.auth().signIn(with: credential) { [weak self] authResult, error in
          guard let _self = self else { return }
          _self.socialLogin(authResult: authResult, error: error)
      }
    }
    
    private func socialLogin(authResult: AuthDataResult?, error: Error?) {
        if error != nil {
            self.delegate?.failure(error: error)
            return
        }
        
        guard let _auth = authResult else { return }
        self.user = _auth.user
        
        guard let _additionalInfo = authResult?.additionalUserInfo else { return }
        guard let _profile = _additionalInfo.profile else { return }
        
        let _email = _profile.filter { $0.key == "email" }
        guard let email = _email.values.first as? String else { return }
        guard let name = _auth.user.displayName else { return }
        self.createUserData(userData: _auth.user, name: name, email: email)

        if let avatar = _auth.user.photoURL {
            self.addDocumentWithId(collection: "users", id: _auth.user.uid, data: ["avatar": avatar.absoluteString])
        }
       
        self.delegate?.success("login")
    }
    
    func getClientID() -> String? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        return clientID
    }
    
    func logout() {
        do {
            let manager = LoginManager()
            manager.logOut()
            try Auth.auth().signOut()
        } catch {
            print("Erro ao desconectar")
        }
    }

    func recoveryPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                self.delegateRecovery?.errorRecovery(error: error)
                return
            }
            
            self.delegateRecovery?.recovery()
        }
    }
    
    private func updateName(name: String) {
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        request?.displayName = name
        request?.commitChanges { error in
            if error != nil {
                self.delegate?.failure(error: error)
                return
            }
            
            self.delegate?.success("users")
        }
    }
    
    private func updateEmail(email: String) {
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if error != nil {
                self.delegate?.failure(error: error)
                return
            }
            
            self.delegate?.success("users")
        }
    }
    
    private func updatePass(password: String, oldPassword: String = "") {
        guard let email = self.user?.email else { return }
        Auth.auth().signIn(withEmail: email, password: oldPassword) { authResult, error in

            if error != nil {
                self.delegate?.failure(error: error)
                return
            }

            guard let user = authResult?.user else { return }
            user.updatePassword(to: password) { error in
                if error != nil {
                    self.delegate?.failure(error: error)
                    return
                }
                
                self.delegate?.success("users")
            }
        }
    }
    
    private func sendVerificationEmail() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if error != nil {
                self.delegate?.failure(error: error)
            }
        }
    }
}

extension DocumentReference: DocumentReferenceType {}
extension GeoPoint: GeoPointType {}
extension FieldValue: FieldValueType {}
extension Timestamp: TimestampType {}
