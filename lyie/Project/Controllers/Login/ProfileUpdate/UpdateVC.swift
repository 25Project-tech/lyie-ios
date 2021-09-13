//
//  UpdateVC.swift
//  lyie
//
//  Created by Sevcan Eşim on 27.04.2021.
//

import UIKit
import Parse

class UpdateVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var leftBarButtonIcon: UIImageView!
    @IBOutlet weak var rightBarButtonIcon: UIImageView!
    
    @IBOutlet weak var imagevc: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UpdateVC.choosePhoto))
//        imagevc.addGestureRecognizer(gestureRecognizer)
    }
    
//    @objc func choosePhoto() {
//
//    }
    
    @IBAction func tappedImageButton(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagevc.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func tappedButton(_ sender: Any) {
        
        let educationCount = EducationsService.allEducationsList().count
        for i in 0..<educationCount {
            let educationMainCoursesObject = PFObject(className: "EducationChildCourses")
            educationMainCoursesObject["courseId"] = EducationsService.allEducationsList()[i].id
            
            if EducationsService.allEducationsList()[i].mainEducation == .inovation {
                educationMainCoursesObject["mainEducation"] = "Inovation"
            } else if EducationsService.allEducationsList()[i].mainEducation == .ai {
                educationMainCoursesObject["mainEducation"] = "Ai"
            } else {
                educationMainCoursesObject["mainEducation"] = "Iot"
            }
            
            educationMainCoursesObject["mainEducationValue"] = EducationsService.allEducationsList()[i].mainEducationValue
            educationMainCoursesObject["mainEducationCellNum"] = EducationsService.allEducationsList()[i].mainEducationCellNum
            educationMainCoursesObject["title"] = EducationsService.allEducationsList()[i].title
            educationMainCoursesObject["descText"] = EducationsService.allEducationsList()[i].descText
            
            if let educationImage = UIImage(named: EducationsService.allEducationsList()[i].imageString)?.resize(toHeight: 650.0)?.pngData() {
                let imageFile = PFFileObject(name: "\(i).png", data: educationImage)
                educationMainCoursesObject["educationImageFile"] = imageFile
                educationMainCoursesObject["imageURL"] = ""
            }
            
            educationMainCoursesObject.saveInBackground { (success, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else  {
                    print("success image", i)
                }
            }
        }
    }
}
