//
//  DownloadIndicatorView.swift
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

struct DownloadIndicatorView: View {
    
    @State var downloadSymbolOffSet : CGFloat = 0
    let size : CGFloat = 40
    var needAnimation: Bool = true
    @State var pct : Double = 0.0
    let animationDuration : TimeInterval = 1.5
    
    var body: some View {
        
        ZStack {
            getCircleView()
        }.onAppear {
            withAnimation(Animation.linear(duration: animationDuration).repeatForever(autoreverses: false)) {
                    self.pct = 1.0
            }
        }
        
    }
    
    @ViewBuilder func getCircleView() -> some View {
        
        if needAnimation {
            InnerCircle(pct: pct)
                .stroke(Color.white, lineWidth: 4)
                .frame(width: size, height: size)
                .shadow(color: Color.label.opacity(0.24), radius: 4, y: 2)
        }else{
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 4))
                .frame(width: size, height: size)
                .shadow(color: Color.label.opacity(0.24), radius: 4, y: 2)
            Image(systemName: "arrow.down")
                .font(.system(size: 20, weight: .heavy))
                .offset(y: downloadSymbolOffSet)
                .mask(Circle().frame(width: size, height: size))
        }
    }
    
}

struct InnerCircle : Shape {
    
    var lagAmount = 0.35
    var pct : Double
    
    func path(in rect: CGRect) -> Path {
        
        let end = pct * 360
        var start: Double
        
        if pct > (1 - lagAmount) {
            start = 360 * (2 * pct - 1.0)
        } else if pct > lagAmount {
            start = 360 * (pct - lagAmount)
        }else{
            start = 0
        }
        
        
        var p = Path()
        
        p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2), radius: rect.size.width/2,
                 startAngle: Angle(degrees: start),
                 endAngle: Angle(degrees: end),
                 clockwise: false)
        
        return p
    }
    
    var animatableData: Double {
        get {return pct}
        set {pct = newValue}
    }
    
}


struct DownloadIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadIndicatorView()
    }
}
