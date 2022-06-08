//
//  DownloadView.swift
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

struct DownloadView: View {
    
    @State var downloadOffSet : CGFloat = 0
    @State var downloadingOffSet : CGFloat = -height
    @State var downloadedOffSet : CGFloat = (-height * 2)
    
    @State var progress : CGFloat = 0
    
    @StateObject var downloader = Downloader()
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            DownloadStateView(state: .downloaded, isLight: true)
                .offset(y: downloadedOffSet)
                .environmentObject(downloader)
            DownloadStateView(state: .downloading, isLight: true)
                .offset(y: downloadingOffSet)
                .environmentObject(downloader)
            DownloadStateView(state: .download)
                .offset(y: downloadOffSet)
                .environmentObject(downloader)
            
            ZStack {
                getDownloadIconView().scaleEffect(0.9)
            }.offset(x: -width / 3.5)
            
            
            
        }
        .mask (
            RoundedRectangle(cornerRadius: 12)
                .frame(width: width, height: height)
        )
        .onTapGesture {
            if self.downloader.currentState == .download {
                startDownload()
            }
        }
        .frame(width: width, height: height)
        .shadow(color: Color.background.opacity(0.4), radius: 10)
    }
    
    
    func startDownload() {
        
        self.downloader.currentState = .downloading
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            self.downloadedOffSet = -height
            self.downloadOffSet = height
            self.downloadingOffSet = 0
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            updateProgress()
        }
        
    }
    
    
    func updateProgress() {
        
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if progress > 1 {
                progress = 1
                timer.invalidate()
                downloadCompleted()
            }
            progress += 0.04
        }
        
        
    }
    
    func downloadCompleted() {
        self.downloader.currentState = .downloaded
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            self.downloadingOffSet = height
            self.downloadedOffSet = 0
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
            reset()
        }
    }
    
    
    func reset() {
        
        self.downloadOffSet = -height
        self.progress = 0
        
        withAnimation(Animation.easeOut(duration: animationDuration)) {
            self.downloader.currentState = .download
            self.downloadOffSet = 0
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.downloadingOffSet = -height
            self.downloadedOffSet = -(height * 2)
        }
    }
    
    
    @ViewBuilder func getDownloadIconView() -> some View {
        
        if (downloader.currentState == .download) {
            DownloadIndicatorView(needAnimation: false)
                .foregroundColor(.background)
        }else if (downloader.currentState == .downloading) {
            DownloadIndicatorView()
                .offset(x: -16)
        }else{
            TickShape()
                .trim(from: 0, to: self.progress == 1 ? 0 : 1)
                .stroke(style: StrokeStyle(lineWidth: 5.5, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .scaleEffect(0.6)
                .opacity(self.downloader.currentState == .downloaded ? 1 : 0)
                .frame(width: 44, height: 44)
                .animation(Animation.easeOut(duration: animationDuration * 2).delay(self.downloader.currentState == .downloaded ? animationDuration / 4 : 0))
        }
        
    }
    
    
    
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
            .preferredColorScheme(.dark)
    }
}
