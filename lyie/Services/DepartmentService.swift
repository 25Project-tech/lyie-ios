//
//  DepartmentService.swift
//  lyie
//
//  Created by Sevcan Eşim on 1.05.2021.
//

import Foundation
import UIKit

struct DepartmentService {
    var id: Int
    var name: String
    
    static func allDepartmentList() -> [DepartmentService] {
        return [DepartmentService(id:0, name:"Ağ İşletmenliği ve Siber Güvenlik"),
                DepartmentService(id:1, name:"Animatörlük"),
                DepartmentService(id:2, name:"Asansör Sistemleri"),
                DepartmentService(id:3, name:"Baskı Öncesi"),
                DepartmentService(id:4, name:"Bilgisayar Destekli Endüstriyel Modelleme"),
                DepartmentService(id:5, name:"Bilgisayar Destekli Makine Ressamlığı"),
                DepartmentService(id:6, name:"Bilgisayarlı Makine İmalatı"),
                DepartmentService(id:7, name:"Büro Yönetimi ve Yönetici Asistanlığı"),
                DepartmentService(id:8, name:"Değirmencilik"),
                DepartmentService(id:9, name:"Dekoratif El Sanatları"),
                DepartmentService(id:10, name:"Dekoratif Ev Tekstili"),
                DepartmentService(id:11, name:"Dış Ticaret"),
                DepartmentService(id:12, name:"Dokuma Üretim Teknolojisi"),
                DepartmentService(id:13, name:"Döküm"),
                DepartmentService(id:14, name:"Ebe Yardımcılığı"),
                DepartmentService(id:15, name:"Elektrik Tesisatları ve Dağıtımı"),
                DepartmentService(id:16, name:"Elektrikli Cihazlar Teknik Servisi"),
                DepartmentService(id:17, name:"Elektronik ve Haberleşme"),
                DepartmentService(id:18, name:"Endüstriyel Bakım Onarım"),
                DepartmentService(id:19, name:"Endüstriyel Kalıp"),
                DepartmentService(id:20, name:"Endüstriyel Otomasyon Teknolojileri"),
                DepartmentService(id:21, name:"Endüstriyel Ürünler Tasarımı"),
                DepartmentService(id:22, name:"Erken Çocukluk ve Özel Eğitim"),
                DepartmentService(id:23, name:"Fizyolojik Sinyal"),
                DepartmentService(id:24, name:"İzleme Teşhis ve Kayıt Cihazları"),
                DepartmentService(id:25, name:"Fotoğraf"),
                DepartmentService(id:26, name:"Gazetecilik"),
                DepartmentService(id:27, name:"Donatım"),
                DepartmentService(id:28, name:"Gemi Elektroniği ve Haberleşme"),
                DepartmentService(id:29, name:"Gemi İnşa"),
                DepartmentService(id:30, name:"Gemi Makineleri İşletme"),
                DepartmentService(id:31, name:"Gıda Teknolojisi"),
                DepartmentService(id:32, name:"Giysi Kalıp Tasarımı ve Üretimi"),
                DepartmentService(id:33, name:"Güverte İşletme"),
                DepartmentService(id:34, name:"Güzellik Hizmetleri"),
                DepartmentService(id:35, name:"Halkla İlişkiler"),
                DepartmentService(id:36, name:"Harita Kadastro"),
                DepartmentService(id:37, name:"Hasta ve Yaşlı Bakımı"),
                DepartmentService(id:38, name:"Hayvan Yetiştiriciliği ve Sağlığı"),
                DepartmentService(id:39, name:"Hemşire Yardımcılığı"),
                DepartmentService(id:40, name:"İnfaz ve Koruma"),
                DepartmentService(id:41, name:"İnşaat Altyapı"),
                DepartmentService(id:42, name:"İnşaat Üstyapı"),
                DepartmentService(id:43, name:"İplik Üretim Teknolojisi"),
                DepartmentService(id:44, name:"İş Makineleri"),
                DepartmentService(id:45, name:"İtfaiyecilik ve Yangın Güvenliği"),
                DepartmentService(id:46, name:"İzabe"),
                DepartmentService(id:47, name:"Kaynakçılık"),
                DepartmentService(id:48, name:"Kimya Laboratuvarı"),
                DepartmentService(id:49, name:"Konaklama"),
                DepartmentService(id:50, name:"Lojistik"),
                DepartmentService(id:51, name:"Madencilik"),
                DepartmentService(id:52, name:"Makine Bakım Onarım"),
                DepartmentService(id:53, name:"Mimari Yapı"),
                DepartmentService(id:54, name:"Teknik Ressamlığı"),
                DepartmentService(id:55, name:"Mobilya İç Mekân Ressamlığı"),
                DepartmentService(id:56, name:"Muhasebe"),
                DepartmentService(id:57, name:"Ofset Baskı Sistemleri"),
                DepartmentService(id:58, name:"Otomotiv Boya"),
                DepartmentService(id:59, name:"Otomotiv Elektromekanik"),
                DepartmentService(id:60, name:"Otomotiv Gövde"),
                DepartmentService(id:61, name:"Örme Üretim Teknolojisi"),
                DepartmentService(id:62, name:"Petrol Endüstrisi"),
                DepartmentService(id:63, name:"Plastik Sanatlar"),
                DepartmentService(id:64, name:"Plastik Teknolojisi"),
                DepartmentService(id:65, name:"Proses"),
                DepartmentService(id:66, name:"Radyo-Televizyon"),
                DepartmentService(id:67, name:"Raylı Sistem Araçları"),
                DepartmentService(id:68, name:"Raylı Sistemler Elektrik-Elektronik"),
                DepartmentService(id:69, name:"Raylı Sistemler Yol"),
                DepartmentService(id:70, name:"Sağlık Bakım Teknisyenliği"),
                DepartmentService(id:71, name:"Satış Danışmanlığı"),
                DepartmentService(id:72, name:"Savunma Elektronik Sistemleri"),
                DepartmentService(id:73, name:"Savunma Mekanik Sistemleri"),
                DepartmentService(id:74, name:"Seyahat Acenteciliği"),
                DepartmentService(id:75, name:"Sigortacılık"),
                DepartmentService(id:76, name:"Sivil Havacılık"),
                DepartmentService(id:77, name:"Soğutma ve İklimlendirme Sistemleri"),
                DepartmentService(id:78, name:"Sosyal Destek Hizmetleri"),
                DepartmentService(id:79, name:"Statik Yapı Teknik Ressamlığı"),
                DepartmentService(id:80, name:"Tapu"),
                DepartmentService(id:81, name:"Tarım"),
                DepartmentService(id:82, name:"Tekstil Baskı ve Desenciliği"),
                DepartmentService(id:83, name:"Tekstil Boya Apre ve Laborantlığı"),
                DepartmentService(id:84, name:"erzilik"),
                DepartmentService(id:85, name:"Tesisat ve Enerji Sistemleri"),
                DepartmentService(id:86, name:"Tıbbi Cihaz Üretimi"),
                DepartmentService(id:87, name:"Tıbbi Görüntüleme Sistemleri"),
                DepartmentService(id:88, name:"Tıbbi Laboratuvar ve Hasta Dışı Uygulama Cihazları"),
                DepartmentService(id:89, name:"Tüketici Hizmetleri"),
                DepartmentService(id:90, name:"Uçak Elektroniği"),
                DepartmentService(id:91, name:"Uçak Gövde-Motor"),
                DepartmentService(id:92, name:"Yapı Yüzey Kaplama ve Yalıtım"),
                DepartmentService(id:93, name:"Yaşam Destek ve Tedavi Cihazları"),
                DepartmentService(id:94, name:"Yat İnşa"),
                DepartmentService(id:95, name:"Yazılım Geliştirme"),
                DepartmentService(id:96, name:"Yenilenebilir Enerji Teknolojileri"),
                DepartmentService(id:97, name:"Yiyecek İçecek Hizmetleri"),
                DepartmentService(id:100, name:"Zabıt Kâtipliği"),
                DepartmentService(id:101, name:"Sayısal"),
                DepartmentService(id:102, name:"Sözel"),
                DepartmentService(id:103, name:"Eşit Ağırlık"),
                DepartmentService(id:104, name:"Yabancı Dil"),
                DepartmentService(id:105, name:"Elektrikli Araçlar"),
        ]
    }
        
    static func getName(by id: Int) -> String {
        switch id {
        default:
            return DepartmentService.allDepartmentList()[id].name
        }
    }
    
}
