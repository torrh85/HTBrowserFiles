//
//  BrowserViewController.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 20/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import RxSwift
import UIKit

class FileListViewController: BaseViewController {
    var viewModel: FileListViewModel
    let disposeBag = DisposeBag()

    init(viewModel: FileListViewModel, file: File?) {
        self.viewModel = viewModel
        
        super.init()
        
        self.title = "File Browser"
        
        viewModel.fetchRootFolder(to: file?.pathLower)
        navigationItem.hidesBackButton = (file == nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = FileListView(viewModel: viewModel)
    }
}
