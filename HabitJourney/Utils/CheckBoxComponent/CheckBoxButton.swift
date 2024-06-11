import UIKit

class CheckBoxButton: UIButton {
    
    // Default images for checked and unchecked states
    private let checkedImage = UIImage(named: "Checked")
    private let uncheckedImage = UIImage(named: "Unchecked")
    
    // Title for the checkbox button
    var checkboxTitle: String?
    
    // Initial setup
    func setup() {
        addTarget(self, action: #selector(checkboxTapped(_:)), for: .touchUpInside)
        isSelected = false
        setImage(uncheckedImage, for: .normal)  
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if let title = checkboxTitle {
            setTitle(title, for: .normal)
        }
    }
    
    // Action when checkbox is tapped
    @objc func checkboxTapped(_ sender: UIButton) {
        isSelected = !isSelected
        if isSelected {
            setImage(checkedImage, for: .normal)
        } else {
            setImage(uncheckedImage, for: .normal)
        }
    }
}
