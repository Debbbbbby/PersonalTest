import Foundation
import UIKit

class InsetTextField: UITextField {
    var insetX: CGFloat = 0 { // 인셋이 바뀌면
        didSet {
            layoutIfNeeded() // 다시 레이아웃을 그리겠다.
        }
    }
    
    var insetY: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    // textField의 text영역을 지정해주는 함수
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY) // 기존 inset값을 바꿔준다.
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}
