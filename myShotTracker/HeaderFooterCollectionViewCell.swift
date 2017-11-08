//
//  HeaderFooterCollectionViewCell.swift
//  Shot On Goal
//
//  Created by Surette, Paul on 2017-10-06.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit

class HeaderFooterCollectionViewCell: UICollectionViewCell {
    
    //Tableview
    @IBOutlet weak var tableView: UITableView!
    
    //Buttons
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var periodButton: UIButton!
    @IBOutlet weak var undoButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("HeaderFooterCollectionViewCell awakeFromNib")
        
        tableView.delegate   = self as? UITableViewDelegate
        tableView.dataSource = self as  UITableViewDataSource
        
    }
    
    @IBAction func reset(_ sender: Any) {
        print("reset")
        
    }
    
    @IBAction func period(_ sender: Any) {
        print("period")

    }
    
    @IBAction func undo(_ sender: Any) {
        print("undo")
}
    
}

extension HeaderFooterCollectionViewCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  Bundle.main.loadNibNamed("ShotInformationTableViewCell", owner: self, options: nil)?.first as! ShotInformationTableViewCell
        
        return cell
    }
}
