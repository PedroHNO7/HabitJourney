import SwiftUI

struct DayScreen: View {
    @Binding var userID: String
    
    let db = DBManager()
    
    @EnvironmentObject var habitStore: HabitStore
    @EnvironmentObject var progressStore: ProgressStore
    @State private var checkedHabits: Set<String> = []
    var selectedDate: Date

    var body: some View {
        VStack {
            headerSection
            progressBarSection
            habitListSection
            footerSection
        }
        .onAppear {
            habitStore.loadHabits(for: userID)
            loadCheckedHabits()
        }
    }

    private var headerSection: some View {
        VStack {
            HStack {
                Text(dayFormatter.string(from: selectedDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
            }
            .padding(.vertical, 30)

            HStack {
                Text(dateFormatter.string(from: selectedDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)

                Spacer()

                NavigationLink(destination: AddScreen(userID: $userID, habitField: FieldModel(value: "", fieldType: .habit), selectedDate: selectedDate)) {
                    Image("Button")
                        .accessibility(hint: Text("Pressione para adicionar tarefas"))
                }
            }
            .padding(.trailing, 20)
        }
    }

    private var progressBarSection: some View {
        HStack {
            ProgressBar(width: 300, height: 20, percent: progressStore.percent)
                .animation(.spring())
                .padding(.vertical, 12)
                .onAppear {
                    updateProgress()
                }
                .onChange(of: percent) { newValue in
                    updateProgress()
                }
        }
    }
    
    private func updateProgress() {
        progressStore.percent = totalHabitsCount > 0 ? CGFloat(completedHabitsCount) / CGFloat(totalHabitsCount) * 100 : 0
    }

    private var habitListSection: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(habitsForTheDay) { habit in
                    HStack {
                        CheckBoxButtonWrapper(isChecked: Binding(
                            get: { checkedHabits.contains(habit.id) },
                            set: { newValue in
                                if newValue {
                                    checkedHabits.insert(habit.id)
                                } else {
                                    checkedHabits.remove(habit.id)
                                }
                                saveCheckedHabits()
                                updateProgress()
                            }
                        ))
                        .frame(width: 45, height: 45)
                        
                        Text(habit.title)
                            .strikethrough(checkedHabits.contains(habit.id), color: .gray)
                            .opacity(checkedHabits.contains(habit.id) ? 0.5 : 1.0)
                            .multilineTextAlignment(.center)
                            .animation(.easeInOut, value: checkedHabits.contains(habit.id))
                    }
                }
            }
        }
    }
    
    private var footerSection: some View {
        HStack {
            Image("HabitJourney")
            Text("HabitJourney")
                .font(.title)
                .bold()
                .padding(.leading, 20)
                .foregroundColor(Color("AppColor/TaskMain"))
        }
        .padding(.top, 80)
    }
    
    var habitsForTheDay: [Habit] {
        let weekday = Calendar.current.component(.weekday, from: selectedDate) - 1  // O índice do dia da semana (0 a 6)
        
        return habitStore.habits.filter { habit in
            // Verifica se a string de recorrência tem comprimento suficiente e se o dia correspondente está ativo
            if habit.recurrence.count > weekday {
                let isActiveForToday = habit.recurrence[habit.recurrence.index(habit.recurrence.startIndex, offsetBy: weekday)] == "1"
                return isActiveForToday
            }
            return false
        }
    }

    var completedHabitsCount: Int {
        checkedHabits.intersection(Set(habitsForTheDay.map { $0.id })).count
    }

    var totalHabitsCount: Int {
        habitsForTheDay.count
    }

    var percent: CGFloat {
        totalHabitsCount > 0 ? CGFloat(completedHabitsCount) / CGFloat(totalHabitsCount) * 100 : 0
    }

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()

    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
    
    func saveCheckedHabits() {
        let key = dateFormatter.string(from: selectedDate)
        let checkedHabitsData = try? JSONEncoder().encode(Array(checkedHabits))
        UserDefaults.standard.set(checkedHabitsData, forKey: key)
    }
    
    func loadCheckedHabits() {
        let key = dateFormatter.string(from: selectedDate)
        if let checkedHabitsData = UserDefaults.standard.data(forKey: key),
           let loadedCheckedHabits = try? JSONDecoder().decode([String].self, from: checkedHabitsData) {
            self.checkedHabits = Set(loadedCheckedHabits)
        }
    }

}
