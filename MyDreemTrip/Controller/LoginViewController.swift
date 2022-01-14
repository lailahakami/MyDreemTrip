
import UIKit
import Firebase
class LoginViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    
    
    
    @IBOutlet weak var viewLogin: UIView!
    
    
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.placeholder = "Please enter your email".localized
        }
    }

    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.placeholder = "Please enter your password".localized
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var emailLabel: UILabel! {
        didSet{
            emailLabel.text = "Email".localized
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel!{
        didSet{
            passwordLabel.text = "Password".localized
            
        }
      
    }
    
    @IBOutlet weak var LoginLabel: UIButton!{
        
            didSet {
                LoginLabel.setTitle(NSLocalizedString("Login", tableName: "Localizaple", comment: ""),for: .normal)
    
        }
    
        }
    
    
    @IBOutlet weak var RegisterButton: UIButton!{
        didSet {
            RegisterButton.setTitle(NSLocalizedString("Register", tableName: "Localizaple", comment: ""),for: .normal)

    }
    }
    
    @IBOutlet weak var OrLabel: UILabel! {
        didSet{
            OrLabel.text = "You don't have an account?".localized
            
        }
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            
            view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
            viewLogin.layer.shadowColor = UIColor.gray.cgColor
             viewLogin.layer.shadowOffset = .zero
             viewLogin.layer.cornerRadius = 10
             viewLogin.layer.shadowPath = UIBezierPath(rect: viewLogin.bounds).cgPath
             viewLogin.layer.shouldRasterize = true
             self.viewLogin.layer.cornerRadius = 10
        
    
        }
        
    @IBAction func handleLogin(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    
}

