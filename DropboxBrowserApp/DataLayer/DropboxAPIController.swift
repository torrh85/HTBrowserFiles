//
//  DropboxAPIController.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 22/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import SwiftyDropbox

public typealias Destination = (URL, HTTPURLResponse) -> URL

public enum DropboxError: Error {
    case unableToDownload
}

public protocol DownloaderFilesController {
    var path: String { get }
    func downloadContent(completion: @escaping ((Result<Data, DropboxError>) -> Void))
}

public protocol DownloaderThumbnailController: DownloaderFilesController {
    var format: SwiftyDropbox.Files.ThumbnailFormat { get }
    var size: SwiftyDropbox.Files.ThumbnailSize { get }
    var destination: Destination { get }
}

public protocol DownloaderContentFolderController {
    var path: String { get }
    func listFolder(completion: @escaping ((Result<[File], DropboxError>) -> Void))
}
