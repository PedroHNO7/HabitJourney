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
    @ObservedObject var authService: AuthService = AuthService()
    
    var body: some View {
        
        ZStack {
            if self.isActive {
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
                            dismiss()
                        }
                    } label: {
                        HStack{
                            Text("Criar com Google")
                        }
                    }
                    
                    inputSection
                    
                    .sheet(isPresented: $show){
                        SignUpView(userName: "", userEmail: "", userPassword: "")
                    }
                }.onAppear {
                    isUserLoggedIn = authService.isUserLoggedIn()
                    
                    if isUserLoggedIn {
                        self.isActive = true
                    }
                }
                
            }
        }.fullScreenCover(isPresented: $showSignUpView) {
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
                            
                            isActive = true;
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
