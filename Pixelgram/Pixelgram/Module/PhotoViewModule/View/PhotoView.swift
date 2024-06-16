//
//  PhotoView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 15.06.2024.
//

import UIKit

protocol PhotoViewProtocol: AnyObject {
    var closeButtonAction: UIAction { get set }
}


class PhotoView: UIViewController, PhotoViewProtocol {

    var presenter: PhotoViewPresenterProtocol!
    var completion: (() -> ())?
    lazy var closeButtonAction = UIAction { [weak self] _ in
        self?.completion?()
    }
    private lazy var tapGesture: UITapGestureRecognizer = {
        $0.numberOfTapsRequired = 2
        $0.addTarget(self, action: #selector(zoomImage))
        return $0
    }(UITapGestureRecognizer())
    private lazy var closeButton: UIButton = {
        $0.setBackgroundImage(.closeIcon, for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: view.bounds.width - 60, y: 60, width: 25, height: 25), primaryAction: closeButtonAction))
    private lazy var scrollView: UIScrollView = {
        $0.maximumZoomScale = 10
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.addSubview(image)
        $0.backgroundColor = .black
        return $0
    }(UIScrollView(frame: view.bounds))
    private lazy var image: UIImageView = {
        $0.image = presenter.image
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(tapGesture)
        return $0
    }(UIImageView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        print("deinit")
    }
}

// MARK: -- Setup layer
private extension PhotoView {
    func setup() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        setImageSize()
    }
    
    func setImageSize() {
        let imageSize = image.image?.size
        let imageHeight = imageSize?.height ?? 0
        let imageWidth = imageSize?.width ?? 0
        
        
        let ratio = imageHeight/imageWidth
        
        image.frame.size = CGSize(width: view.frame.width, height: view.frame.width * ratio)
        
        image.center = view.center
    }
    
    // MARK:-- @objc
    @objc func zoomImage() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            if self?.scrollView.zoomScale ?? 1 > 1 {
                self?.scrollView.zoomScale = 1
            } else {
                self?.scrollView.zoomScale = 2
            }
        }
    }
}


// MARK: -- UIScrollViewDelegate
extension PhotoView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height > view.frame.height {
            image.center.y = scrollView.contentSize.height / 2
        } else {
            image.center.y = view.center.y
        }
    }
}

