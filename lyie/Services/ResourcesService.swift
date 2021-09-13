//
//  ResourcesService.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.04.2021.
//

import Foundation
import UIKit


struct ResourcesService {
    var id: Int
    var bundleText: String
    var bundleDesc: String
    var pdfDesc: String
    
    static func allResourcesList() -> [ResourcesService] {
        return [ResourcesService(id: 0, bundleText: "pdf1", bundleDesc: "pdf", pdfDesc: "İnsan ömrü uzarken dünya nüfusu nasıl dağılıyor ve gelecek yıllarda bu dağılımın nasıl olacağı ön görülüyor?"), ResourcesService(id: 1, bundleText: "pdf2", bundleDesc: "pdf", pdfDesc: "Petrol mü yoksa her saniye başına üretilen onlarca terabayt veriler mi daha önemlidir?"), ResourcesService(id: 2, bundleText: "pdf3", bundleDesc: "pdf", pdfDesc: "Yatırım yapılacak kişilerin büyük bir çoğunluğu Z kuşağına ait bireyler olacağı su götürmez bir gerçektir. Bu doğrultuda hali hazırda internet dünyasında doğan bu neslin yeteneklerinden faydalanmak ve potansiyel ekonomik çıktıya katkı sağlamalarını sağlamak bu alanda yarışan bütün toplumların faydasına olacak bir stratejidir."), ResourcesService(id: 3, bundleText: "pdf4", bundleDesc: "pdf", pdfDesc: "2019 yılında gerçekleşen toplam robotik kurulumların değeri 13,8 milyar dolara ulaşmıştır. Ortaya çıkan bu değer son 6 yıldaki en yüksek ekonomik değere eş değerdir."), ResourcesService(id: 4, bundleText: "pdf5", bundleDesc: "pdf", pdfDesc: "2019 yılında gerçekleşen toplam robotik kurulumların değeri 13,8 milyar dolara ulaşmıştır. Ortaya çıkan bu değer son 6 yıldaki en yüksek ekonomik değere eş değerdir."), ResourcesService(id: 5, bundleText: "pdf6", bundleDesc: "pdf", pdfDesc: "İş süreçlerindeki insan görevlerini yazılımla değiştirmek ve bu yazılımın insan kullanıcılara benzer şekilde otomasyon sistemleriyle iletişime girmesi söylenebilir.")]
    }
    
    static func getList(by id: Int) -> ResourcesService {
        switch id {
        default:
            return ResourcesService.allResourcesList()[id]
        }
    }
    
    static func getBundleText(by id: Int) -> String {
        switch id {
        default:
            return ResourcesService.allResourcesList()[id].bundleText
        }
    }
    
    static func getBundleDesc(by id: Int) -> String {
        switch id {
        default:
            return ResourcesService.allResourcesList()[id].bundleDesc
        }
    }
    
    static func getPDFDesc(by id: Int) -> String {
        switch id {
        default:
            return ResourcesService.allResourcesList()[id].pdfDesc
        }
    }
}
