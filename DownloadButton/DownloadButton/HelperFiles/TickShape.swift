//
//  TickShape.swift
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

import SwiftUI

struct TickShape: Shape {
    
    var circleSize : CGFloat = 60
    var scaleFactor : CGFloat = 0.3
    
    func path(in rect: CGRect) -> Path {
        let circleX = rect.midX
        let circleY = rect.midY
        
        
        var p = Path()
        p.move(to: CGPoint(x: circleX, y: circleY))
        
        p.addEllipse(in: CGRect(x: circleX - (circleSize / 2), y: circleY - (circleSize / 2), width: circleSize, height: circleSize))
        
        p.move(to: CGPoint(x: circleX - (38 * scaleFactor), y: (circleY + 2) - scaleFactor))
        p.addLine(to: CGPoint(x: circleX - (scaleFactor * 18), y: circleY + (scaleFactor * 28)))
        p.addLine(to: CGPoint(x: circleX + (scaleFactor * 40), y: circleY - (scaleFactor * 26)))
        return p
    }
    
}

struct TickShape_Previews: PreviewProvider {
    static var previews: some View {
        TickShape()
    }
}
