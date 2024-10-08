import SwiftUI

struct LoginView: View {
    
    let db = DBManager()
    
    @State var userEmail: String
    @State var userPassword: String
    @State var message: String = ""
    @State var show = false
    
    @State var emailField: FieldModel
    @State var passwordField: FieldModel
    
    @State var isActive: Bool = false;
    
    var body: some View {
        
        ZStack {
            if self.isActive {
                HomeScreen()
                    .environmentObject(HabitStore()).environmentObject(ProgressStore())
            } else {
                
                VStack{
                    VStack {
                        
                        Image(systemName: "person")
                        
                        Text("Esse é um aplicativo com SQLite")
                            .padding(.bottom)
                        
                        CustomTextField(fieldModel: $emailField)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .onSubmit {
                                emailField.onSubmitError()
                            }
                        
                        CustomTextField(fieldModel: $passwordField)
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
                    }//VStack
                    .padding(.top, 300)
                    
                    Spacer()
                    
                    Button("Não tem cadastro? Se Cadastre!"){
                        show = true
                    }
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
