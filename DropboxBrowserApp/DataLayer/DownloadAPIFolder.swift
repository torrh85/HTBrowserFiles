//
//  DownloadAPIFolder.swift
//  DropboxBrowserApp
//
//  Created by HAWER TORRES on 23/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import SwiftyDropbox

struct DownloadAPIFolder: DownloaderContentFolderController {
    var path: String
    
    init(path: String) {
        self.path = path
    }
    
    func listFolder(completion: @escaping ((Result<[File], DropboxError>) -> Void)) {
        guard let authorizedClient = DropboxClientsManager.authorizedClient else { completion(.failure(.unableToDownload)); return }
        
        authorizedClient.files.listFolder(path: path).response { response, error in
            guard error == nil else { completion(.failure(.unableToDownload)); return }
            guard let result = response else { completion(.failure(.unableToDownload)); return }
            let results = result.entries.map { File(name: $0.name, pathLower: $0.pathLower, isFolder: $0 is Files.FolderMetadata) }
            completion(.success(results))
        }
    }
}
