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
                    
                    VStack {
                        
                        CustomTextField(fieldModel: $emailField).foregroundColor(.white)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .onSubmit {
                                emailField.onSubmitError()
                            }
                        
                        CustomTextField(fieldModel: $passwordField).foregroundColor(.white)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .onSubmit {
                                passwordField.onSubmitError()
                            }
                        
                        Button("Entrar"){
                            var email = emailField.onValidate()
                            
                            var pass = passwordField.onValidate()
                            
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
                            }//if email
                            
                        }.buttonStyle(.borderedProminent)
                        
                        if message != "" {
                            Text(message)
                        }
                        
                        Button("Não tem cadastro? Se Cadastre!"){
                            show = true
                        }
                        
                    }//VStack
                    .padding(.top, 300)
                    
                    Spacer()
                    
                    
                    .sheet(isPresented: $show){
                        //chamar a tela de cadastro
                        SignUpView(userName: "", userEmail: "", userPassword: "")
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView(userEmail: "", userPassword: "", emailField: FieldModel(value: "", fieldType: .email), passwordField: FieldModel(value: "", fieldType: .password))
}
