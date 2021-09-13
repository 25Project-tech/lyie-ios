//
//  CityServices.swift
//  lyie
//
//  Created by Sevcan Eşim on 9.01.2021.
//

import Foundation
import UIKit

struct CityServices {
    var id: Int
    var name: String
    var licensePlateId: Int
    
    static func allCityList() -> [CityServices] {
        return [CityServices(id: 0, name: "Adana", licensePlateId: 1),
                CityServices(id: 1, name: "Adıyaman", licensePlateId: 2),
                CityServices(id: 2, name: "Afyon", licensePlateId: 3),
                CityServices(id: 3, name: "Ağrı", licensePlateId: 4),
                CityServices(id: 4, name: "Amasya", licensePlateId: 5),
                CityServices(id: 5, name: "Ankara", licensePlateId: 6),
                CityServices(id: 6, name: "Antalya", licensePlateId: 7),
                CityServices(id: 7, name: "Artvin", licensePlateId: 8),
                CityServices(id: 8, name: "Aydın", licensePlateId: 9),
                CityServices(id: 9, name: "Balıkesir", licensePlateId: 10),
                CityServices(id: 10, name: "Bilecik", licensePlateId: 11),
                CityServices(id: 11, name: "Bingöl", licensePlateId: 12),
                CityServices(id: 12, name: "Bitlis", licensePlateId: 13),
                CityServices(id: 13, name: "Bolu", licensePlateId: 14),
                CityServices(id: 14, name: "Burdur", licensePlateId: 15),
                CityServices(id: 15, name: "Bursa", licensePlateId: 16),
                CityServices(id: 16, name: "Çanakkale", licensePlateId: 17),
                CityServices(id: 17, name: "Çankırı", licensePlateId: 18),
                CityServices(id: 18, name: "Çorum", licensePlateId: 19),
                CityServices(id: 19, name: "Denizli", licensePlateId: 20),
                CityServices(id: 20, name: "Diyarbakır", licensePlateId: 21),
                CityServices(id: 21, name: "Edirne", licensePlateId: 22),
                CityServices(id: 22, name: "Elazığ", licensePlateId: 23),
                CityServices(id: 23, name: "Erzincan", licensePlateId: 24),
                CityServices(id: 24, name: "Erzurum", licensePlateId: 25),
                CityServices(id: 25, name: "Eskişehir", licensePlateId: 26),
                CityServices(id: 26, name: "Gaziantep", licensePlateId: 27),
                CityServices(id: 27, name: "Giresun", licensePlateId: 28),
                CityServices(id: 28, name: "Gümüşhane", licensePlateId: 29),
                CityServices(id: 29, name: "Hakkari", licensePlateId: 30),
                CityServices(id: 30, name: "Hatay", licensePlateId: 31),
                CityServices(id: 31, name: "Isparta", licensePlateId: 32),
                CityServices(id: 32, name: "Mersin", licensePlateId: 33),
                CityServices(id: 33, name: "İstanbul", licensePlateId: 34),
                CityServices(id: 34, name: "İzmir", licensePlateId: 35),
                CityServices(id: 35, name: "Kars", licensePlateId: 36),
                CityServices(id: 36, name: "Kastamonu", licensePlateId: 37),
                CityServices(id: 37, name: "Kayseri", licensePlateId: 38),
                CityServices(id: 38, name: "Kırklareli", licensePlateId: 39),
                CityServices(id: 39, name: "Kırşehir", licensePlateId: 40),
                CityServices(id: 40, name: "Kocaeli", licensePlateId: 41),
                CityServices(id: 41, name: "Konya", licensePlateId: 42),
                CityServices(id: 42, name: "Kütahya", licensePlateId: 43),
                CityServices(id: 43, name: "Malatya", licensePlateId: 44),
                CityServices(id: 44, name: "Manisa", licensePlateId: 45),
                CityServices(id: 45, name: "Kahramanmaraş", licensePlateId: 46),
                CityServices(id: 46, name: "Mardin", licensePlateId: 47),
                CityServices(id: 47, name: "Muğla", licensePlateId: 48),
                CityServices(id: 48, name: "Muş", licensePlateId: 49),
                CityServices(id: 49, name: "Nevşehir", licensePlateId: 50),
                CityServices(id: 50, name: "Niğde", licensePlateId: 51),
                CityServices(id: 51, name: "Ordu", licensePlateId: 52),
                CityServices(id: 52, name: "Rize", licensePlateId: 53),
                CityServices(id: 53, name: "Sakarya", licensePlateId: 54),
                CityServices(id: 54, name: "Samsun", licensePlateId: 55),
                CityServices(id: 55, name: "Siirt", licensePlateId: 56),
                CityServices(id: 56, name: "Sinop", licensePlateId: 57),
                CityServices(id: 57, name: "Sivas", licensePlateId: 58),
                CityServices(id: 58, name: "Tekirdağ", licensePlateId: 59),
                CityServices(id: 59, name: "Tokat", licensePlateId: 60),
                CityServices(id: 60, name: "Trabzon", licensePlateId: 61),
                CityServices(id: 61, name: "Tunceli", licensePlateId: 62),
                CityServices(id: 62, name: "Şanlıurfa", licensePlateId: 63),
                CityServices(id: 63, name: "Uşak", licensePlateId: 64),
                CityServices(id: 64, name: "Van", licensePlateId: 65),
                CityServices(id: 65, name: "Yozgat", licensePlateId: 66),
                CityServices(id: 66, name: "Zonguldak", licensePlateId: 67),
                CityServices(id: 67, name: "Aksaray", licensePlateId: 68),
                CityServices(id: 68, name: "Bayburt", licensePlateId: 69),
                CityServices(id: 69, name: "Karaman", licensePlateId: 70),
                CityServices(id: 70, name: "Kırıkkale", licensePlateId: 71),
                CityServices(id: 71, name: "Batman", licensePlateId: 72),
                CityServices(id: 72, name: "Şırnak", licensePlateId: 73),
                CityServices(id: 73, name: "Bartın", licensePlateId: 74),
                CityServices(id: 74, name: "Ardahan", licensePlateId: 75),
                CityServices(id: 75, name: "Iğdır", licensePlateId: 76),
                CityServices(id: 76, name: "Yalova", licensePlateId: 77),
                CityServices(id: 77, name: "Karabük", licensePlateId: 78),
                CityServices(id: 78, name: "Kilis", licensePlateId: 79),
                CityServices(id: 79, name: "Osmaniye", licensePlateId: 80),
                CityServices(id: 80, name: "Düzce", licensePlateId: 81)]
    }
    
    static func getName(by id: Int) -> String {
        switch id {
        default:
            return CityServices.allCityList()[id].name
        }
    }
    
    static func getLicensePlateId(by id: Int) -> Int {
        switch id {
        default:
            return CityServices.allCityList()[id].licensePlateId
        }
    }
    
    static func getID(by licensePlateId: Int) -> Int {
        switch licensePlateId {
        default:
            return CityServices.allCityList()[licensePlateId - 1].id
        }
    }
    
    static func getNameWithLicensePlateId(by licensePlateId: Int) -> String {
        switch licensePlateId {
        default:
            return CityServices.allCityList()[licensePlateId - 1].name
        }
    }
}

