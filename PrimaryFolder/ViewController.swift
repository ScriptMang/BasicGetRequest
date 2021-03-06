
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }

    private func createNewImage(preferredSize: CGSize, image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: preferredSize, format: image.imageRendererFormat)
        let redrawnImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: preferredSize))
        }
        return redrawnImage
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
                    let  scaledBallSize = CGSize(width: 500, height: 500)
                    if let downloadedImage = im  {
                        let newImage =
                        self.createNewImage(preferredSize: scaledBallSize,
                                               image: downloadedImage)
                        self.setupImageConstraints(scaledImage: newImage)
                    }
                }
            }
        }
        task.resume()
    }
}

