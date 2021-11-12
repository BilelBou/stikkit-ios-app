import AVFoundation
import UIKit

final class SimpleVideoView: UIView {

    private var player = AVPlayer()
    private var playerLayer: AVPlayerLayer = AVPlayerLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        playerLayer.player = player
        configureStyleAndLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = CGRect(origin: .zero, size: frame.size)
    }

    private func configureStyleAndLayout() {
        layer.addSublayer(playerLayer)
    }

    func configure(url: URL) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
    }
}
