import SwiftUI

struct DayScreen: View {
    @EnvironmentObject var habitStore: HabitStore
    @EnvironmentObject var progressStore: ProgressStore
    @State private var checkedHabits: Set<String> = []
    var selectedDate: Date

    var habitsForTheDay: [Habit] {
        let weekday = Calendar.current.component(.weekday, from: selectedDate) - 1
        return habitStore.habits.filter { $0.recurrence.contains(weekday != 0) }
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

    var body: some View {
        VStack {
            headerSection
            progressBarSection
            habitListSection
            footerSection
        }
        .onAppear {
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

                NavigationLink(destination: AddScreen(selectedDate: selectedDate)) {
                    Image("Button")
                }
            }
            .padding(.trailing, 20)
        }
    }

    private var progressBarSection: some View {
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
                                self.progressStore.percent = self.percent
                            }
                        ))
                        .frame(width: 45, height: 45)
                        
                        Text(habit.title) // Changed from habit.name to habit.title based on your Habit struct
                            .multilineTextAlignment(.center)
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
        let checkedHabitsData = try? JSONEncoder().encode(Array(checkedHabits))
        UserDefaults.standard.set(checkedHabitsData, forKey: "checkedHabits")
    }
    
    func loadCheckedHabits() {
        if let checkedHabitsData = UserDefaults.standard.data(forKey: "checkedHabits"),
           let loadedCheckedHabits = try? JSONDecoder().decode([String].self, from: checkedHabitsData) {
            self.checkedHabits = Set(loadedCheckedHabits)
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
