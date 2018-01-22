//
//  GoalieDetailsTableViewController.swift
//  myShotTracker
//
//  Created by Surette, Paul on 2017-02-09.
//  Copyright © 2017 Surette, Paul. All rights reserved.
//

import UIKit
import CoreData

class GoalieDetailsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var managedContext: NSManagedObjectContext!
    var coreDataStack = CoreDataStack(modelName: "GoalieInformation")
    var newGoalie = false
    
    let imagePickerController = UIImagePickerController()
    
    //@IBOutlet
    //UITextField
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var leagueTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!
    @IBOutlet weak var divisionTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    //UILabel
    @IBOutlet weak var ageLabel: UILabel!
    
    //UIDatePicker
    @IBOutlet weak var dateOfBirthDatePicker: UIDatePicker!
    
    //JPEG Compresion
    let bestQuality:CGFloat = 1.0
    
    //Classes
    let roundedImageView = RoundedImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerImageView.contentMode = .scaleAspectFill
        
        //Move the TableView down a little bit.
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 0, right: 0)
        
        imagePickerController.delegate = self
        
        roundedImageView.setRounded(image: playerImageView, colour: "hockeyNetRed")
        
        configureView()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        guard !imagePickerController.isBeingPresented else {
            //if the imagePickerController is being Presented, get out of here.
            return
        }
        
//        //Check to see if the mandatory first name, last name and number are empty.
//        guard !(firstNameTextField.text?.isEmpty)!, !(lastNameTextField.text?.isEmpty)!,!(numberTextField.text?.isEmpty)!  else {
//            //Found empty fields.
//            return
//        }
        
        //Check to see if the mandatory first name, last name and number are empty.
        guard !(numberTextField.text?.isEmpty)!  else {
            //Found empty fields.
            return
        }

        
        if newGoalie {
            
            saveNewGoalie()
            
        } else {
            
            updateGoalie()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 15
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        //http://stackoverflow.com/questions/19802336/changing-font-size-for-uitableview-section-headers
        
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        
    }
    
    
    
    func saveNewGoalie() {
        
        //http://stackoverflow.com/questions/27995955/saving-picked-image-to-coredata
        
        do {
            
            let entity = NSEntityDescription.entity(forEntityName: "GoalieInformation", in: managedContext)
            let newGoalie = GoalieInformation(entity: entity!, insertInto: managedContext)
            
            newGoalie.firstName    = firstNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.lastName     = lastNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.number       = numberTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            newGoalie.city         = cityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.teamName     = teamNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.leagueName   = leagueTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.divisionName = divisionTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.level        = levelTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.height       = heightTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            newGoalie.weight       = weightTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            //HeadShot
            let goalieImage = UIImageJPEGRepresentation(playerImageView.image!, bestQuality) as NSData?
            
            newGoalie.goalieHeadShot = goalieImage
            newGoalie.dob          = dateOfBirthDatePicker.date as NSDate?
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("\(self) -> \(#function) \(error), \(error.userInfo)")
        }
        
    }
    
    func updateGoalie() {
        
        do {
            let updateCurrentGoalie = detailItem
            
            updateCurrentGoalie?.firstName    = firstNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.lastName     = lastNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.number       = numberTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.city         = cityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.teamName     = teamNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.leagueName   = leagueTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.divisionName = divisionTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.level        = levelTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.height       = heightTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.weight       = weightTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            updateCurrentGoalie?.dob          = dateOfBirthDatePicker.date as NSDate?
            
            //HeadShot
            updateCurrentGoalie?.goalieHeadShot = UIImageJPEGRepresentation(playerImageView.image!, bestQuality) as NSData?
            
            try detailItem?.managedObjectContext?.save()
            
        } catch let error as NSError {
            print("\(self) -> \(#function) \(error), \(error.userInfo)")
        }
        
    }
    
    var detailItem: GoalieInformation? {
        
        didSet {
            
            self.configureView()
            
        }
    }
    
    func configureView() {
        
        // Update the user interface for the detail item.
        
        if let detail = self.detailItem {
            if let label = self.firstNameTextField {
                label.text = detail.firstName
            }
            if let label = self.lastNameTextField {
                label.text = detail.lastName
            }
            if let label = self.numberTextField {
                label.text = detail.number
            }
            if let label = self.cityTextField {
                label.text = detail.city
            }
            if let label = self.teamNameTextField {
                label.text = detail.teamName
            }
            if let label = self.leagueTextField {
                label.text = detail.leagueName
            }
            if let label = self.divisionTextField {
                label.text = detail.divisionName
            }
            if let label = self.levelTextField {
                label.text = detail.level
            }
            if let picker = self.dateOfBirthDatePicker {
                picker.date = detail.dob! as Date
            }
            if let label = self.ageLabel {
                
                let birthdate = calculateBirthDate(birthdate: detail.dob! as Date)
                label.text = String(describing: birthdate) //+ " years old"
            }
            
            if let label = self.weightTextField {
                label.text = detail.weight
            }
            if let label = self.heightTextField {
                label.text = detail.height
            }
            
            if let image = self.playerImageView {
                
                image.image = UIImage(data:detail.goalieHeadShot! as Data,scale:1.0)
            }
        }
    }
    
    //Picker
    @IBAction func birthDate(_ sender: Any) {
        
        let birthdate = (sender as! UIDatePicker).date
        
        let age = calculateBirthDate(birthdate: birthdate)
        
        ageLabel.text = String(describing: age) //+ " years old"
        
    }
    
    func calculateBirthDate(birthdate: Date) -> Int {
        
        let calendar = NSCalendar.current
        
        let components = calendar.dateComponents([.year], from: birthdate, to: Date())
        
        return components.year!
        
    }
    
    @IBAction func takeHeadShot(_ sender: Any) {
        
        takePicture()
        
    }
    
    //Camera Stuff
    
    func takePicture() {
        
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        imagePickerController.cameraCaptureMode = .photo
        imagePickerController.modalPresentationStyle = .fullScreen
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let resizedImage = resizeImage(image: info[UIImagePickerControllerOriginalImage] as! UIImage, newWidth: 500.0)
        
        playerImageView.image = resizedImage
        
        dismiss(animated:true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated:true, completion: nil)
        
    }
    
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        //http://nshipster.com/image-resizing/
        
        let size = image.size.applying(CGAffineTransform(scaleX: 0.10, y: 0.10))
        let hasAlpha = false
        let scale: CGFloat = 3.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint(), size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
        
    }
}
