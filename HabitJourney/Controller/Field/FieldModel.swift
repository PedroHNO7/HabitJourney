import Foundation

//modelo para validação de campos
struct FieldModel{
    
    var value: String
    var error: String?
    var fieldType: FieldType
    
    init(value: String, fieldType: FieldType, error: String? = nil){
        self.value = value
        self.fieldType = fieldType
        self.error = error
    }
    
    //uma mutating func é usada dentro de estruturas (structs) ou enums para indicar que essa função irá modificar os valores das propriedades da instância da estrutura ou enum. Por padrão, as estruturas são imutáveis, ou seja, suas propriedades não podem ser modificadas por métodos, a menos que o método seja marcado com a palavra-chave mutating.
    mutating func onValidate() -> Bool {
        error = fieldType.validate(value: value)
        return error == nil
    }
    
    mutating func onSubmitError(){
        error = fieldType.validate(value: value)
    }
}

