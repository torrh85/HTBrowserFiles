//
//  BrowseViewModel.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 21/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import RxSwift
import UIKit

protocol PresentableViewDelegate {
    func presentView(with file: File)
}

enum NavigationBrowserView {
    case listView(file: File?)
    case imageView(file: File)
    case pdfView(file: File)
}

struct BrowseViewModel {
    public var path: Observable<NavigationBrowserView> {
        return viewSubject
    }
    
    private let viewSubject = BehaviorSubject<NavigationBrowserView>(value: .listView(file: nil))
}

extension BrowseViewModel: PresentableViewDelegate {
    func presentView(with file: File) {
        if file.name.hasSuffix(".jpg") || file.name.hasSuffix(".png") {
            viewSubject.onNext(.imageView(file: file))
        } else if file.name.hasSuffix(".pdf") {
            viewSubject.onNext(.pdfView(file: file))
        } else if file.isFolder {
            viewSubject.onNext(.listView(file: file))
        }
    }
}
