//
//  DownloadAPIThumbnail.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 23/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import SwiftyDropbox

struct DownloadAPIThumbnail: DownloaderThumbnailController {
    var format: SwiftyDropbox.Files.ThumbnailFormat
    var size: SwiftyDropbox.Files.ThumbnailSize
    var destination: Destination
    var path: String
    
    func downloadContent(completion: @escaping ((Result<Data, DropboxError>) -> Void)) {
        guard let authorizedClient = DropboxClientsManager.authorizedClient else { return completion(.failure(.unableToDownload)) }
        
        authorizedClient.files.getThumbnail(path: path, format: .png, size: size, destination: destination).response { response, error in
            if let (_, url) = response {
                guard let data = try? Data(contentsOf: url) else { completion(.failure(.unableToDownload)); return}
                completion(.success(data))
            } else {
                completion(.failure(.unableToDownload))
            }
        }
    }
}
