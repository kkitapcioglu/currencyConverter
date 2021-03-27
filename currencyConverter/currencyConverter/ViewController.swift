//
//  ViewController.swift
//  currencyConverter
//
//  Created by Kubilay Kitapçıoğlu on 23.01.2020.
//  Copyright © 2020 Kubilay Kitapçıoğlu. All rights reserved.
//

import UIKit
//info.plistte app transportation settingsi ekle sonra allow arbitrary loadsu ekle ve yes yap
class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        // 1)Request & Session
        // 2)Response & Data
        // 3) Parsing & JSON Serialization
        
        //STEP1 STARTED
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=40333dc9f61ac9807380bb512aea8abf&format=1")
        
        let session = URLSession.shared
        //closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                if data != nil { // STEP 2 STARTED
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any> // json dosyamızı string dictionarysi olarak cast ediyoruz ki datayla işlemleri kolay yapalım [String : Any]
                        
                    
                        //ASYNC
                        DispatchQueue.main.async { //farklı bi threadde çalışır
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CAD: \(chf)"
                                }
                                
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                
                                if let turk = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turk)"
                                }
                            }
                        }
 
                    } catch{
                        print("ERROR.")
                    }
                    
                }
                
            }
            
        }
        task.resume() // bunu yazmassan başlamaz
        
    }
    
    
}

