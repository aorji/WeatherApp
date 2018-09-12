//
//  SecondViewController.swift
//  Weather
//
//  Created by Anastasiia ORJI on 9/11/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func newCityEntered (city: String)
}

class SecondViewController: UIViewController {

    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var newCityName: UITextField!
    
    @IBAction func getWeatherButton(_ sender: UIButton) {
        let cityName = newCityName.text!
        delegate?.newCityEntered(city: cityName)
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func swichPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
