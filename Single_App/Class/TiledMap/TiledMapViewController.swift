//
//  Copyright (c) 2015-present Yichi Zhang
//  https://github.com/yichizhang
//  zhang-yi-chi@hotmail.com
//
//  This source code is licensed under MIT license found in the LICENSE file
//  in the root directory of this source tree.
//  Attribution can be found in the ATTRIBUTION file in the root directory 
//  of this source tree.
//

import UIKit

enum TiledContentType
{
    case PDF
    case Image
}

let SkippingGirlImageName = "SkippingGirl"
let SkippingGirlImageSize = CGSize(width: 432, height: 648)

let ButtonTitleCancel = "Cancel"
let ButtonTitleRemoveAnnotation = "Remove this Annotation"

@objc class TiledMapViewController: UIViewController, TiledScrollViewDelegate, TileSource, UIAlertViewDelegate {
    
    let demoAnnotationViewReuseID = "TiledMapAnnotationView"

    var scrollView: TiledScrollView!
    var infoLabel: UILabel!
    var searchField: UITextField!
    var mode: TiledContentType!
    
    var pview: UIView!

    weak var selectedAnnotation: TiledAnnotation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if (mode == TiledContentType.PDF) {
            scrollView = TiledPDFScrollView(
                frame: self.view.bounds,
                URL: Bundle.main.url(forResource: "Map", withExtension: "pdf")!
            )
        }
        else {
            scrollView = TiledScrollView(frame: self.view.bounds, contentSize: SkippingGirlImageSize)
        }
        scrollView.tiledScrollViewDelegate = self
        scrollView.zoomScale = 1.0

        scrollView.dataSource = self
        scrollView.tiledScrollViewDelegate = self

        scrollView.tiledView.shouldAnnotateRect = true

        // totals 4 sets of tiles across all devices, retina devices will miss out on the first 1x set
        scrollView.levelsOfZoom = 3
        scrollView.levelsOfDetail = 3
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        infoLabel = UILabel(frame: .zero)
        infoLabel.backgroundColor = UIColor.black
        infoLabel.textColor = UIColor.white
        infoLabel.textAlignment = NSTextAlignment.center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)

        view.addConstraints([
                                NSLayoutConstraint(item: scrollView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: scrollView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),

                                NSLayoutConstraint(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 20),
                                NSLayoutConstraint(item: infoLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
                            ])

        addRandomAnnotations()
        addMainAnnotations();
        scrollView.refreshAnnotations()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addRandomAnnotations()
    {
        for number in 0 ... 4 {
            let annotation = TiledMapAnnotation(isSelectable: (number % 3 != 0))
            
            let w = UInt32(UInt(scrollView.tiledView.bounds.width))
            let h = UInt32(UInt(scrollView.tiledView.bounds.height))
            
            annotation.contentPosition = CGPoint(
                x: CGFloat(UInt(arc4random_uniform(w))),
                y: CGFloat(UInt(arc4random_uniform(h)))
            )
            scrollView.addAnnotation(annotation)
        }
    }

    // 特殊移动Annotation
    func addMainAnnotations()
    {
//        let annotation = TiledMapAnnotation(isSelectable: true)
//        annotation.contentPosition = CGPoint(x: CGFloat(100),y: CGFloat(100))
//        scrollView.addMainAnnotation(annotation)
        self.pview = UIView()
        self.pview.frame = CGRect(x: 100, y: 100, width: 30, height: 30)
        self.pview.backgroundColor = .red
        scrollView.tiledView.addSubview(self.pview)
    }
    
    // MARK: TiledScrollView Delegate
    func tiledScrollViewDidZoom(_ scrollView: TiledScrollView) {

        infoLabel.text = NSString(format: "zoomScale=%.2f", scrollView.zoomScale) as String
    }

    func tiledScrollView(_ scrollView: TiledScrollView, didReceiveSingleTap gestureRecognizer: UIGestureRecognizer) {
        let tapPoint: CGPoint = gestureRecognizer.location(in: scrollView.tiledView)
        infoLabel.text = NSString(format: "(%.2f, %.2f), zoomScale=%.2f", tapPoint.x, tapPoint.y, scrollView.zoomScale) as String
        //updateframe(scrollView, orgPoint: self.pview.frame.origin, tapPoint: tapPoint)
        UIView.animate(withDuration: 3) {
            self.pview.frame = CGRect(origin: tapPoint, size: CGSize(width: 30, height: 30))
        }
    }
    
    // 特殊移动Annotation
    func updateframe(_ scrollView: TiledScrollView, orgPoint: CGPoint, tapPoint: CGPoint) {
        var X: CGFloat = 0
        var Y: CGFloat = 0
        if orgPoint.x < tapPoint.x {
            X = orgPoint.x + 1;
        } else if orgPoint.x > tapPoint.x {
            X = orgPoint.x - 1
        } else {
            X = tapPoint.x
        }
        if orgPoint.y < tapPoint.y {
            Y = orgPoint.y + 1;
        } else if orgPoint.y > tapPoint.y {
            Y = orgPoint.y - 1;
        }  else {
            Y = tapPoint.y
        }
        let lastPosition = CGPoint(x: X, y: Y)
        //UIView.animate(withDuration: 5.0, animations: {
        //    scrollView.annotation.contentPosition = lastPosition;
        //}) { [weak self](isFinish) in
        //    self?.updateframe(scrollView, orgPoint: lastPosition, tapPoint: tapPoint)
        //}
        UIView.animate(withDuration: 5.0) {
            self.pview.frame.origin = lastPosition;
        }
        let popTime = DispatchTime.now() + Double(Int64(5.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime, execute: {
            self.updateframe(scrollView, orgPoint: lastPosition, tapPoint: tapPoint)
        })
    }
    

    func tiledScrollView(_ scrollView: TiledScrollView, shouldSelectAnnotationView view: TiledAnnotationView) -> Bool {
        if let annotation = view.annotation as? TiledMapAnnotation {
            return annotation.isSelectable
        }
        return true
    }

    func tiledScrollView(_ scrollView: TiledScrollView, didSelectAnnotationView view: TiledAnnotationView) {
        guard
            let annotationView = view as? TiledMapAnnotationView,
            let annotation = annotationView.annotation as? TiledMapAnnotation else {
                return
        }
        
        let alertView = UIAlertView(
        title: "Annotation Selected",
        message: "You've selected an annotation. What would you like to do with it?",
        delegate: self,
        cancelButtonTitle: ButtonTitleCancel,
        otherButtonTitles: ButtonTitleRemoveAnnotation)
        alertView.show()

        selectedAnnotation = annotation

        annotation.isSelected = true
        annotationView.update(forAnnotation: annotation)
    }
    
    func tiledScrollView(_ scrollView: TiledScrollView, didDeselectAnnotationView view: TiledAnnotationView) {
        guard
            let annotationView = view as? TiledMapAnnotationView,
            let annotation = annotationView.annotation as? TiledMapAnnotation else {
                return
        }

        selectedAnnotation = nil

        annotation.isSelected = false
        annotationView.update(forAnnotation: annotation)
    }

    func tiledScrollView(_ scrollView: TiledScrollView, viewForAnnotation annotation: TiledAnnotation) -> TiledAnnotationView {
        
        var annotationView: TiledMapAnnotationView!
        annotationView =
        (scrollView.dequeueReusableAnnotationViewWithReuseIdentifier(demoAnnotationViewReuseID) as? TiledMapAnnotationView) ??
        TiledMapAnnotationView(frame: .zero, annotation: annotation, reuseIdentifier: demoAnnotationViewReuseID)

        annotationView.update(forAnnotation: annotation as? TiledMapAnnotation)

        return annotationView
    }

    func tiledScrollView(_ scrollView: TiledScrollView, imageForRow row: Int, column: Int, scale: Int) -> UIImage {
        
        let fileName = NSString(format: "%@_%dx_%d_%d.png", SkippingGirlImageName, scale, row, column) as String
        return UIImage(named: fileName)!

    }

    // MARK: UIAlertView Delegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        guard let buttonTitle = alertView.buttonTitle(at: buttonIndex) else {
            return
        }
        switch buttonTitle {
        case ButtonTitleCancel:
            break
        case ButtonTitleRemoveAnnotation:
            if let selectedAnnotation = self.selectedAnnotation {
                scrollView.removeAnnotation(selectedAnnotation)
            }
        default:
            break
        }

    }
}

