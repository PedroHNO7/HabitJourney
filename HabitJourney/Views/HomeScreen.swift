// Documento responsável por redirecionar o usuário para as demais telas

import SwiftUI

struct HomeScreen: View {
    // Estado para armazenar a data atual
    @State private var currentDate = Date();
    
    // // Adiciona uma variável para armazenar os hábitos
    @EnvironmentObject var habitStore: HabitStore;

    // Adiciona uma variável para armazenar a barra de progresso
    @EnvironmentObject var progressStore: ProgressStore;
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("HabitJourney")
                    Text("HabitJourney")
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                        .foregroundColor(Color("AppColor/TaskMain"))
                } // HStack - CABEÇALHO
                .padding(.bottom, 30);
                
                HStack {
                    Text(dateFormatter.string(from: currentDate))
                        .font(.title)
                        .bold()
                        .padding(.leading, 20)
                    
                    Spacer()
                } // HStack - Data atual
                .padding(.trailing, 20);
                
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(30), spacing: 20), count: 7)) {
                    ForEach(0..<7) { index in
                            Text(weekdayInitial(for: index))
                                .font(.system(size: 20)).bold()
                                .padding(8)
                    }; // ForEach - Para criação dos dias da semana

                    /*
                    ForEach(0..<28) { index in
                            let date = Calendar.current.date(byAdding: .day, value: index - currentWeekdayOffset, to: currentDate)!
                        
                            NavigationLink(destination: DayScreen(selectedDate: date).environmentObject(habitStore)) {
                                Text(dayFormatter.string(from: date)).bold()
                                    .frame(width: 45, height: 45)
                                    .background(progressColor(for: progressStore.percent))
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                            }; // NavigationLink com os botões
                    } */ // ForEach - Para criação dos botões
                }; // LazyVGrid -  Grade de botões representando os dias da semana
            };
        }
    };
    
    // Calcula o deslocamento para o dia da semana atual
    var currentWeekdayOffset: Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: currentDate) - 1 // Sunday = 1, Saturday = 7
        return weekday
    };
    
    // Formatador de data para exibição da data atual
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }();
    
    //Formatador de data para exibição do número do dia
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }();
    
    // Retorna as iniciais dos dias da semana com base no índice
    func weekdayInitial(for index: Int) -> String {
        switch index {
        case 0: return "D"
        case 1: return "S"
        case 2: return "T"
        case 3: return "Q"
        case 4: return "Q"
        case 5: return "S"
        case 6: return "S"
        default: return "ERROR"
        };
    };

    // Retorna a cor de acordo com a barra de progresso
    /*
    func progressColor(for percent: CGFloat) -> Color {
        switch percent {
        case 0..<20: return Color("AppColor/TaskMain20")
        case 20..<40: return Color("AppColor/TaskMain35")
        case 40..<60: return Color("AppColor/TaskMain55")
        case 60..<80: return Color("AppColor/TaskMain75")
        default: return Color("AppColor/TaskMain")
        };
    };
    */
};

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(HabitStore())
        // .environmentObject(ProgressStore());
    };
};
