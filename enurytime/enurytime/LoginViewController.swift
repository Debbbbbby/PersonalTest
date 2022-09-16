import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "login_title_icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(w: 166)
        label.textAlignment = .center
        label.text = "네고 생활을 더 편하고 즐겁게"
        label.numberOfLines = 1 // 라벨의 최대 길이의 수
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(r: 198, g:41, b: 23)
        label.textAlignment = .center
        label.text = "에누리타임"
        label.numberOfLines = 1
        return label
    }()
    
    private let idTextField: InsetTextField = { // UITextField -> InsetTextField
        let textField = InsetTextField() // UITextField -> InsetTextField
        textField.insetX = 16 // 텍스트 왼쪽 여백 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "아이디"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = UIColor(w: 242)
        textField.layer.cornerRadius = 20
        textField.clipsToBounds = true
        return textField
    }()
    
    private let passwordTextField: InsetTextField = { // UITextField -> InsetTextField
        let textField = InsetTextField()  // UITextField -> InsetTextField
        textField.insetX = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.backgroundColor = UIColor(w: 242)
        textField.layer.cornerRadius = 20
        textField.isSecureTextEntry = true // 비밀번호 입력시 보이지 않게 설정
        textField.clipsToBounds = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("에누리타임 로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(r: 198, g: 41, b: 23)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(UIColor(w: 41), for: .normal)
        return button
    }()
    
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 4 // 부족할 경우 viewDidLoad에서 CustomSpacing 추가
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    private var centerYConstraint: NSLayoutConstraint? //중앙 정렬 제약조건을 키보드 입력 시 변경해주기 위해 따로 프로퍼티로 생성
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.container)
        
        self.container.addArrangedSubview(self.titleImageView) // stackview 추가시 addArrangedSubview
        self.container.addArrangedSubview(self.descriptionLabel)
        self.container.addArrangedSubview(self.titleLabel)
        
        self.container.addArrangedSubview(self.idTextField)
        self.container.addArrangedSubview(self.passwordTextField)
        
        self.container.setCustomSpacing(10, after: titleImageView)
        self.container.setCustomSpacing(46, after: self.titleLabel) // labelbottom과 InsetTextField 사이의 간격 46
        
        self.container.addArrangedSubview(self.loginButton)
        self.container.addArrangedSubview(self.signupButton)
        
        self.container.setCustomSpacing(30, after: self.loginButton)
        
        let constraint = self.container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            
            //self.container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), // stackView의 중앙 정렬 제약조건을 constraint라는 변수로 처리
            constraint,
            
            self.titleImageView.heightAnchor.constraint(equalToConstant: 60),
            self.titleImageView.widthAnchor.constraint(equalToConstant: 60),
            
            self.idTextField.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.idTextField.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.idTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.loginButton.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.loginButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        self.centerYConstraint = constraint
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDIdTap)) // 아래 @objc viewDIdTap()
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 뷰가 클릴될 때 강제로 editing을 멈추게 하기
    @objc func viewDIdTap(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        let keyboardHeight = keyboardFrame.height
        UIView.animate(withDuration: duration) { // 애니메이션 처리
            [self.titleImageView, self.descriptionLabel, self.titleLabel, self.signupButton].forEach { view in
                view.alpha = 0 // 로고, 타이틀, 설명, 회원가입 버튼 투명도 0
            }
            self.centerYConstraint?.constant = -keyboardHeight
            self.view.layoutIfNeeded()
        }
        self.centerYConstraint?.constant = -keyboardHeight
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        UIView.animate(withDuration: duration) { // 애니메이션 처리
            [self.titleImageView, self.descriptionLabel, self.titleLabel, self.signupButton].forEach { view in
                view.alpha = 1 // 로고, 타이틀, 설명, 회원가입 버튼 다시 보이게 설정
            }
            self.centerYConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
}
