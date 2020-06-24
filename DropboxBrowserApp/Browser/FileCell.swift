//
//  FileCell.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 23/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import RxSwift

class FileCell: UITableViewCell  {
    var viewModel: FileViewModel = FileViewModel()
    var disposeBag: DisposeBag = DisposeBag()
    
    let fileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let fileTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFileImage()
        setupFileTitle()
        viewModel.image.bind(to: fileImage.rx.image).disposed(by: disposeBag)
    }
    
    func setupFileImage() {
        addSubview(fileImage)
        
        NSLayoutConstraint.activate(
            [fileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
             fileImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
             fileImage.heightAnchor.constraint(equalToConstant: 45),
             fileImage.widthAnchor.constraint(equalToConstant: 45)])
    }
    
    func setupFileTitle() {
        addSubview(fileTitle)
        
        NSLayoutConstraint.activate(
            [fileTitle.leadingAnchor.constraint(equalTo: fileImage.trailingAnchor, constant: 12),
             fileTitle.centerYAnchor.constraint(equalTo: fileImage.centerYAnchor),
             fileTitle.heightAnchor.constraint(equalToConstant: 12)])
    }
    
    func setupCell(model: File) {
        selectionStyle = .none
        fileImage.image = model.isFolder ? UIImage(named: "folder") : UIImage(named: "placeholder")
        fileTitle.text = model.name
        
        self.viewModel.downloadThumbnail(file: model)
    }
}
