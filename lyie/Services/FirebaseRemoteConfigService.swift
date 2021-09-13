//
//  FirebaseRemoteConfigService.swift
//  lyie
//
//  Created by Sevcan Eşim on 21.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import Firebase
import FirebaseRemoteConfig

enum RemoteConfigParameters: String {
    case store_url
    case current_version
    case update_desc
}

enum AppUpdateStatus: String {
    case forceUpdate
    case noUpdate
}

final class FirebaseRemoteConfigService {
    static let shared = FirebaseRemoteConfigService()
    var remoteConfig = RemoteConfig.remoteConfig()
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
//    var updateDesc: String = .localized(.forceUpdateDesc)
    var updateDesc: String = ""
    
    func configure() {
        let defaultValues = [
            RemoteConfigParameters.store_url.rawValue: "https://apps.apple.com/tr/app/vfit/id1491459940?l=tr" as NSObject,
            RemoteConfigParameters.current_version.rawValue: (appVersion ?? "1.0.0") as NSObject,
            RemoteConfigParameters.update_desc: updateDesc as NSObject
            ] as [AnyHashable : NSObject]
        remoteConfig.setDefaults(defaultValues as? [String : NSObject])
        fetchRemoteConfig()
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
        guard error == nil else { return }
        print("Got the value from Remote Config!")
            self.remoteConfig.activate(completion: nil)
        }
    }
    
    func getRemoteConfigParameters() -> [String: String?] {
        let storeUrl = remoteConfig.configValue(forKey: RemoteConfigParameters.store_url.rawValue).stringValue
        let currentVersion = remoteConfig.configValue(forKey: RemoteConfigParameters.current_version.rawValue).stringValue
//        let updateDesc = remoteConfig.configValue(forKey: .localized(.updateDescFromRemote)).stringValue
        let updateDesc = remoteConfig.configValue(forKey: "").stringValue
        
        let dict = [
            RemoteConfigParameters.store_url.rawValue: storeUrl,
            RemoteConfigParameters.current_version.rawValue: currentVersion,
            RemoteConfigParameters.update_desc.rawValue: updateDesc
        ]
        
        return dict
    }
    
    func checkAnyAppUpdates() -> AppUpdateStatus {
        let remoteConfigParameters = getRemoteConfigParameters()
        let currentVersion = appVersion ?? ""
        let appStoreVersion = (remoteConfigParameters[RemoteConfigParameters.current_version.rawValue] ?? "") ?? ""
        let storeVsAppVersion = FirebaseRemoteConfigService.compareVersions(version1: appStoreVersion, version2: currentVersion)
        
        if storeVsAppVersion == .version1Greater {
            return .forceUpdate
        } else {
            return .noUpdate
        }
    }
    
    enum VersionCompareResult: String {
        case versionsEqual
        case version1Greater
        case version2Greater
    }
    
    static func compareVersions(version1: String, version2: String) -> VersionCompareResult {
        let result = version1.compare(version2, options: .numeric)
        switch result {
        case .orderedSame : return .versionsEqual
        case .orderedAscending : return .version2Greater
        case .orderedDescending : return .version1Greater
        }
    }
    
}
