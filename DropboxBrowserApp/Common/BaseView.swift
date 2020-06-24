//
//  BaseView.swift
//  DropboxBrowserApp
//
//  Created by Hawer Alberto Torres Castañeda on 20/06/20.
//  Copyright © 2020 Hawer. All rights reserved.
//

import UIKit

class BaseView: UIView {
    // MARK: - Methods
    public override init(frame: CGRect) {
      super.init(frame: frame)
    }

    @available(*, unavailable,
      message: "Loading view from a nib is unsupported"
    )
    public required init?(coder aDecoder: NSCoder) {
      fatalError("Loading view from a nib is unsupported")
    }
}
