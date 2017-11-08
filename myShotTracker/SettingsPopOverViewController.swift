//
//  SettingsPopOverViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-01-24.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class SettingsPopOverViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //@IBOutlets
    @IBOutlet weak var timePickerView: UIPickerView!
    @IBOutlet weak var scoreClockDirectionLabel: UILabel!
    @IBOutlet weak var scoreClockCountsDirectionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var okButton: UIButton!
    
    let timerMinutesArray = Array(00...20)
    let timerSecondsArray = Array(00...59)
    
    var minutes = 0
    var seconds = 0
    
    var dataPassed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Put a border around the OK button
        borderForButton()
        
        setupTimerPickerView()
        
        var timerArray = dataPassed.components(separatedBy: ":")
        
        let minutes = Int(timerArray[0])!
        let seconds = Int(timerArray[1])!
        
        timePickerView.selectRow(minutes, inComponent: 0, animated: true)
        timePickerView.selectRow(seconds, inComponent: 2, animated: true)
        
        updateScoreClockLabel()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear")
        
        dataPassed = selectedTimeFromPicker()
        print("dataPassed \(dataPassed)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    @IBAction func close(_ sender: Any) {
        
        dataPassed = selectedTimeFromPicker()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupTimerPickerView() {
        
        timePickerView.delegate   = self
        timePickerView.dataSource = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            
            return timerMinutesArray.count
            
        } else if component == 1 {
            
            return 1
            
        } else if component == 2 {
            
            return timerSecondsArray.count
            
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(describing: timerMinutesArray[row])
        } else if component == 1 {
            return ":"
        } else if component == 2 {
            return String(format: "%02d",timerSecondsArray[row])
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            minutes = timerMinutesArray[row]
        }
        
        if component == 2 {
            seconds = timerSecondsArray[row]
        }
        
        let selectedTime = String( minutes ) + ":" + String(format: "%02d", seconds)
        
        updateScoreClockLabel()
        
        dataPassed = selectedTime
        
    }
    
    @IBAction func ScoreClockCountsDirection(_ sender: Any) {
        
        switch (sender as! UISegmentedControl).selectedSegmentIndex {
            
        case 0:
            scoreClockDirectionLabel.text = "Score clock counts down from " + selectedTimeFromPicker()
        case 1:
            scoreClockDirectionLabel.text = "Score clock counts up to " + selectedTimeFromPicker()
        default:
            break
        }
    }
    
    func selectedTimeFromPicker () -> String {
        
        let minutes = timePickerView.selectedRow(inComponent: 0)
        let seconds = timePickerView.selectedRow(inComponent: 2)
        
        let selectedTime = String( minutes ) + ":" + String(format: "%02d", seconds)
        
        return selectedTime
        
    }
    
    func updateScoreClockLabel ()  {
        
        if scoreClockCountsDirectionSegmentedControl.selectedSegmentIndex == 0 {
            
            scoreClockDirectionLabel.text = "Score clock counts down from " + selectedTimeFromPicker()
            
        } else {
            
            scoreClockDirectionLabel.text = "Score clock counts up to " + selectedTimeFromPicker()
        }
    }
    
    func borderForButton () {
        
        okButton.backgroundColor = .clear
        okButton.layer.cornerRadius = 5
        okButton.layer.borderWidth = 1
        okButton.layer.borderColor = UIColor.black.cgColor
    }
}
