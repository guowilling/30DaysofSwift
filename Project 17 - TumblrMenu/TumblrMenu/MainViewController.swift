
import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        self.dismiss(animated: true, completion: nil)
    }
}
