//
//  AuthService.swift
//  HabitJourney
//
//  Created by coltec on 05/11/24.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthService: NSObject, ObservableObject {
  
    func googleSignIn() -> Bool {
        // Verifica se o clientID do Firebase foi configurado corretamente
        guard let clientID = FirebaseApp.app()?.options.clientID else { return false }

        // Cria o objeto de configuração do Google Sign In
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Acessa o UIHostingController atual como o controlador de visualização raiz
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false}
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return false}

        // Inicia o fluxo de login
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Erro ao fazer Google Sign-In, \(error.localizedDescription)")
                return
            }

            // Verifica se o usuário e o token de id foram retornados corretamente
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Erro durante a autenticação do Google Sign-In.")
                return
            }

            // Cria as credenciais do Firebase com o ID token e o access token do usuário
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            // Autentica com o Firebase usando as credenciais do Google
            Auth.auth().signIn(with: credential) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Login realizado com Google")
                    return
                }
            }
        }
        return true
    }

    // Faz o logout do Google Sign-In se estiver usando Single-sign-on
    func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
        print("Logout realizado com Google")
    }
    
    func isUserLoggedIn() -> Bool {
         if let currentUser = Auth.auth().currentUser {
             // O usuário está logado
             print("Usuário já está logado: \(currentUser.email ?? "sem email")")
             return true
         } else {
             // Nenhum usuário logado
             print("Nenhum usuário está logado")
             return false
         }
     }
    
    func regularCreateAccount(email: String, password: String){
        //TODO
    }
    
    func regularSignOut(){
        //TODO
    }
}
