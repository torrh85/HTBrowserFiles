//
//  BrowseContentView.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 21/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyDropbox

class FileListView: BaseView {
    private let viewModel:FileListViewModel
    
    public var files = PublishSubject<[File]>()
    
    private let disposeBag = DisposeBag()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FileCell.self, forCellReuseIdentifier: "CustomCell")
        
        return tableView
    }()
    
    init(frame: CGRect = .zero, viewModel: FileListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        [tableView].forEach(addSubview)
        
        setupBinding()
        selectedBinding()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    func setupBinding() {
        viewModel.files.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "CustomCell", cellType: FileCell.self)) { index, model, cell in
            cell.setupCell(model: model)
        }.disposed(by: disposeBag)
    }
    
    func selectedBinding() {
        tableView.rx.modelSelected(File.self).subscribe({ file in
            guard let element = file.element else { return }
            self.viewModel.presentView(with: element)
        }).disposed(by: disposeBag)
    }
}
