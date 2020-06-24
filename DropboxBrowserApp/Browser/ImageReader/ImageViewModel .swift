//
//  ImageViewModel .swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 22/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import Foundation
import SwiftyDropbox
import RxSwift

struct ImageViewModel {
    let file: File
    
    public var image: Observable<Data> {
        return viewSubject
    }
    
    private let viewSubject = BehaviorSubject<Data>(value: Data())
    
    func fetchImage() {
        DownloadAPIFile(path: file.pathLower ?? "").downloadContent { result in
            switch result {
            case .success(let data): self.viewSubject.onNext(data)
            case .failure(let error): print("\(error.localizedDescription). \(#file) \(#line)")
            }
        }
    }
}
