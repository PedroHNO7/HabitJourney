import SwiftUI

struct AddScreen: View {
    @State private var inputString: String = ""
    @State private var checkedDays: [Bool] = Array(repeating: false, count: 7)
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("12/06").font(.largeTitle).bold()
                        .padding(.bottom, 12)
                    Text("Criar um novo hábito").font(.title).multilineTextAlignment(.center).bold()
                }.padding(.bottom, 12)
                
                Text("Qual é o hábito que deve ser registrado?")
                TextField("Exercitar, ler livros, etc...", text: $inputString)
                    .frame(width: 350, height: 50)
                    .textFieldStyle(PlainTextFieldStyle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("AppColor/MarginSecondary"), lineWidth: 5)
                    )
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)

                Text("Qual a recorrência?").font(.title3).bold().padding(.top, 20)
                ScrollView {
                     VStack(alignment: .leading) {
                    ForEach(0..<7, id: \.self) { index in
                        HStack {
                            CheckBoxButtonWrapper(isChecked: self.$checkedDays[index])
                                .frame(width: 45, height: 45)
                            Text(self.weekday(for: index)).bold().multilineTextAlignment(.center)
                        }
                    }
                }
            }
                Button(action: {
                    self.submitData()
                }) {
                    Text("Submit")
                        .foregroundColor(Color("AppColor/TaskMain"))
                        .padding()
                        .background(Color("AppColor/MarginSecondary"))
                        .cornerRadius(8)
                }
                .padding(.top, 20)
                
            } // VStack MAIN
            .padding(.horizontal, 20)
        }
    }
    
    func submitData() {
        print("Input string: \(inputString)")
        print("Checked days: \(checkedDays)")
    }
    
    func weekday(for index: Int) -> String {
        switch index {
        case 0: return "Domingo"
        case 1: return "Segunda-Feira"
        case 2: return "Terça-Feira"
        case 3: return "Quarta-Feira"
        case 4: return "Quinta-Feira"
        case 5: return "Sexta-Feira"
        case 6: return "Sábado"
        default: return "ERROR"
        }
    }
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen()
    }
}
