//
//  ViewController.swift
//  Regester Form
//
//  Created by Droadmin on 6/20/23.
//
import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    let sportsArray = ["Cricket","Chess", "Football", "Volleyball", "Swimming", "Running", "Traveling"]
   
    var datepicker = UIDatePicker()
   
    @IBOutlet weak var photoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableViewHeightConstraunt: NSLayoutConstraint!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var dobtext: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    
//        btnMale.setTitle("Male", for: .normal)
//        btnMale.setImage(UIImage(named: "RadiobtnOff"), for: .normal)
//        btnMale.setTitle("Male", for: .selected)
//        btnMale.setImage(UIImage(named: "Radiobtnon"), for: .selected)
//
//        btnFemale.setTitle("Female", for: .normal)
//        btnFemale.setImage(UIImage(named: "RadiobtnOff"), for: .normal)
//        btnFemale.setTitle("Female", for: .selected)
//        btnFemale.setImage(UIImage(named: "Radiobtnon"), for: .selected)
        self.tableView.reloadData()
        
        }
    
    @IBAction func addPhoto(_ sender: Any) {
        let ac = UIAlertController(title: "Select Image", message: "Select Image From", preferredStyle: .actionSheet)
        let camaraBtn = UIAlertAction(title: "Camera", style: .default){(_)in
            self.showImagePicker(selectedSource: .camera)
        }
        let gallaryBtn = UIAlertAction(title: "Gallary", style: .default){(_)in
            self.showImagePicker(selectedSource: .photoLibrary)
        }
        let canselBtn = UIAlertAction(title: "Cancle", style: .cancel,handler:  nil)
        ac.addAction(camaraBtn)
        ac.addAction(gallaryBtn)
        ac.addAction(canselBtn)
        self.present(ac,animated: true)
        }
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource)else{
            print("Selected Source not availabel")
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = selectedSource
        imagePicker.allowsEditing = false
        self.present(imagePicker,animated: true)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage]as? UIImage{
            imageView.image = selectedImage
        }else{
            print("Image not found")
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    @IBAction func radioBtn(_ sender: UIButton) {
        if sender == btnMale{
            btnMale.isSelected = true
            btnFemale.isSelected = false
        }else{
            btnMale.isSelected = false
            btnFemale.isSelected = true
        }
    }
   
   
   
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        dobtext.inputAccessoryView = toolbar
        dobtext.inputView = datepicker
        datepicker.datePickerMode = .date
             
        if #available(iOS 14.0, *) {
                datepicker.preferredDatePickerStyle = .wheels
            }
    }
    @objc func donePressed()
    {
        let formater = DateFormatter()
        formater.dateStyle = .medium
        formater.timeStyle = .none
        dobtext.text = formater.string(from: datepicker.date)
        self.view.endEditing(true)
    }
    
    
    
    func validateName(_ name: String?, fieldName: String) -> Bool {
        let trimmedName = name?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName?.isEmpty ?? true {
            let alert = UIAlertController(title: "Error", message: "Please enter the \(fieldName)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func submitbtn(_ sender: Any) {
        let isValid = validateName(fnameTF.text, fieldName: "First Name") &&
               validateName(lnameTF.text, fieldName: "Last Name")
           
           if isValid {
               print("Form submitted successfully")
           } else {
               print("Form validation failed")
           }
    }
    
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource, hobbyManager{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sportsArray.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell")as! MyTableViewCell
        cell.checklbl.text = sportsArray[indexPath.row]
        cell.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.tableViewHeightConstraunt.constant = self.tableView.contentSize.height
        })
        return cell
        
    }
      
       func selectHobby(cell: MyTableViewCell) {
        cell.checkBtn.isSelected = !cell.checkBtn.isSelected

        
    }
    
}

protocol hobbyManager{
    func selectHobby(cell: MyTableViewCell)
   
}

