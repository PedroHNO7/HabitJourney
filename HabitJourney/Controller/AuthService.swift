import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthService: NSObject, ObservableObject {
    
    @Published var isUserLogged: Bool = false
    
    static let shared = AuthService()
    private override init() {} //padrão singleton
    
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
                    self.isUserLogged = true
                    return
                }
            }
        }
        return true
    }
    
    // Faz o logout do Google Sign-In se estiver usando Single-sign-on
    func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            print("Logout realizado com Google e Firebase")
            self.isUserLogged = false
        } catch let error {
            print("Erro ao fazer logout do Firebase: \(error.localizedDescription)")
        }
    }
    
    // Faz o logout default
    func defaultSignOut() {
        self.isUserLogged = false
    }
    
    func isUserLoggedIn() -> Bool {
         if let currentUser = Auth.auth().currentUser {
             // O usuário está logado
             print("Usuário já está logado: \(currentUser.email ?? "sem email")")
             self.isUserLogged = true
             return true
         } else {
             // Nenhum usuário logado
             print("Nenhum usuário está logado")
             self.isUserLogged = false
             return false
         }
     }
    
    
}
