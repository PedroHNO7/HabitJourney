import SwiftUI

struct SignUpView: View {
    
    let db = DBManager()
    
    @State var userName: String
    @State var userEmail: String
    @State var userPassword: String
    
    @Environment(\.dismiss) var dismiss
    
    @State var show: Bool = false
    
    @State var userID: String = ""
    
    @State var nameField: FieldModel = FieldModel(value: "", fieldType: .name)
    @State var emailField: FieldModel = FieldModel(value: "", fieldType: .email)
    @State var passwordField: FieldModel = FieldModel(value: "", fieldType: .password)
    
    var body: some View {
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
            
           
            .padding()
            
            inputSection
        }

    }
    
    private var inputSection: some View {
        
        VStack {     
            
            Text("Registrar")
                .font(.title)
                .bold()
                .foregroundColor(Color("AppColor/TaskMain"))
                .accessibility(label: Text("Tela de Registro"))
            
            CustomTextField(fieldModel: $nameField)
                .foregroundColor(Color("AppColor/TaskMain"))
                .onSubmit {
                    nameField.onSubmitError()
                }
                .accessibility(label: Text("Digite o seu nome"))
            
            CustomTextField(fieldModel: $emailField).foregroundColor(Color("AppColor/TaskMain"))
                .onSubmit {
                    emailField.onSubmitError()
                }.autocapitalization(.none)
                .accessibility(label: Text("Digite o seu email"))
            
            CustomTextField(fieldModel: $passwordField).foregroundColor(Color("AppColor/TaskMain"))
                .onSubmit {
                    emailField.onSubmitError()
                }.autocapitalization(.none)
                .accessibility(label: Text("Digite a sua senha"))
            
            Button("Cadastrar"){
                
                let name = nameField.onValidate()
                
                let email = emailField.onValidate()
                
                let password = passwordField.onValidate()
                
                if name && email && password {
                    let user = User(name: nameField.value, email: emailField.value, password: passwordField.value)
                    
                    if (db.insertUser(user: user)){
                        show = true
                        
                        
                        dismiss()
                    }
                } else {
                    return
                }
                
            }.foregroundColor(Color("AppColor/TaskMain"))
                .frame(width: 320, height: 48)
                .background(Color("AppColor/MarginSecondary"))
                .cornerRadius(8)
                .accessibility(label: Text("Cadastar"))
                .accessibility(hint: Text("Pressione para salvar as informações de cadastro"))
        }
        .alert(isPresented: $show) {
            Alert(
                title: Text("Sucesso"),
                message: Text("\(userName) inserido com sucesso"),
                dismissButton: .default(Text("Ok"))
            )
        }
        
    }
}

#Preview {
    SignUpView(userName: "", userEmail: "", userPassword: "")
}

