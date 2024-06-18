import UIKit

class CheckBox: UIButton {
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                setImage(checkedImage, for: .normal)
            } else {
                setImage(uncheckedImage, for: .normal)
            }
        }
    }
    @objc private func checkBoxTapped() {
        isChecked.toggle()
    }
}
