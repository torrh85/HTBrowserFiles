//
//  PDFReaderViewController.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 22/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import SwiftyDropbox
import PDFKit
import RxSwift

class PDFReaderViewController: BaseViewController {
    private let viewModel: PDFReaderViewModel
    
    init(viewModel: PDFReaderViewModel) {
        self.viewModel = viewModel
        super.init()
        
        self.viewModel.fetchPDFFile()
    }
    
    override func loadView() {
        view = PDFReaderView(viewModel: viewModel)
    }
}
