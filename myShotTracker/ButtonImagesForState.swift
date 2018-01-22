//
//  ButtonImagesForState.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-31.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import Foundation
import UIKit

class ButtonImagesForState {
    
    func setButtonImages(period: Period, mainView: MainView!) {
        
        switch period {
        case .first:
            mainView.leftPeriodButton.setImage(UIImage(named: "options 1st period enabled cell"), for: .normal)
            mainView.leftPeriodButton.setImage(UIImage(named: "options 1st period disabled cell"), for: .disabled)
            
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 1st period enabled"), for: .normal)
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 1st period disabled"), for: .disabled)
            
        case .second:
            mainView.leftPeriodButton.setImage(UIImage(named: "options 2nd period enabled cell"), for: .normal)
            mainView.leftPeriodButton.setImage(UIImage(named: "options 2nd period disabled cell"), for: .disabled)
            
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 2nd period enabled"), for: .normal)
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 2nd period disabled"), for: .disabled)
            
        case .third:
            mainView.leftPeriodButton.setImage(UIImage(named: "options 3rd period enabled cell"), for: .normal)
            mainView.leftPeriodButton.setImage(UIImage(named: "options 3rd period disabled cell"), for: .disabled)
            
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 3rd period enabled"), for: .normal)
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer 3rd period disabled"), for: .disabled)
            
        case .overtime:
            mainView.leftPeriodButton.setImage(UIImage(named: "options Overtime period enabled cell"), for: .normal)
            mainView.leftPeriodButton.setImage(UIImage(named: "options Overtime period disabled cell"), for: .disabled)
            
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer overtime enabled"), for: .normal)
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer overtime disabled"), for: .disabled)
            
        case .shootout:
            mainView.leftPeriodButton.setImage(UIImage(named: "options Shootout period enabled cell"), for: .normal)
            mainView.leftPeriodButton.setImage(UIImage(named: "options Shootout period disabled cell"), for: .disabled)
            
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer shootout enabled"), for: .normal)
            mainView.rightPeriodButton.setImage(UIImage(named: "options footer shootout disabled"), for: .disabled)
            
        }  //switch
        
    }  //setButtonImages
    
}  //ButtonImagesForState
