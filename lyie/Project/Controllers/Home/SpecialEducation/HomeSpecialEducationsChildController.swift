//
//  HomeSpecialEducationsChildController.swift
//  lyie
//
//  Created by Sevcan Eşim on 24.11.2020.
//

import UIKit

class HomeSpecialEducationsChildController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorCompany: UILabel!
    @IBOutlet weak var titleColor: UIView!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var authorPic: UIImageView!
    @IBOutlet weak var startEducationButton: UIButton!
    @IBOutlet weak var descTitle: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var educationDetailView: UIView!
    @IBOutlet weak var lockView: UIView!
    @IBOutlet weak var lockText: UILabel!
    @IBOutlet weak var lockIcon: UIView!
    
    var index = 0
    var text1: String = ""
//    var alertDelegate: PopupDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }
    
    func warning() {
        self.UI {
            AlertModelAPI.withoutButtonAlert(imageString: "Settings/warning10", title: "Henüz yüklenmedi", desc: "Bölümü tamamlamanız için öncelikli eğitiminizi tamamlayın. ", vc: self)
        }
    }
    
    @IBAction func tappedLockView(_ sender: Any) {
        LyieLog.mPrint("Kilitli")
        warning()
    }
    
    @IBAction func startEducationButtonTapped(_ sender: Any) {
        LyieLog.mPrint("Eğitime Başla")
        warning()
    }
}

//MARK: - HELPER METHODS
extension HomeSpecialEducationsChildController {
    func config() {
//        lockView.isHidden = false
//        lockView.backgroundColor = StyleManager.colors.karartı
//        lockView.alpha = 0.30
//        lockView.isUserInteractionEnabled = false
//
//        text1 = "Bu eğitimler kilitli. 1500 PUAN karşılığında"
//        lockText.attributedText = text1.setAttributedString(changeText: "1500 PUAN", font: UIFont(name: "Klavika-Medium", size: 20)!, color: StyleManager.colors.redText, enableColor: .white)
//        lockText.isHidden = true
        lockIcon.isHidden = false
        lockText.isHidden = true
    }
    
    private func configViews() {
        config()
        mainView.backgroundColor  = StyleManager.colors.backgroundColor
        titleColor.backgroundColor = StyleManager.colors.leftTitleColor
        textTitle.textColor = StyleManager.colors.leftTitleColor
        descTitle.textColor = StyleManager.colors.leftTitleColor
        descLabel.textColor = StyleManager.colors.lineColor
        startEducationButton.backgroundColor = StyleManager.colors.leftTitleColor
        educationDetailView.makeShadow()
        startEducationButton.setTitle("Eğitime Başla", for: .normal)
        switch index {
        case 0:
            backgroundImage.image = UIImage(named: "Home/cover")
            authorPic.image = UIImage(named: "girisimcilik/4")
            authorName.text = "Dr. Umut Yıldız"
            authorCompany.text = "NASA"
            textTitle.text = "ÖZEL EĞİTİMLER"
            descTitle.text = "NASA/JPL-Caltech"
            descLabel.text = "  Avi Loeb ve arkadaşları, bundan 10 yıl önce yıldızlararası bir cismin Pan-STARRS 1 teleskobu ile keşfedilip keşfedilmeyeceğini bir makalede tartışmışlardı. Başka bir yıldız oluşurken meydana gelmiş, sonra onun çekiminden kurtulup yıldızlararası ortamda gezinmeye başlamış bir kaya parçasına denk gelme ihtimalimizi hesapladılar. Ve neticede bu teleskopla böyle bir şey keşfedemeyeceğimiz sonucuna vardılar. \n Yedi yıl sonra ise hesapların ötesinde Oumuamua ile karşılaşıyorlar. Asteroitten yansıyan Güneş ışınlarına bakıldığında her sekiz saatte bir 10 kat değiştiği bulunuyor. Böylece yassı olma ihtimali yüksek oluyor. Temsili resmi kalem gibi çizilmiş olsa da, gelen ışık eğrisini tanımladığımızda kalın yassı bir tepsiyi düşünmek daha doğru olur. Normalde Güneş Sistemi’nde rastladığımız bütün cisimler en fazla patates gibidir, yani eninin boyuna oranı üç katı geçmez. Onun için bu asteroidin dışarıdan gelme olasılığı güç kazanıyor."
            
        case 1:
            backgroundImage.image = UIImage(named: "Home/cover")
            authorPic.image = UIImage(named: "girisimcilik/4")
            authorName.text = "Dr. Umut Yıldız"
            authorCompany.text = "NASA"
            textTitle.text = "ÖZEL EĞİTİMLER"
            descTitle.text = "NASA/JPL-Caltech"
            descLabel.text = "  Avi Loeb ve arkadaşları, bundan 10 yıl önce yıldızlararası bir cismin Pan-STARRS 1 teleskobu ile keşfedilip keşfedilmeyeceğini bir makalede tartışmışlardı. Başka bir yıldız oluşurken meydana gelmiş, sonra onun çekiminden kurtulup yıldızlararası ortamda gezinmeye başlamış bir kaya parçasına denk gelme ihtimalimizi hesapladılar. Ve neticede bu teleskopla böyle bir şey keşfedemeyeceğimiz sonucuna vardılar. \n  Yedi yıl sonra ise hesapların ötesinde Oumuamua ile karşılaşıyorlar. Asteroitten yansıyan Güneş ışınlarına bakıldığında her sekiz saatte bir 10 kat değiştiği bulunuyor. Böylece yassı olma ihtimali yüksek oluyor. Temsili resmi kalem gibi çizilmiş olsa da, gelen ışık eğrisini tanımladığımızda kalın yassı bir tepsiyi düşünmek daha doğru olur. Normalde Güneş Sistemi’nde rastladığımız bütün cisimler en fazla patates gibidir, yani eninin boyuna oranı üç katı geçmez. Onun için bu asteroidin dışarıdan gelme olasılığı güç kazanıyor."
        case 2:
            backgroundImage.image = UIImage(named: "Home/cover")
            authorPic.image = UIImage(named: "girisimcilik/4")
            authorName.text = "Dr. Umut Yıldız"
            authorCompany.text = "NASA"
            textTitle.text = "ÖZEL EĞİTİMLER"
            descTitle.text = "NASA/JPL-Caltech"
            descLabel.text = "  Avi Loeb ve arkadaşları, bundan 10 yıl önce yıldızlararası bir cismin Pan-STARRS 1 teleskobu ile keşfedilip keşfedilmeyeceğini bir makalede tartışmışlardı. Başka bir yıldız oluşurken meydana gelmiş, sonra onun çekiminden kurtulup yıldızlararası ortamda gezinmeye başlamış bir kaya parçasına denk gelme ihtimalimizi hesapladılar. Ve neticede bu teleskopla böyle bir şey keşfedemeyeceğimiz sonucuna vardılar. \n Yedi yıl sonra ise hesapların ötesinde Oumuamua ile karşılaşıyorlar. Asteroitten yansıyan Güneş ışınlarına bakıldığında her sekiz saatte bir 10 kat değiştiği bulunuyor. Böylece yassı olma ihtimali yüksek oluyor. Temsili resmi kalem gibi çizilmiş olsa da, gelen ışık eğrisini tanımladığımızda kalın yassı bir tepsiyi düşünmek daha doğru olur. Normalde Güneş Sistemi’nde rastladığımız bütün cisimler en fazla patates gibidir, yani eninin boyuna oranı üç katı geçmez. Onun için bu asteroidin dışarıdan gelme olasılığı güç kazanıyor."
        default:
            LyieLog.mPrint("default")
        }
    }
    
}
