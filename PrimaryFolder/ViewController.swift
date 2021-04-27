//
//  ViewController.swift
//  jsonGetImageTest
//
//  Created by Andy Peralta on 4/8/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }

    private func getScaledImgSize(target: CGSize, curr: CGSize) -> CGSize {
        let widthRatio = target.width / curr.width
        let heightRatio = target.height / curr.height
        let ratio = [widthRatio, heightRatio]

        let resizeConstant = min(ratio[0], ratio[1])
        var scaledImgSize = CGSize(width: 0, height: 0)
        scaledImgSize.width = curr.width * CGFloat(resizeConstant)
        scaledImgSize.height = curr.height * CGFloat(resizeConstant)
        return  scaledImgSize
    }

    private func createTargetImage(preferredSize: CGSize, image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: preferredSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: preferredSize))
        }
        return scaledImage
    }

    private func setupImageConstraints(scaledImage: UIImage) {
        let ballImgView = UIImageView(image: scaledImage)
        ballImgView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(ballImgView)

        NSLayoutConstraint.activate([
            ballImgView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            ballImgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 5),
        ])
    }

private func getImage(){
      let site =
      "https://www.pikpng.com/pngl/b/260-2601695_clip-royalty-free-ball-transparent-foam-sphere-png.png"
        let url = URL(string: site)!
        let session = URLSession.shared
        let task = session.downloadTask(with: url) {
             (fileURL, resp, err) in
             if let url = fileURL, let d = try? Data(contentsOf: url) {
                let im = UIImage(data: d)
                DispatchQueue.main.async {
                    let idealSize = CGSize(width: 500, height: 500)
                    if let downloadedImage = im  {
                        let originalSize = downloadedImage.size
                        let scaledBallSize =
                        self.getScaledImgSize(target: idealSize, curr: originalSize)
                        let newImage =
                        self.createTargetImage(preferredSize: scaledBallSize,
                                               image: downloadedImage)
                        self.setupImageConstraints(scaledImage: newImage)
                    }
                }
            }
        }
        task.resume()
    }
}

