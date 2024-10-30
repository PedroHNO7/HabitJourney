import Foundation
import SQLite3

class DBManager {
    let dataPath: String = "MyDB"
    var db: OpaquePointer?

    let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)

    init() {
        db = openDatabase()
        createUserTable()
        createHabitTable()
    }

    // Abrindo o BD
    func openDatabase() -> OpaquePointer? {
        let filePath = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dataPath)

        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            debugPrint("Não foi possível abrir o BD.")
            return nil
        } else {
            print("BD criado com sucesso.")
            return db
        }
    }

    // Criando a tabela User
    func createUserTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS User (
                userID TEXT PRIMARY KEY,
                userName TEXT NOT NULL,
                email TEXT NOT NULL UNIQUE,
                password TEXT NOT NULL
            );
        """

        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela User criada com sucesso.")
            } else {
                print("Erro na criação da Tabela User.")
            }
        } else {
            print("Erro na preparação da Tabela User.")
        }
        sqlite3_finalize(createTableStatement)
    }

    // Criando a tabela Habit
    func createHabitTable() {
        let createTableString = """
                CREATE TABLE IF NOT EXISTS Habit (
                    taskID TEXT PRIMARY KEY,
                    userID TEXT,
                    title TEXT NOT NULL,
                    recurrence TEXT NOT NULL,
                    isChecked INTEGER DEFAULT 0,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    FOREIGN KEY (userID) REFERENCES User(userID)
                );
            """

        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela Habit criada com sucesso.")
            } else {
                print("Erro na criação da Tabela Habit.")
            }
        } else {
            print("Erro na preparação da Tabela Habit.")
        }
        sqlite3_finalize(createTableStatement)
    }

    // Inserir novo usuário
    func insertUser(user: User) -> Bool {
        let insertStatementString = "INSERT INTO User (userID, userName, email, password) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let uuid = UUID().uuidString
            sqlite3_bind_text(insertStatement, 1, uuid, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 2, (user.name as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 3, (user.email as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 4, (user.password as NSString).utf8String, -1, SQLITE_TRANSIENT)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Usuário criado com sucesso.")
                sqlite3_finalize(insertStatement)
                return true
            } else {
                print("Não foi possível criar o usuário.")
            }
        } else {
            print("Falha ao preparar o INSERT.")
        }
        sqlite3_finalize(insertStatement)
        return false
    }

    // Inserir novo hábito
    func insertHabit(habit: Habit) -> Bool {
        let insertStatementString = "INSERT INTO Habit (taskID, userID, title, recurrence) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let uuid = UUID().uuidString
            sqlite3_bind_text(insertStatement, 1, uuid, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 2, (habit.userID as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 3, (habit.title as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(insertStatement, 4, (habit.recurrence as NSString).utf8String, -1, SQLITE_TRANSIENT)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Hábito criado com sucesso.")
                sqlite3_finalize(insertStatement)
                return true
            } else {
                print("Não foi possível criar o hábito.")
            }
        } else {
            print("Falha ao preparar o INSERT para Habit.")
        }
        sqlite3_finalize(insertStatement)
        return false
    }

    // Ler todos os hábitos
    func getAllHabits() -> [Habit] {
        let queryStatementString = "SELECT * FROM Habit;"
        var queryStatement: OpaquePointer? = nil
        var habits: [Habit] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let ID = String(cString: sqlite3_column_text(queryStatement, 0))
                let userID = String(cString: sqlite3_column_text(queryStatement, 1))
                let title = String(cString: sqlite3_column_text(queryStatement, 2))
                let recurrence = String(cString: sqlite3_column_text(queryStatement, 3))

                let habit = Habit(id: ID, userID: userID, title: title, recurrence: recurrence  )
                habits.append(habit)
                
                
                print(habits)
            }
        } else {
            print("Falha ao executar SELECT para Habit.")
        }
        sqlite3_finalize(queryStatement)
        return habits
    }
    
    // Logar o usuário
    func logUser(email:String) -> [User] {
        let queryStatementString = "SELECT * FROM User WHERE email = ?;"
        var queryStatement: OpaquePointer? = nil
        var user : [User] = []
        
        if sqlite3_prepare_v2(db,  queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, SQLITE_TRANSIENT)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                user.append(User(id: id, name: name, email: email, password: password))
                print("Detalhes do usuário:")
                print("| \(id) | \(name) | \(email) | \(password) |")
            }
        } else {
            print("SELECT statement falhou.")
        }
        sqlite3_finalize(queryStatement)
        return user
    }

    // Ler hábitos por ID de usuário
    func getHabitsByUserID(userID: String) -> [Habit] {
        let queryStatementString = "SELECT * FROM Habit WHERE userID = ?;"
        var queryStatement: OpaquePointer? = nil
        
        var habits: [Habit] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (userID as NSString).utf8String, -1, SQLITE_TRANSIENT)

            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let ID = String(cString: sqlite3_column_text(queryStatement, 0))
                let userID = String(cString: sqlite3_column_text(queryStatement, 1))
                let title = String(cString: sqlite3_column_text(queryStatement, 2))
                let recurrence = String(cString: sqlite3_column_text(queryStatement, 3))

                let habit = Habit(id: ID, userID: userID, title: title, recurrence: recurrence)
                
                habits.append(habit)
            }
        } else {
            print("Falha ao executar SELECT para Habit.")
        }
        sqlite3_finalize(queryStatement)
        return habits
    }


}
