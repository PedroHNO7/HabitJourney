import SwiftUI

struct LoginView: View {
    
    let db = DBManager()
    
    @State private var showSignUpView = false
    
    @State var userEmail: String
    @State var userPassword: String
    @State var message: String = ""
    @State var show = false
    
    @Environment(\.dismiss) var dismiss
    
    @State var userID: String = ""
    
    @State var emailField: FieldModel
    @State var passwordField: FieldModel
    
    @State var isActive: Bool = false;
    
    @State private var isUserLoggedIn = false
    
    //Aqui estou usando o padrão singleton, então tem somente uma instância
    @StateObject var authService: AuthService = AuthService.shared
    
    var body: some View {
        
            ZStack {
                if authService.isUserLogged || self.isActive == true {

                    HomeScreen(userID: $userID)
                        .environmentObject(HabitStore()).environmentObject(ProgressStore())
                } else {
                    
                    VStack {
                        
                        HStack {
                            Image("HabitJourney")
                                .padding(.top, 64)
                            
                            Text("HabitJourney")
                                .padding(.top, 64)
                                .font(.title)
                                .bold()
                                .foregroundColor(Color("AppColor/TaskMain"))
                        }
                        .padding(.bottom, 30)
                        
                        Button{
                            print("Cliquei para o Login com Google")
                            if authService.googleSignIn(){
                                
                                if authService.isUserLoggedIn() {
                                    isActive = true
                                }
                                
                                dismiss()
                            }
                        } label: {
                            HStack{
                                
                                Image("Google")
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                Text("Entrar com Google")
                            }
                        }.foregroundColor(Color("AppColor/TaskMain"))
                            .frame(width: 240, height: 48)
                            .background(Color("AppColor/MarginSecondary"))
                            .cornerRadius(8)
                        
                        
                        inputSection
                            .sheet(isPresented: $show){
                                SignUpView(userName: "", userEmail: "", userPassword: "")
                            }
                    }//VStack
                    .onAppear {
                        isUserLoggedIn = authService.isUserLoggedIn()
                        
                        if UserDefaults.standard.bool(forKey: "isLoggedWithForm") || isUserLoggedIn {
                            
                            self.isActive = true
                            
                        }
                    }
                    
                   
                } //else
            }//ZStack
            .fullScreenCover(isPresented: $showSignUpView) {
                SignUpView(userName: "", userEmail: "", userPassword: "")
                
                
            }.ignoresSafeArea()

    }
    
    private var inputSection: some View {
        VStack {
            
            Text("Entrar")
                .font(.title)
                .bold()
                .foregroundColor(Color("AppColor/TaskMain"))
            
            CustomTextField(fieldModel: $emailField).foregroundColor(Color("AppColor/TaskMain"))
                .autocapitalization(.none)
                .onSubmit {
                    emailField.onSubmitError()
                }
            
            CustomTextField(fieldModel: $passwordField).foregroundColor(Color("AppColor/TaskMain"))
                .autocapitalization(.none)
                .onSubmit {
                    passwordField.onSubmitError()
                }
            
            Button("Entrar"){
                let email = emailField.onValidate()
                
                let pass = passwordField.onValidate()
                
                if  email && pass{
                    
                    let users = db.logUser(email: emailField.value)
                    

                        message = "Não te encontrei :("

                    
                    for user in users{
                        userPassword = passwordField.value
                        
                        if user.password == userPassword{
                            
                            userID = user.id
                            
                            isActive = true
                            
                            UserDefaults.standard.set(true, forKey: "isLoggedWithForm")
                            UserDefaults.standard.set(userID, forKey: "userID")
                            
                            
                            
                        } else {
                            message = "E-mail ou senha incorretos"
                        }
                    }
                }
                
            }.foregroundColor(Color("AppColor/TaskMain"))
                .frame(width: 320, height: 48)
                .background(Color("AppColor/MarginSecondary"))
                .cornerRadius(8)
            
            if message != "" {
                Text(message)
            }
            
            Button("Não tem cadastro? Se Cadastre!"){
                show = true
            }.foregroundColor(Color("AppColor/TaskMain")).padding()
            
        }
        .padding()
    }
}

#Preview {
    LoginView(userEmail: "", userPassword: "", emailField: FieldModel(value: "", fieldType: .email), passwordField: FieldModel(value: "", fieldType: .password))
}
