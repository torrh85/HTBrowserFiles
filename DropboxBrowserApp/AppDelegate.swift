//
//  AppDelegate.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 19/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import SwiftyDropbox
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainViewController: MainViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DropboxClientsManager.setupWithAppKey("btj29eg8477lhtd")

        let viewModel = MainViewModel()
        mainViewController = MainViewController(viewModel: viewModel)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainViewController

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                let browseViewModel = BrowseViewModel()
                let listViewController = FileListViewController(viewModel: FileListViewModel(viewDelegate: browseViewModel), file: nil)
                let browserViewContoller = BrowseViewController(fileListViewController: listViewController, viewModel: browseViewModel)

                if let mainVC = mainViewController {
                    mainVC.present(viewContoller: browserViewContoller)
                }
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case let .error(_, description):
                print("Error: \(description)")
            }
        }
        return true
    }
}
