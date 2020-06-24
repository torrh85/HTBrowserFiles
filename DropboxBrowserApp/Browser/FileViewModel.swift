//
//  FileViewModel.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 23/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct FileViewModel {
    let image : BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    
    func downloadThumbnail(file: File) {
        DownloadAPIThumbnail.init(format: .png, size: .w64h64, path: file.pathLower ?? "").downloadContent { result in
            switch result {
            case .success(let data): DispatchQueue.main.async { self.image.accept(UIImage(data: data))};
            case .failure(let error): print("\(error.localizedDescription). \(#file) \(#line)")
            }
        }
    }
}
