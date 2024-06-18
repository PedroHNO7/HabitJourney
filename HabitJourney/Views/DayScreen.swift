// Documento responsável peloo dia específico

import SwiftUI
import UIKit

struct DayScreen: View {
    
    @State var percent: CGFloat = 0;
    @State private var checkedHabits = [false, false, false, false, false]
    
    
    var body: some View {
        NavigationView{
            
            
            
            VStack{
                
                
                HStack(){
                    Text("Sunday")
                        .font(.title)
                        .bold()
                        .padding(.leading,20)
                } // HStack dia da semana
                
                
                HStack {
                    // Dia atual - TO-DO: Mudar o dia com dia atual em si
                    Text("12/06")
                        .font(.title)
                        .padding(.leading, 20);
                    
                    
                    Spacer();
                    
                        // Botão personalizado
                        NavigationLink(){
                            AddScreen()
                        } label:{
                            Image("Button")
                        };
                    
                    
                } // HStack - DIA E BOTÃO
                .padding(.trailing, 20);
                
                
                HStack{
                    // Barra de progresso
                    ProgressBar(width: 300, height: 20, percent: percent)
                        .animation(.spring)
                        .padding(.vertical, 12)
                        
                    
                    

                }// HStack barra de progresso
                
                
                VStack(alignment: .leading) {
                                    ForEach(0..<checkedHabits.count, id: \.self) { index in
                                        HStack {
                                            CheckBoxButtonWrapper(isChecked: $checkedHabits[index])
                                                .frame(width: 45, height: 45)
                                                .onChange(of: checkedHabits[index]) {
                                                    updateProgress()
                                                        
                                                }
                                            
                                            Text("Hábito \(index + 1)")
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                
                // Cabeçalho com a imagem e o texto
                HStack {
                    Image("HabitJourney");
                    Text("HabitJourney")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .foregroundColor(Color("AppColor/TaskMain"));
                    
                }.padding(.top, 80); // HStack - CABEÇALHO
                
            } //VStack
            
        } //NavigationView
    
    }
    
    func updateProgress() {
        // 1. Calcula o número total de hábitos
        let totalHabits = CGFloat(checkedHabits.count)
            
        // 2. Conta quantos hábitos estão marcados como completos
        let checkedCount = CGFloat(checkedHabits.filter { $0 }.count)
        
        percent = (checkedCount / totalHabits) * 100
    }
}





#Preview {
    DayScreen()
}

