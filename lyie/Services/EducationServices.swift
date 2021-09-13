//
//  EducationServices.swift
//  lyie
//
//  Created by Sevcan Eşim on 30.01.2021.
//

import Foundation
import UIKit

struct EducationServices {
    var id: Int // Kurs ID
    var mainEducation: EducationStep // IOT-INO-AI 3->
    var mainEducationValue: Int  // 101-201-301
    var mainEducationCellNum: Int //101İN KAÇINCI bölümü oldugu 3 ün içindeki
    var childCellNum: Int // EducationMainLessons ()
    var title: String //
    var descText: String
    var imageString: String
    var typeName: String //skayt-completed /queestion
    var cellHeight: CGFloat //650.0
    var navigate: Bool
//    var navigateChildID: [ChildEducationServices]
    var navigateCount: Int  //Slayt Cell ise -> bu slayutın kaç sayfadan oluştuğpu
    var childId: Int // Slayt Cellerin id si
    var videoUrl: String
    var leftValue: Bool // sorucellerinin sağ -sol değerleri 
    var rightValue: Bool
    var leftText: String
    var rightText: String
    
    static func allEducationList() -> [EducationServices] {
        return [EducationServices(id: 0, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 0, title: "", descText: "", imageString: "Education/image1", typeName: "ImageCell", cellHeight: 650.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 1, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 1, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 0), childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 2, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 2, title: "", descText: "", imageString: "Education/image8", typeName: "ImageCell", cellHeight: 650.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 3, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 3, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 1), childId: 1, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 3, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 3, title: "", descText: "", imageString: "Education/image16", typeName: "ImageCell", cellHeight: 650.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 4, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 4, title: "", descText: "", imageString: "Education/image17", typeName: "ImageCell", cellHeight: 650.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 5, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 5, title: "", descText: "", imageString: "Education/image18", typeName: "ImageCell", cellHeight: 650.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 6, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 6, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 2), childId: 2, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 7, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 7, title: "", descText: "", imageString: "", typeName: "VideoCell", cellHeight: 350.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "https://youtu.be/JaF-fq2Zn7I", leftValue: false, rightValue: false, leftText: "video2", rightText: "mp4"),  EducationServices(id: 8, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 8, title: "Makale", descText: "", imageString: "Education/image21", typeName: "PDFCell", cellHeight: 650.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 9, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 9, title: "Soru", descText: "Sence her yenilik bir inovasyon mudur?", imageString: "", typeName: "QuestionCell", cellHeight: 250.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: true, leftText: "İnovasyondur", rightText: "İnovasyon değildir"), EducationServices(id: 10, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 0, childCellNum: 10, title: "", descText: "", imageString: "", typeName: "CompleteCell", cellHeight: 120.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 11, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 0, title: "Farklı Düşün / Think Different", descText: "Çocukken kurduğumuz hayaller", imageString: "", typeName: "VideoCell", cellHeight: 350.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "https://youtu.be/JaF-fq2Zn7I", leftValue: false, rightValue: false, leftText: "video2", rightText: "mp4"), EducationServices(id: 12, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 1, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 3), childId: 3, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 13, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 2, title: "Soru", descText: "Elektrikli otomobiller ilk kez hangi yılda üretildi?", imageString: "", typeName: "QuestionCell", cellHeight: 250.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: true, rightValue: false, leftText: "1835", rightText: "1920"), EducationServices(id: 14, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 3, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 4), childId: 4, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 15, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 4, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 5), childId: 5, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 16, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 5, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 6), childId: 6, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 17, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 6, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 7), childId: 7, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 18, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 7, title: "", descText: "", imageString: "", typeName: "SlaytCell", cellHeight: 650.0, navigate: false, navigateCount: ChildEducationServices.getPageCount(by: 8), childId: 8, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: ""), EducationServices(id: 19, mainEducation: .inovation, mainEducationValue: 101, mainEducationCellNum: 1, childCellNum: 8, title: "", descText: "", imageString: "", typeName: "CompleteCell", cellHeight: 120.0, navigate: false, navigateCount: 0, childId: 0, videoUrl: "", leftValue: false, rightValue: false, leftText: "", rightText: "")]
    }
    
    static func getList(by education: String, mainEduValue: Int, mainEducationCellNum: Int) -> [EducationServices] {
        switch education {
        default:
            return EducationServices.allEducationList().filter({ $0.mainEducation == EducationStep(rawValue: education) }).filter({ $0.mainEducationValue == mainEduValue}).filter({ $0.mainEducationCellNum == mainEducationCellNum})
        }
    }
    
    static func getMainList(by education: String, mainEduValue: Int) -> [EducationServices] {
        switch education {
        default:
            return EducationServices.allEducationList().filter({ $0.mainEducation == EducationStep(rawValue: education) }).filter({ $0.mainEducationValue == mainEduValue})
        }
    }
    
        
        
}
