
import AVFoundation

var audioPlayer: AVAudioPlayer?

public func playSound() {
    if let path = Bundle.main.path(forResource: "sound", ofType: "mp3") {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = 2
            audioPlayer?.play()
        } catch {
            print("Error")
        }
    }
}

public func stopSound() {
    audioPlayer?.stop()
}

/*:
Credit:
https://www.zapsplat.com/music/loop-rockets-of-a-space-shuttle-on-full-power/
*/
