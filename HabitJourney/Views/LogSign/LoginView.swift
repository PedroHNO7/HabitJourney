import SwiftUI

struct LoginView: View {
    
    let db = DBManager()
    
    @State var userEmail: String
    @State var userPassword: String
    @State var message: String = ""
    @State var show = false
    
    @State var userID: String = ""
    
    @State var emailField: FieldModel
    @State var passwordField: FieldModel
    
    @State var isActive: Bool = false;
    
    var body: some View {
        
        ZStack {
            if self.isActive {
                HomeScreen(userID: $userID)
                    .environmentObject(HabitStore()).environmentObject(ProgressStore())
            } else {
                
                ZStack{
                    Image("login_background").resizable().ignoresSafeArea()
                    
                    inputSection
                    
                    Spacer()
                    
                    .sheet(isPresented: $show){
                        SignUpView(userName: "", userEmail: "", userPassword: "")
                    }
                }
                .padding()
            }
        }.ignoresSafeArea()
    }
    
    private var inputSection: some View {
        VStack {
            
            CustomTextField(fieldModel: $emailField).foregroundColor(.white)
                .autocapitalization(.none)
                .onSubmit {
                    emailField.onSubmitError()
                }
            
            CustomTextField(fieldModel: $passwordField).foregroundColor(.white)
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
                            
                            print(db.getAllHabits())
                            
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
            }.foregroundColor(Color("AppColor/MarginSecondary")).padding()
            
        }
        .padding(.top, 300)
    }
}

#Preview {
    LoginView(userEmail: "", userPassword: "", emailField: FieldModel(value: "", fieldType: .email), passwordField: FieldModel(value: "", fieldType: .password))
}
