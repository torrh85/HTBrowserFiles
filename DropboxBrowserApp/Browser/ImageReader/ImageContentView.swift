//
//  ImageContentView.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 22/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import RxSwift

class ImageContentView: BaseView {
    
    private let viewModel: ImageViewModel
    private let disposeBag = DisposeBag()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    init(frame: CGRect = .zero, viewModel: ImageViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupImageView()
        subscribe(to: viewModel.image)
    }
    
    func subscribe(to observable: Observable<Data>) {
        observable.subscribe { [weak self] path in
            guard let strongSelf = self else { return }
            guard let element = path.element else { return }
            strongSelf.imageView.image = UIImage(data: element)
        }.disposed(by: disposeBag)
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate(
            [imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
             imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 12),
             imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
             imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)])
    }
}
