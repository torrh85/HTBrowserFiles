//
//  ImageViewController.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 22/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import SwiftyDropbox
import RxSwift

class ImageViewContoller: BaseViewController {
    
    let viewModel: ImageViewModel
    
    init(viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init()
        
        self.viewModel.fetchImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = ImageContentView(viewModel: viewModel)
    }
}
