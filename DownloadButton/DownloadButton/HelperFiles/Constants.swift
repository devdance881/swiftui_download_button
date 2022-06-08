//
//  Constants.swift
//  DownloadButton
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation
import UIKit
import SwiftUI


let width : CGFloat = 320
let height : CGFloat = 70
let animationDuration: TimeInterval = 0.35



enum DownloadState {
    
    case download
    case downloading
    case downloaded
    
    func getStateTitle() -> String {
        switch self {
        case .download:
            return "Download"
        case .downloading:
            return "Downloading"
        case .downloaded:
            return "Downloaded"
        }
    }
    
    func getBackgroundColor() -> Color {
        switch self {
        case .download:
            return Color.label
        case .downloading:
            return Color.downloading
        case .downloaded:
            return Color.downloaded
        }
    }
    
    func getOffSetForText() -> CGFloat {
        
        switch self {
        case .download:
            return 0
        case .downloading:
            return 10
        case .downloaded:
            return 0
        }
        
    }
    
}
