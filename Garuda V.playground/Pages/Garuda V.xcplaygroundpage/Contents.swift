/*:
Hi. I'm Jason.
This is Garuda V, a two-stage-to-orbit launch vehicle.
The name of Garuda V is inspired by Garuda and Saturn V.
Garuda is a legendary bird or bird-like creature Hindu, Buddhist and Jain faith, and also the national symbol of Indonesia.
Saturn V  is the launch vehicle that brought the first humans to the Moon.
In this playground, we will see how Garuda V works.
*/

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    
    private let cdPosition = CGPoint(x: 768/8, y: 1024/8)
    
    @State private var bgPosition = CGPoint(x: 768/2, y: K.bgHeight - 1024*5/2)
    @State private var boosterPosition = CGPoint(x: 768/2, y: 1024*23/40)
    @State private var spacecraftPosition = CGPoint(x: 768/2, y: 1024*23/40)
    
    @State private var thrustIndex = 0
    @State private var thrustPosition = CGPoint(x: 768/2, y: 1024*31/40)
    @State private var thurstOpacity = 0.0
    
    @State private var countdown = 110
    @State private var cdOpacity = 1.0
    
    @State private var launchOpacity = 1.0
    
    @State private var soundOn = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            Image(uiImage: K.bgImage)
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 768)
                .position(self.bgPosition)
            Image(uiImage: K.boosterImage)
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .position(self.boosterPosition)
            Image(uiImage: K.spacecraftImage)
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .position(self.spacecraftPosition)
            Image(uiImage: K.thrustImages[thrustIndex])
                .interpolation(.none)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60)
                .opacity(self.thurstOpacity)
                .position(self.thrustPosition)
            Text(String(Int(self.countdown/10)))
                .font(.system(size: 72))
                .foregroundColor(.black)
                .opacity(self.cdOpacity)
                .position(self.cdPosition)
                .onReceive(self.timer) { _ in
                    if self.countdown > 0 {
                        self.countdown -= 1
                    }
                    else {
                        self.cdOpacity = 0.0
                        self.launch()
                        self.animateThrust()
                        if !soundOn {
                            playSound()
                            self.soundOn.toggle()
                        }
                    }
                }
        }
        .frame(width: 768, height: 1024)
        
    }
    
    private func launch() {
        if self.boosterPosition.y >= 1024/2 && self.spacecraftPosition.y >= 1024/2 {
            self.thurstOpacity = 1.0
            withAnimation {
                self.boosterPosition.y -= K.distance
                self.spacecraftPosition.y -= K.distance
                self.thrustPosition.y -= K.distance
            }
            
        }
        else if self.bgPosition.y <= K.bgHeight*64/25 {
            if self.bgPosition.y >= K.bgHeight*2 {
                self.thurstOpacity = 0.0
            }
            else if self.bgPosition.y >= K.bgHeight {
                withAnimation {
                    self.boosterPosition.y += K.distance
                }
                self.thrustPosition.y = 1024*9/20
                if soundOn {
                    stopSound()
                }
            }
            withAnimation {
                self.bgPosition.y += K.distance
            }
        }
    }
    
    private func animateThrust() {
        if self.thrustIndex == 0 {
            self.thrustIndex = 1
        }
        else {
            self.thrustIndex = 0
        }
    }
}

PlaygroundPage.current.setLiveView(ContentView())
