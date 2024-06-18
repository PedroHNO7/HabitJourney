import UIKit

class CheckBox: UIButton {
    let checkedImage = UIImage(named: "Checked")
    let uncheckedImage = UIImage(named: "Unchecked")
    
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
