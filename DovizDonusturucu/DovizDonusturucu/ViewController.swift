//
//  ViewController.swift
//  DovizDonusturucu
//
//  Created by Gizemnur Özden on 15.09.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serilatizion
        
        //1.
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=c3389acc3839e69401ff571f49b7b647")
        let session = URLSession.shared
        
        //Closure
        
        let task = session.dataTask(with: url!) { (data,response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil )
                
            }else {
                //2.
                if data != nil {
                    do {
                        let jsonResponse = try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                            
                            //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                            
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                               
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let  turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(turkish)"
                                }
                                
                            }
                        }
                        
                        
                        
                    }catch {
                        print("error")
                    }
                   
                    
                }
                    
                
            }
        }
        task.resume()
        
    }
}

