//
//  NetworkingModule.swift
//  lyie
//
//  Created by Sevcan Eşim on 19.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation
import Alamofire
import UIKit
import KRProgressHUD

//New Layer for custom generic actions
class NetworkingModule {
    
    /*
     Makes request to the parametered router,makes generic huds and errors to display returning completion handler
     ///
     - Parameters:
     - router:               The `router` sent to the server.
     - viewController:       The `UIViewController` for KRProgressHUD & AlertModalAPI .
     - completion:           The `DataResponse<String,AFError>` returns it..
     */
    func request(router: APIRouter, baseView: BaseView, viewController: UIViewController, completion: @escaping(_ response: DataResponse<String,AFError>) -> Void) {
        ///Control Internet State
        switch NetworkState.isConnected() {
        
        case true:
            ///Display Layout Loading
            KRProgressHUD.show()
            
            ///Request with router
            AF.request(router)
                .validate()
                .responseString(encoding:String.Encoding.utf8){ response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        KRProgressHUD.dismiss()
                    case .failure:
                        baseView.onError(errorMessage: "")
                        KRProgressHUD.dismiss()
//                        AlertModelAPI.showProcessAlert(model: ProcessModel(alertIcon: "popup/connectionFailed", alertTitle: .localized(.error), alertDescription: .localized(.error_occured)), vc: viewController, tapGestureDismissal: true)
                    }
                    completion(response)
                }
        case false:
            ///On Internet error occured
            baseView.onInternetError()
//            AlertModelAPI.showProcessAlert(model: ProcessModel(alertIcon: "popup/connectionFailed", alertTitle: .localized(.error), alertDescription: .localized(.internet_connection)), vc: viewController, tapGestureDismissal: true)
        }
    }
}
