//
//  File.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/11/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

typealias CompletionBlock = ((_ success: Bool, _ response: [AnyObject], _ error: Error?) -> Void)
typealias ResponseCallBack = ((_ success: Bool, _ response: Any?) -> Void)

let URL_STRING = "https://api.github.com"

