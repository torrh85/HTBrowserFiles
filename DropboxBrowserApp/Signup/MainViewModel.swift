//
//  MainViewModel.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 20/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import Foundation
import SwiftyDropbox

struct MainViewModel {
    func signUp(){
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: UIApplication.shared.windows.first?.rootViewController,
                                                      openURL: { (url: URL) -> Void in
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                      })
    }
}
