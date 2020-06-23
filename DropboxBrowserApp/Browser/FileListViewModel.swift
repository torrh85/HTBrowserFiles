//
//  BrowserViewModel.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 21/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import SwiftyDropbox
import RxSwift

struct FileListViewModel {
    let title = "Files"
    let client = DropboxClientsManager.authorizedClient
    
    private let viewDelegate: PresentableViewDelegate
    
    init(viewDelegate: PresentableViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    public let files: PublishSubject<[File]> = PublishSubject()
    
    func fetchRootFolder(to path: String?) {
        DownloadAPIFolder(path: path ?? "").listFolder { result in
            switch result {
            case .success(let files): self.files.onNext(files)
            case .failure(let error): print("\(error.localizedDescription). \(#file) \(#line)")
            }
        }
    }
    
    func presentView(with file: File) {
        viewDelegate.presentView(with: file)
    }
}
