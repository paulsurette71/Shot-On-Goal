//
//  ScoreClockPopoverViewController.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-04-05.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class ScoreClockPopoverViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var picker: ScoreClockPicker!
    
    //Protocol
    var currentPeriod: Period?
    var periodSelected: storeScoreClockDelegate?
    var sender: UIButton?
    
    //App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Pass MainView
    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad->ScoreClockPopoverViewController")
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard appDelegate.periodSelected != nil else {
            
            return
        }
        
        currentPeriod = appDelegate.periodSelected
        picker.setPickerToSelectedPeriod(currentPeriod: currentPeriod!)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let currentScoreClockPeriod = selectedPeriodFromPicker()
        
        //Save the values from the score clock in the Delegate
        periodSelected?.storeScoreClock(periodSelected: currentScoreClockPeriod)
        
        let buttonImagesForState = ButtonImagesForState()
        buttonImagesForState.setButtonImages(period: currentScoreClockPeriod, mainView: mainView)
        mainView?.selectedPeriod = currentScoreClockPeriod
        
    }
    
    func selectedPeriodFromPicker () -> Period {
        
        let selectedPeriodRow = picker.selectedRow(inComponent: 0)
        
        var selectedPeriod: Period?
        
        switch selectedPeriodRow {
        case 0:
            selectedPeriod = .first
        case 1:
            selectedPeriod = .second
        case 2:
            selectedPeriod = .third
        case 3:
            selectedPeriod = .overtime
        case 4:
            selectedPeriod = .shootout
        default:
            selectedPeriod = .first
        }
        
        return selectedPeriod!
    }
}
