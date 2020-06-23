//
//  PDFReaderView.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 22/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import RxSwift
import Foundation
import UIKit
import PDFKit

class PDFReaderView: BaseView {
    private let viewModel: PDFReaderViewModel
    private let disposeBag = DisposeBag()
    
    let pdfView: PDFView = {
       let pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        
        pdfView.autoresizesSubviews = true
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        pdfView.displayDirection = .vertical
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displaysPageBreaks = true
        pdfView.maxScaleFactor = 4.0
        pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
        
        return pdfView
    }()
    
    init(frame: CGRect = .zero, viewModel: PDFReaderViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        setupPDFView()
        subscribe(to: viewModel.data)
    }
    
    func setupPDFView() {
        self.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func subscribe(to observable: Observable<Data>) {
        observable.subscribe { [weak self] data in
            guard let strongSelf = self else { return }
            guard let element = data.element else { return }
            guard let document = PDFDocument(data: element) else { return }
            strongSelf.pdfView.document = document
        }.disposed(by: disposeBag)
    }
}
