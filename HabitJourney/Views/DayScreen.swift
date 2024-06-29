import SwiftUI

struct DayScreen: View {
    // Adiciona uma variável para armazenar os habitos
    @EnvironmentObject var habitStore: HabitStore

    // Adiciona uma variável para armazenar a barra de progresso
    @EnvironmentObject var progressStore: ProgressStore

    // Array com os ID's e valores do hábito
    @State private var checkedHabits: [UUID: Bool] = [:]

    // Variável do dia selecionado
    var selectedDate: Date

    // Define se o habito é pro dia selecionado
    var habitsForTheDay: [Habit] {
        let weekday = Calendar.current.component(.weekday, from: selectedDate) - 1
        return habitStore.habits.filter { $0.recurrence.contains(weekday) }
    }

    // Ve se o hábito foi completado (checkedBox)
    var completedHabitsCount: Int {
        habitsForTheDay.filter { checkedHabits[$0.id] ?? false }.count
    }

    // Pega a contagem de Habitos
    var totalHabitsCount: Int {
        habitsForTheDay.count
    }

    // Porcentagem da barra de progresso para animação
    var percent: CGFloat {
        totalHabitsCount > 0 ? CGFloat(completedHabitsCount) / CGFloat(totalHabitsCount) * 100 : 0
    }

    var body: some View {
        VStack {
            HStack {
                // Adiciona o dia atual em cima
                Text(dayFormatter.string(from: selectedDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                
            }.padding(.vertical, 30);

            HStack {
                Text(dateFormatter.string(from: selectedDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)

                Spacer()

                // Passa o dia selecionado para o AddScreen
                NavigationLink(destination: AddScreen(selectedDate: selectedDate)) {
                    Image("Button")
                };
            } // HStack - DIA E BOTÃO
            .padding(.trailing, 20);

            // Barra de progresso
            HStack {
                ProgressBar(width: 300, height: 20, percent: percent)
                    .animation(.spring())
                    .padding(.vertical, 12)
                    /*
                    .onAppear {
                        self.progressStore.percent = self.percent
                    }
                    .onChange(of: percent) { newValue in self.progressStore.percent = newValue
                    }       
                */
            };

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(habitsForTheDay) { habit in
                        HStack {
                            CheckBoxButtonWrapper(isChecked: Binding<Bool>(
                                get: { self.checkedHabits[habit.id] ?? false },
                                set: { self.checkedHabits[habit.id] = $0 
                                    
                                    /*
                                        self.checkedHabits[habit.id] =  $0
                                        saveCheckedHabits()
                                        self.progressStore.percent = self.percent    
                                    */
                                }
                            ))
                            .frame(width: 45, height: 45)
                            Text(habit.name)
                                .multilineTextAlignment(.center)
                        }
                    } // ForEACH para criação dos CheckBox e Hábitos
                }
            }; // ScrollView dos botões

            HStack {
                Image("HabitJourney")
                Text("HabitJourney")
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
                    .foregroundColor(Color("AppColor/TaskMain"))
            } // Rodapé com Logo da Aplicação
            .padding(.top, 80)
        } 
        /*
        .onAppear {
            loadCheckedHabits()
        */
    };

    // Formatando o dia para DD e MM
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }();

    // Formatando o dia da semana
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }();

    // Salvando os hábitos que foram checados
    /*
    func saveCheckedHabits() {
        let checkedHabitData = try? JSONEncoder().encode(checkedHabits)
        UserDefaults.standard.set(checkedHabitsData, forKey: "checkedHabits"
    };
    */

    // Carregando os hábitos que foram checados
    /*
    func loadCheckedHabits() {
        if let checkedHabitsData = UserDefaults.standard.data(forKey: "checkedHabits"),
            let loadedCheckedHabits = try? JSONDecoder().decode([UUID: Bool].self, from: checkedHabitsData) {
            self.checkedHabits = loadedCheckedHabits
        };
    };
    */
};

struct DayScreen_Previews: PreviewProvider {
    static var previews: some View {
        DayScreen(selectedDate: Date()).environmentObject(HabitStore()) // .environmentObject(ProgressStore())
    }
}
