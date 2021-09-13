//
//  SearchViewController.swift
//  lyie
//
//  Created by Sevcan Eşim on 10.01.2021.
//

import UIKit

protocol SearchDelegate {
    func onDismissed()
    func onChangeText(targetUniName: String)
    func onChangeText(targetDeptName: String)
    func onChangeText(hSchoolName: String)
    func onCitySet(city: Int)
    func onPlaceOfBirthSet(city: Int)
    func onChangeText(hSchoolDept: String)
    func onChangeText(newUserHG: String)
    func onChangeText(newUserUni: String)
    func onChangeText(newUserDept: String)
}

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Localizable, Styleable {
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var tfView: UIView!
    @IBOutlet var titleText: UILabel!
    
    var userItem: UserItem?
    var searchType: Int? //0 -> university // 1 -> department // 2-> highSchool // 3-> city // 4-> birthCity  //5-> newHG //6-> newUni //7-> newDept
    var searchDelegate: SearchDelegate!
    
    var universities = [UniversityServices]() {
        didSet {
            BG {
                self.UI {
                    self.myTableView?.reloadData()
                }
            }
        }
    }
    
//    var universities = LyieUtils.updateUniversity()
//    var highSchools = LyieUtils.updateHighSchool()
//    var cities = LyieUtils.updateCities()
//    var birthCities = LyieUtils.updateCities()
//
    var departments = [DepartmentServices]() {
        didSet {
            BG {
                self.UI {
                    self.myTableView?.reloadData()
                }
            }
        }
    }
    
    var highSchools = [HighSchoolServices]() {
        didSet {
            BG {
                self.UI {
                    self.myTableView?.reloadData()
                }
            }
        }
    }
    
    var hgDepartments = [DepartmentService]() {
        didSet {
            BG {
                self.UI {
                    self.myTableView?.reloadData()
                }
            }
        }
    }
    
    var cities = [CityServices]() {
        didSet {
            BG {
                self.UI {
                    self.myTableView?.reloadData()
                }
            }
        }
    }
    
    var birthCities = [CityServices]() {
        didSet {
            BG {
                self.UI {
                    self.myTableView?.reloadData()
                }
            }
        }
    }
    
    func applyLanguage() {
        switch searchType {
        case 0:
            titleText.text = "Üniversite"
        case 1:
            titleText.text = "Bölüm"
        case 2:
            titleText.text = "Lise"
        case 3:
            titleText.text = "İkamet Yeri"
        case 4:
            titleText.text = "Doğum Yeri"
        case 5:
            titleText.text = "Lise"
        case 6:
            titleText.text = "Üniversite"
        case 7:
            titleText.text = "Bölüm"
        case 8:
            titleText.text = "Lise Bölümü"
        default:
            LyieLog.mPrint("Default")
        }
    }
    
    func applyStyle() {
        switch searchType {
        case 0:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Üniversite Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 1:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Bölümlerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 2:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Liselerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 3:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Şehirlerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 4:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Şehirlerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 5:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Liselerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 6:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Üniversite Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 7:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Bölümlerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        case 8:
            searchTF.attributedPlaceholder = NSAttributedString(string: "Bölümlerde Ara", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            
        default:
            searchTF.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        searchTF.textColor = StyleManager.colors.leftTitleColor
        tfView.backgroundColor = .white
        tfView.borderColor = StyleManager.colors.borderColorBlue
    }
    
    @IBAction func tappedCancelButton(_ sender: Any) {
        searchDelegate?.onDismissed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startObservingLanguage()
        startObservingStyle()
        registerCell()
        config()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .white
    }
    
    deinit {
        stopObservingStyle()
        stopObservingLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    func registerCell() {
        myTableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    }
}

//tableview
extension SearchViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.selectionStyle = .blue
        cell.backgroundView?.backgroundColor = .clear
        
        switch searchType {
        case 0:
            if !universities.isEmpty {
                cell.config(uni: universities[indexPath.row])
            }
        case 1:
            if !departments.isEmpty {
                cell.config(dept: departments[indexPath.row] )
            }
        case 2:
            if !highSchools.isEmpty {
                cell.config(hscholl: highSchools[indexPath.row] )
            }
        case 3:
            if !cities.isEmpty {
                cell.config(cities: cities[indexPath.row] )
            }
        case 4:
            if !birthCities.isEmpty {
                cell.config(birthCities: birthCities[indexPath.row] )
            }
        case 5:
            if !highSchools.isEmpty {
                cell.config(hscholl: highSchools[indexPath.row] )
            }
        case 6:
            if !universities.isEmpty {
                cell.config(uni: universities[indexPath.row])
            }
        case 7:
            if !departments.isEmpty {
                cell.config(dept: departments[indexPath.row] )
            }
        case 8:
            if !hgDepartments.isEmpty {
                cell.config(hgDept: hgDepartments[indexPath.row] )
            }
        default:
            LyieLog.mPrint("default")
        }
        
        //Added Filter Color for Univeresity List Cell
        let stringTitle = NSMutableAttributedString(string: cell.titleText.text!)
        stringTitle.setColorForText(searchTF.text!.lowercased(), with: StyleManager.colors.leftTitleColor)
        cell.titleText.attributedText = stringTitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchType {
        case 0:
            return universities.count
        case 1:
            return departments.count
        case 2:
            return highSchools.count
        case 3:
            return cities.count
        case 4:
            return birthCities.count
        case 5:
            return highSchools.count
        case 6:
            return universities.count
        case 7:
            return departments.count
        case 8:
            return hgDepartments.count
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchType {
        case 0:
            searchDelegate.onChangeText(targetUniName: UniversityServices.getUniName(by: universities[indexPath.row].id))
        case 1:
            searchDelegate.onChangeText(targetDeptName: DepartmentServices.getDepartmentName(by: departments[indexPath.row].id))
        case 2:
            searchDelegate.onChangeText(hSchoolName: HighSchoolServices.getName(by: highSchools[indexPath.row].id))
        case 3:
            searchDelegate.onCitySet(city: CityServices.getLicensePlateId(by: cities[indexPath.row].id))
        case 4:
            searchDelegate.onPlaceOfBirthSet(city: CityServices.getLicensePlateId(by: birthCities[indexPath.row].id))
        case 5:
            searchDelegate.onChangeText(newUserHG: HighSchoolServices.getName(by: highSchools[indexPath.row].id))
        case 6:
            searchDelegate.onChangeText(newUserUni: UniversityServices.getUniName(by: universities[indexPath.row].id))
        case 7:
            searchDelegate.onChangeText(newUserDept: DepartmentServices.getDepartmentName(by: departments[indexPath.row].id))
        case 8:
            searchDelegate.onChangeText(hSchoolDept: DepartmentService.getName(by: hgDepartments[indexPath.row].id))
        default:
            LyieLog.mPrint("default")
        }
        searchDelegate?.onDismissed()
    }
    
}


extension SearchViewController: UITextFieldDelegate {
    func config() {
        switch searchType {
        case 0:
            self.universities = UniversityServices.allUniversityList()
        case 1:
            self.departments = DepartmentServices.allDepartmentList()
        case 2:
            self.highSchools = HighSchoolServices.allHighSchoolList()
        case 3:
            self.cities = CityServices.allCityList()
        case 4:
            self.birthCities = CityServices.allCityList()
        case 5:
            self.highSchools = HighSchoolServices.allHighSchoolList()
        case 6:
            self.universities = UniversityServices.allUniversityList()
        case 7:
            self.departments = DepartmentServices.allDepartmentList()
        case 8:
            self.hgDepartments = DepartmentService.allDepartmentList()
        default:
            LyieLog.mPrint("default")
        }
        
        searchTF.delegate = self
        searchTF.addTarget(self, action: #selector(UITextFieldDelegate.textFieldShouldEndEditing(_:)), for: UIControl.Event.editingChanged)
    }
}


extension SearchViewController {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        BG {
            self.UI {
                switch self.searchType {
                case 0:
                    self.universities = UniversityServices.allUniversityList()
                    var tempUniversities = [UniversityServices]()
                    for item in self.universities {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempUniversities.append(item)
                        }
                    }
                    
                    print(tempUniversities)
                    
                    if tempUniversities.count > 0 {
                        self.universities = tempUniversities
                    } else {
                        if textField.text?.count == 0 {
                            self.universities = UniversityServices.allUniversityList()
                        } else {
                            self.universities = tempUniversities
                        }
                    }
                case 1:
                    self.departments = DepartmentServices.allDepartmentList()
                    var tempDepartments = [DepartmentServices]()
                    for item in self.departments {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempDepartments.append(item)
                        }
                    }
                    
                    print(tempDepartments)
                    
                    if tempDepartments.count > 0 {
                        self.departments = tempDepartments
                    } else {
                        if textField.text?.count == 0 {
                            self.departments = DepartmentServices.allDepartmentList()
                        } else {
                            self.departments = tempDepartments
                        }
                    }
                    
                case 2:
                    self.highSchools = HighSchoolServices.allHighSchoolList()
                    var tempHighSchools = [HighSchoolServices]()
                    for item in self.highSchools {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempHighSchools.append(item)
                        }
                    }
                    
                    print(tempHighSchools)
                    
                    if tempHighSchools.count > 0 {
                        self.highSchools = tempHighSchools
                    } else {
                        if textField.text?.count == 0 {
                            self.highSchools = HighSchoolServices.allHighSchoolList()
                        } else {
                            self.highSchools = tempHighSchools
                        }
                    }
                case 3:
                    self.cities = CityServices.allCityList()
                    var tempCities = [CityServices]()
                    for item in self.cities {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            if name.contains("İ") {
                                
                            }
                            tempCities.append(item)
                        }
                    }
                    
                    print(tempCities)
                    
                    if tempCities.count > 0 {
                        self.cities = tempCities
                    } else {
                        if textField.text?.count == 0 {
                            self.cities = CityServices.allCityList()
                        } else {
                            self.cities = tempCities
                        }
                    }
                case 4:
                    self.birthCities = CityServices.allCityList()
                    var tempBirthCities = [CityServices]()
                    for item in self.birthCities {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempBirthCities.append(item)
                        }
                    }
                    
                    print(tempBirthCities)
                    
                    if tempBirthCities.count > 0 {
                        self.birthCities = tempBirthCities
                    } else {
                        if textField.text?.count == 0 {
                            self.birthCities = CityServices.allCityList()
                        } else {
                            self.birthCities = tempBirthCities
                        }
                    }
                case 5:
                    self.highSchools = HighSchoolServices.allHighSchoolList()
                    var tempHighSchools = [HighSchoolServices]()
                    for item in self.highSchools {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempHighSchools.append(item)
                        }
                    }
                    
                    print(tempHighSchools)
                    
                    if tempHighSchools.count > 0 {
                        self.highSchools = tempHighSchools
                    } else {
                        if textField.text?.count == 0 {
                            self.highSchools = HighSchoolServices.allHighSchoolList()
                        } else {
                            self.highSchools = tempHighSchools
                        }
                    }
                case 6:
                    self.universities = UniversityServices.allUniversityList()
                    var tempUniversities = [UniversityServices]()
                    for item in self.universities {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempUniversities.append(item)
                        }
                    }
                    
                    print(tempUniversities)
                    
                    if tempUniversities.count > 0 {
                        self.universities = tempUniversities
                    } else {
                        if textField.text?.count == 0 {
                            self.universities = UniversityServices.allUniversityList()
                        } else {
                            self.universities = tempUniversities
                        }
                    }
                case 7:
                    self.departments = DepartmentServices.allDepartmentList()
                    var tempDepartments = [DepartmentServices]()
                    for item in self.departments {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            tempDepartments.append(item)
                        }
                    }
                    
                    print(tempDepartments)
                    
                    if tempDepartments.count > 0 {
                        self.departments = tempDepartments
                    } else {
                        if textField.text?.count == 0 {
                            self.departments = DepartmentServices.allDepartmentList()
                        } else {
                            self.departments = tempDepartments
                        }
                    }
                    
                case 8:
                    self.hgDepartments = DepartmentService.allDepartmentList()
                    var hgTempDepartments = [DepartmentService]()
                    for item in  self.hgDepartments {
                        let name = item.name
                        if name.replacingOccurrences(of: "İ", with: "i").lowercased().contains(textField.text!.lowercased()) {
                            hgTempDepartments.append(item)
                        }
                    }
                    
                    print(hgTempDepartments)
                    
                    if hgTempDepartments.count > 0 {
                        self.hgDepartments = hgTempDepartments
                    } else {
                        if textField.text?.count == 0 {
                            self.hgDepartments = DepartmentService.allDepartmentList()
                        } else {
                            self.hgDepartments = hgTempDepartments
                        }
                    }
                default:
                    LyieLog.mPrint("Default")
                }
                
                
                self.myTableView.reloadData()
            }
        }
        return true
    }
}
