//
//  DownloadAPIFile.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 23/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import SwiftyDropbox

struct DownloadAPIFile: DownloaderFilesController {
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    func downloadContent(completion: @escaping ((Result<Data, DropboxError>) -> Void)) {
        guard let authorizedClient = DropboxClientsManager.authorizedClient else { return completion(.failure(.unableToDownload)) }
        
            authorizedClient.files.download(path: path).response(completionHandler: { response, error in
            if let (_, data) = response {
                completion(.success(data))
            } else {
                completion(.failure(.unableToDownload))
            }
        })
    }
}
