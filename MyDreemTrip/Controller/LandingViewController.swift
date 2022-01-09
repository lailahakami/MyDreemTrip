
import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var segmentLanguge: UISegmentedControl! {
        
        didSet{
            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                switch lang {
                case "ar":
                    segmentLanguge.selectedSegmentIndex = 0
                    UIView.appearance().semanticContentAttribute = .forceRightToLeft
                case "en":
                    segmentLanguge.selectedSegmentIndex = 1
                    UIView.appearance().semanticContentAttribute = .forceLeftToRight
                default:
                    let localLang =  Locale.current.languageCode
                     if localLang == "en" {
                         segmentLanguge.selectedSegmentIndex = 1
                         
                     }else {
                         segmentLanguge.selectedSegmentIndex = 0
                     }
                  
                }
            
            }else {
                let localLang =  Locale.current.languageCode
                UserDefaults.standard.setValue([localLang], forKey: "AppleLanguages")
                 if localLang == "en" {
                     segmentLanguge.selectedSegmentIndex = 1
                 } else {
                     segmentLanguge.selectedSegmentIndex = 0
                 }
            }
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet{
            loginButton.setTitle(NSLocalizedString("Login", tableName: "Localizaple", comment: ""),for: .normal)
//            loginButton.setTitle("Login".localized, for: .normal)
        }
    }
    @IBOutlet weak var MyDreemTrip: UILabel! {
        didSet {
            MyDreemTrip.text = "MyDreamTrip".localized
        }
    }
    
    @IBOutlet weak var orLabel: UILabel! {
        
        didSet {
            
            
            orLabel.text = "OR".localized
//
//            orLabel.text = "OR".localized
        }
    }
    
    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.setTitle(NSLocalizedString("Register", tableName: "Localizaple", comment: ""),for: .normal)
//            registerButton.setTitle("Register".localized, for: .normal)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    
    @IBAction func actionsegmentLanguge(_ sender: UISegmentedControl) {
        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
                     UserDefaults.standard.set(lang, forKey: "currentLanguage")
                    Bundle.setLanguage(lang)
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                    }
        }

    }
        
}
extension String {
       
        var localized: String {
            return NSLocalizedString(self, tableName: "Localizaple", bundle: .main, value: self, comment: self)
        }
}
