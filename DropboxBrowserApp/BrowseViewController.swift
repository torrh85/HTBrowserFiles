//
//  RootViewController.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 21/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import RxSwift

class BrowseViewController: UINavigationController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: BrowseViewModel
    
    init(fileListViewController: FileListViewController, viewModel: BrowseViewModel) {

        self.viewModel = viewModel
        
        super.init(rootViewController: fileListViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe(to: viewModel.path)
    }
    
    @available(*, unavailable, message: "Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      fatalError("Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    }

    @available(*, unavailable, message: "Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder aDecoder: NSCoder) {
      fatalError("Loading nibless view controllers from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    func presentFileBrowser(_ file: File?) {
        let fileListViewModel = FileListViewModel(viewDelegate: viewModel)
        let listViewController = FileListViewController(viewModel: fileListViewModel, file: file)
        pushViewController(listViewController, animated: true)
    }
    
    func presentImageView(_ file: File) {
        let viewModel = ImageViewModel(file: file)
        let imageViewController = ImageViewContoller(viewModel: viewModel)
        pushViewController(imageViewController, animated: true)
    }
    
    func presentPDFView(_ file: File) {
        let viewModel = PDFReaderViewModel(file: file)
        let pdfViewController = PDFReaderViewController(viewModel: viewModel)
        pushViewController(pdfViewController, animated: true)
    }
    
    func subscribe(to observable: Observable<NavigationBrowserView>) {
        observable.subscribe { [weak self] path in
            guard let strongSelf = self else { return }
            guard let element = path.element else { return }
            strongSelf.present(element)
        }.disposed(by: disposeBag)
    }
    
    func present(_ view: NavigationBrowserView) {
        switch view {
        case .listView(let file):
            presentFileBrowser(file)
        case .imageView(let file):
            presentImageView(file)
        case .pdfView(let file):
            presentPDFView(file)
        }
    }
}
