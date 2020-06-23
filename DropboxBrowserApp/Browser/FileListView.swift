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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        return tableView
    }()

    init(frame: CGRect = .zero, viewModel: FileListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        [tableView].forEach(addSubview)
        
        setupBinding()
        selectedBinding()
    }
    
    let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
           let fileManager = FileManager.default
           let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
           let UUID = Foundation.UUID().uuidString
           let pathComponent = "\(UUID)-\(response.suggestedFilename!)"
           
           return directoryURL.appendingPathComponent(pathComponent)
       }

    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    func setupBinding() {
        self.viewModel.files.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { index, file, cell in
            cell.textLabel?.text = file.name
            if file.isFolder {
                cell.imageView?.image = UIImage(imageLiteralResourceName: "folder")
            } else if file.name.hasSuffix(".png") {
                DownloadAPIThumbnail(format: .png, size: .w64h64, destination: self.destination, path: file.pathLower ?? "").downloadContent { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data): cell.imageView?.image = UIImage(data: data)
                        case .failure(let error): print("\(error.localizedDescription). \(#file) \(#line)")
                        }
                    }
                }
            }
            
        }.disposed(by: disposeBag)
    }
    
    func selectedBinding() {
        tableView.rx.modelSelected(File.self).subscribe({ file in
            guard let element = file.element else { return }
            self.viewModel.presentView(with: element)
        }).disposed(by: disposeBag)
    }
}
