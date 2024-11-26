import SwiftUI

struct AddScreen: View {
    @EnvironmentObject var habitStore: HabitStore
    @Binding var userID: String
    @State var habitField: FieldModel
    @State private var alertMessage: String = ""
    @State private var showAlert = false
    @State private var checkedDays: [Bool] = Array(repeating: false, count: 7)

    var selectedDate: Date
    
    var body: some View {
        VStack {
            VStack {
                Text(dateFormatter.string(from: selectedDate))
                    .font(.headline)
                    .bold()
                    .padding(.bottom, 12)
                Text("Criar um novo hábito")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .bold()
            } // Cabeçalho
            .padding(.bottom, 12)

            // Texto de legenda mais o CustomTextField
            Text("Qual é o hábito que deve ser registrado?")
                .accessibility(label: Text("Qual é o hábito que deve ser registrado?"))
            CustomTextField(fieldModel: $habitField)
                .foregroundColor(Color("AppColor/TaskMain"))
                .autocapitalization(.none)
                .onSubmit {
                    habitField.onSubmitError()
                }.accessibility(hint: Text("Digite sua nova hábito"))

            // Título para seleção de recorrência
            Text("Qual a recorrência?")
                .font(.title3)
                .bold()
                .padding(.top, 8)
                .accessibility(label: Text("Qual a recorrência?"))
            

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
            }

            Button(action: {
                self.submitData()
            }) {
                Text("Adicionar")
                    .foregroundColor(Color("AppColor/TaskMain"))
                        .frame(width: 320, height: 48)
                        .background(Color("AppColor/MarginSecondary"))
                        .cornerRadius(8)
                        .accessibility(label: Text("Adicionar"))
                        .accessibility(hint: Text("Pressione para adicionar hábito"))
            }
            .padding(.top, 20)
        }
        .padding(.horizontal, 20)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(""),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    habitField.value = "" // Reseta o campo do hábito
                    checkedDays = Array(repeating: false, count: 7) // Reseta os checkboxes
                }
            )
        }
    }

    // Função de adição do hábito (DB)
    func submitData() {
        guard !habitField.value.isEmpty else {
            alertMessage = "Por favor, insira um hábito válido."
            showAlert = true
            return
        }

        // Verifica se ao menos um checkbox está marcado
        guard checkedDays.contains(true) else {
            alertMessage = "Por favor, selecione ao menos um dia da semana para o hábito."
            showAlert = true
            return
        }

        // Converte o array checkedDays em uma string de recorrência
        let recurrenceString = checkedDays.map { $0 ? "1" : "0" }.joined()
        
        // Gera os dias da semana selecionados em formato abreviado
        let selectedDays = checkedDays.enumerated()
            .filter { $0.element } // Apenas os dias marcados
            .map { weekdayAbbreviation(for: $0.offset) }
            .joined(separator: ", ")

        // Cria um novo hábito
        let newHabit = Habit(userID: userID, title: habitField.value, recurrence: recurrenceString)
        
        if habitStore.dbManager.insertHabit(habit: newHabit) {
            alertMessage = "Hábito '\(habitField.value)' com recorrência \(selectedDays) foi criado com sucesso!"
            showAlert = true
            
            // Redireciona para HomeScreen após 1 segundo
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                habitStore.loadHabits(for: userID)
            }
        } else {
            alertMessage = "Falha ao adicionar o hábito. Tente novamente."
            showAlert = true
        }
    }

    // Função para retornar abreviação dos dias da semana
    func weekdayAbbreviation(for index: Int) -> String {
        switch index {
        case 0: return "Dom"
        case 1: return "Seg"
        case 2: return "Ter"
        case 3: return "Qua"
        case 4: return "Qui"
        case 5: return "Sex"
        case 6: return "Sáb"
        default: return "ERROR"
        }}


    // Retorna os dias da semana com base no índice
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
