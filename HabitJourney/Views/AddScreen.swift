// Documento responsável pela tela de adição de hábitos

import SwiftUI

struct AddScreen: View {
    
    @State private var inputString: String = ""
    @State private var isChecked: Bool = false // State variable for checkbox
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack {
                    Text("12/06").font(.largeTitle).bold()
                    Text("Criar um novo hábito").font(.title).multilineTextAlignment(.center).padding(.top, 20).bold()
                } // Cabeçalho - DIA E TITULO DA PAGINA
                
                Text("Qual é o hábito deve ser registrado?").font(.subheadline).padding(.top, 12)
                TextField("Exercitar, ler livros, etc...", text: $inputString).contentMargins(.top, 12)
                    .frame(width: 350, height: 50)
                    .textFieldStyle(.roundedBorder)
                    .border(Color(("AppColor/MarginSecondary")), width: 5)
                    .multilineTextAlignment(.center)
                
                Text("Qual a recorrência?").padding(.top, 40)
                
                VStack {
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Domingo").multilineTextAlignment(.leading)
                    } // HStack - DIA 0
                    
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Segunda-Feira").multilineTextAlignment(.center)
                    } // HStack - DIA 1
                    
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Terça-Feira").multilineTextAlignment(.center)
                    } // HStack - DIA 2
                    
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Quarta-Feira").multilineTextAlignment(.center)
                    } // HStack - DIA 3
                    
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Quinta-Feira").multilineTextAlignment(.center)
                    } // HStack - DIA 4
                    
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Sexta-Feira").multilineTextAlignment(.center)
                    } // HStack - DIA 5
                    
                    HStack {
                        CheckBoxButtonWrapper(isChecked: $isChecked)
                            .frame(width: 45, height: 45)
                        Text("Sabádo").multilineTextAlignment(.center)
                    } // HStack - DIA 6
                    
                } // VStack - Dias da Semana
                
                VStack {
                    
                } // VStack - Botão de Conclído
                
                HStack {
                    Image("HabitJourney");
                    Text("HabitJourney")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .foregroundColor(Color("AppColor/TaskMain"));
                    
                } // HStack - Rodapé
                
            } // VStack MAIN
            
            
        }
    }
}


#Preview {
    AddScreen()
}
