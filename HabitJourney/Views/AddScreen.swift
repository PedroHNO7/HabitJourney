// Documento responsável pela criação de hábito

import SwiftUI

struct AddScreen: View {
    @EnvironmentObject var habitStore: HabitStore
    
    @State private var inputString: String = ""
    @State private var checkedDays: [Bool] = Array(repeating: false, count: 7)

    var selectedDate: Date

    var body: some View {
        VStack {
            VStack {
                Text(dateFormatter.string(from: selectedDate))
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 12)
                Text("Criar um novo hábito")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .bold()
            } // VStack - Cabeçalho com a data selecionada e título da tela
            .padding(.bottom, 12)

            // Texto de legenda mais o TextField
            Text("Qual é o hábito que deve ser registrado?")
            TextField("Exercitar, ler livros, etc...", text: $inputString)
                .frame(width: 350, height: 50)
                .textFieldStyle(PlainTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("AppColor/MarginSecondary"), lineWidth: 5)
                )
                .accessibilityLabel("Insira o hábito a ser registrado")
                .multilineTextAlignment(.center)
                .padding(.vertical, 20)

            // Título para seleção de recorrência
            Text("Qual a recorrência?")
                .font(.title3)
                .bold()
                .padding(.top, 20)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<7, id: \.self) { index in
                        HStack {
                            CheckBoxButtonWrapper(isChecked: self.$checkedDays[index])
                                .frame(width: 45, height: 45)
                            Text(self.weekday(for: index))
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            } // ScrollView para exibir os dias da semana com checkbox

            Button(action: {
                self.submitData()
            }) {
                Text("Submit")
                    .foregroundColor(Color("AppColor/TaskMain"))
                    .padding()
                    .background(Color("AppColor/MarginSecondary"))
                    .cornerRadius(8)
            } // Botão para concluir a adição
            .padding(.top, 20)
        }
        .padding(.horizontal, 20)
    }

    // Função de adição do hábito (DB)
     func submitData() {
     guard !inputString.isEmpty else {
         
         return
     }
         
    
     let recurrence = [false, false, false, false, true, true, true]
         let newHabit = Habit(id: "someHabit", userID: "ss", title: inputString, recurrence: recurrence)
     if habitStore.dbManager.insertHabit(habit: newHabit) {
         
         inputString = ""
         checkedDays = Array(repeating: false, count: 7)
     } else {
         
     }
 }


    // Retorna os dias da semana com base no indice
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
    
    // Formatador de data para exibição da data atual
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
}

struct AddScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddScreen(selectedDate: Date()).environmentObject(HabitStore())
    }
}
