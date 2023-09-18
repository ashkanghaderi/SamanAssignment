//
//  MapPointViewController.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa
import Domain

class MapPointViewController: BaseViewController,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    public var didSelectLatitude = PublishSubject<Double>()
    public var didSelectLongitude = PublishSubject<Double>()
    var radarView: RadarView?
    var touchPoint: CGPoint?
    var viewModel: MapPointViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(createNewAnnotation))
        uilpgr.minimumPressDuration = 0.25
        mapView.addGestureRecognizer(uilpgr)
        
        setRegion()
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = MapPointViewModel.Input(viewWillAppearTrigger: viewWillAppear, latitude: self.rx.selectLatitude.asDriver(), longitude: self.rx.selectLongitude.asDriver())
        
        let output = viewModel.transform(input: input)
        
        [output.canStart.drive(),output.airPorts.drive(),
         output.isFetching.drive(fetchingBinding),
         output.error.drive(errorBinding)].forEach { (item) in
            item.disposed(by: disposeBag)
        }
    }
    
    private func setRegion() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.57285, longitude:  -0.44161)
        let region = self.mapView.regionThatFits(MKCoordinateRegion(center: coordinate, latitudinalMeters: 2000000, longitudinalMeters: 2000000))
        self.mapView.setRegion(region, animated: true)
    }
    
    @objc func createNewAnnotation(_ sender: UIGestureRecognizer) {
        let overLays = mapView.overlays
        mapView.removeOverlays(overLays)
        let touchPoint = sender.location(in: self.mapView)
        self.touchPoint = touchPoint
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let heldPoint = MKPointAnnotation()
        heldPoint.coordinate = coordinates
        if (sender.state == .began) {
            heldPoint.title = "Set Point"
            heldPoint.subtitle = String(format: "%.4f", coordinates.latitude) + "," + String(format: "%.4f", coordinates.longitude)
            mapView.addAnnotation(heldPoint)
        }
        // Cancel the long press to make way for the next gesture
        sender.state = .cancelled
        
        let location = CLLocation(latitude: heldPoint.coordinate.latitude as CLLocationDegrees, longitude: heldPoint.coordinate.longitude as CLLocationDegrees)
        
        didSelectLatitude.onNext(heldPoint.coordinate.latitude)
        didSelectLongitude.onNext(heldPoint.coordinate.longitude)
        addRadiusCircle(location: location)
    }
    
    private func addRadiusCircle(location: CLLocation){
        
        let circle = MKCircle(center: location.coordinate, radius: 500000 as CLLocationDistance)
        self.mapView.addOverlay(circle)
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.red
            circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            
            return circle
        } else {
            return MKOverlayRenderer()
        }
    }
    
    private func addRadarView() {
        DispatchQueue.main.async {
            self.radarView = RadarView(frame: CGRect(x: 0, y: 0, width: 209, height: 209))
            self.radarView?.backgroundColor = .clear
            self.radarView?.center = CGPoint(x: self.touchPoint?.x ?? 0.0, y: self.touchPoint?.y ?? 0.0)
            self.view.addSubview(self.radarView!)
            self.radarView?.circleFillColor = .clear
            self.radarView?.circleFillColor = .clear
            self.radarView?.circleBorderColor = .clear
            self.view.bringSubviewToFront(self.radarView!)
            self.radarView?.layoutIfNeeded()
        }
    }
    
    private func removeRadarView() {
        radarView?.removeFromSuperview()
    }
    
    var fetchingBinding: Binder<Bool> {
        return Binder(self, binding: { (vc, status) in
            if status == true {
                vc.addRadarView()
            } else {
                vc.removeRadarView()
            }
        })
    }
    
}

extension Reactive where Base: MapPointViewController {
    
    internal var selectLatitude: ControlEvent<Double> {
        
        return ControlEvent(events: self.base.didSelectLatitude)
        
    }
}

extension Reactive where Base: MapPointViewController {
    
    internal var selectLongitude: ControlEvent<Double> {
        
        return ControlEvent(events: self.base.didSelectLongitude)
        
    }
}

