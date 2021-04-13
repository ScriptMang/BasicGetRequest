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
        // Do any additional setup after loading the view.
    }

    func setScaledImgSize(target: CGSize, frame: CGRect) -> CGSize {
        let widthRatio = target.width / frame.width
        let heightRatio = target.height / frame.height
        let ratio = [widthRatio, heightRatio]

        let scaleFactor = min(ratio[0], ratio[1])
        var scaledImgSize = CGSize(width: 0, height: 0)
        scaledImgSize.width = frame.width * CGFloat(scaleFactor)
        scaledImgSize.height = frame.height * CGFloat(scaleFactor)
        return  scaledImgSize
    }


    func getImage(){
      let site =
"https://www.pikpng.com/pngl/b/260-2601695_clip-royalty-free-ball-transparent-foam-sphere-png.png"
        let url = URL(string: site)!
        let session = URLSession.shared
        let task = session.downloadTask(with: url) {
            (fileURL, resp, err) in
            if let url = fileURL, let d = try? Data(contentsOf: url) {
                let im = UIImage(data: d)
                DispatchQueue.main.async {
                    let ballImg = UIImageView(image: im)
                    ballImg.translatesAutoresizingMaskIntoConstraints = false
                    let targetSize = CGSize(width: 300, height: 300)
                    let ballFrame = ballImg.frame

                    self.setScaledImgSize(target: targetSize, frame: ballFrame)
                    self.view.addSubview(ballImg)

                    NSLayoutConstraint.activate([
                        ballImg.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
                        ballImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 5),
                    ])
                }
            }
        }
        task.resume()
    }
}

