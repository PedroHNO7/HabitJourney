import SwiftUI

struct DayScreen: View {
    @EnvironmentObject var habitStore: HabitStore
    @EnvironmentObject var progressStore: ProgressStore
    @State private var checkedHabits: [UUID: Bool] = [:]
    var selectedDate: Date

    var habitsForTheDay: [Habit] {
        let weekday = Calendar.current.component(.weekday, from: selectedDate) - 1
        return habitStore.habits.filter { $0.recurrence.contains(weekday) }
    }

    var completedHabitsCount: Int {
        habitsForTheDay.filter { checkedHabits[$0.id] ?? false }.count
    }

    var totalHabitsCount: Int {
        habitsForTheDay.count
    }

    var percent: CGFloat {
        totalHabitsCount > 0 ? CGFloat(completedHabitsCount) / CGFloat(totalHabitsCount) * 100 : 0
    }

    var body: some View {
        VStack {
            HStack {
                Text(dayFormatter.string(from: selectedDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)
            }.padding(.vertical, 30)

            HStack {
                Text(dateFormatter.string(from: selectedDate))
                    .font(.title)
                    .bold()
                    .padding(.leading, 20)

                Spacer()

                NavigationLink(destination: AddScreen(selectedDate: selectedDate)) {
                    Image("Button")
                }
            }
            .padding(.trailing, 20)

            HStack {
                ProgressBar(width: 300, height: 20, percent: percent)
                    .animation(.spring())
                    .padding(.vertical, 12)
                    .onAppear {
                        self.progressStore.percent = self.percent
                    }
                    .onChange(of: percent) { newValue in
                        self.progressStore.percent = newValue
                    }
            }

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(habitsForTheDay) { habit in
                        HStack {
                            CheckBoxButtonWrapper(isChecked: Binding<Bool>(
                                get: { self.checkedHabits[habit.id] ?? false },
                                set: {
                                    self.checkedHabits[habit.id] = $0
                                    saveCheckedHabits()
                                    self.progressStore.percent = self.percent
                                }
                            ))
                            .frame(width: 45, height: 45)
                            Text(habit.name)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }

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
        .onAppear {
            loadCheckedHabits()
        }
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
        let checkedHabitsData = try? JSONEncoder().encode(checkedHabits)
        UserDefaults.standard.set(checkedHabitsData, forKey: "checkedHabits")
    }
    
    func loadCheckedHabits() {
        
        if let checkedHabitsData = UserDefaults.standard.data(forKey: "checkedHabits"),
           let loadedCheckedHabits = try? JSONDecoder().decode([UUID: Bool].self, from: checkedHabitsData) {
            self.checkedHabits = loadedCheckedHabits
        }
    }
}

struct DayScreen_Previews: PreviewProvider {
    static var previews: some View {
        DayScreen(selectedDate: Date())
            .environmentObject(HabitStore())
            .environmentObject(ProgressStore())
    }
}

