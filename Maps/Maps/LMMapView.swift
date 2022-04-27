import UIKit
import CoreLocation
import MapKit
import SwiftUI

struct Pin: Identifiable {
    let id: UUID = UUID()
    let location: CLLocationCoordinate2D
    let name: String
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    @State var userInput: String = ""
    var locationManager:CLLocationManager!
    var mapView:MKMapView!
    var pins: [Pin] = []
    var onPinDrop: ((_ coordinates: CLLocationCoordinate2D) -> Void)? = nil
    
//    init(_ onPinDrop: @escaping (_ coordinates: CLLocationCoordinate2D) -> Void) {
//        self.onPinDrop = onPinDrop
//        super.init()
//    }
//
//    required init?(coder: NSCoder) {
//        self.onPinDrop = nil
//        super.init(coder: coder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create and Add MapView to our main view
        createMapView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        determineCurrentLocation()
    }
    
    func createMapView()
    {
        mapView = MKMapView()
        
//        let leftMargin:CGFloat = 10
//        let topMargin:CGFloat = 10
//        let mapWidth:CGFloat = view.frame.size.width-20
//        let mapHeight:CGFloat = 450
        
        mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        let long_press_recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(gestureReconizer:)))
        long_press_recognizer.delaysTouchesBegan = true
        long_press_recognizer.delegate = self
        mapView.addGestureRecognizer(long_press_recognizer)
        
        view.addSubview(mapView)
    }
    
    // https://stackoverflow.com/questions/14580269/get-tapped-coordinates-with-iphone-mapkit
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: mapView)
            let tapCoordinates = mapView.convert(touchLocation,toCoordinateFrom: mapView)
//            dropPin(coordinates: tapCoordinates)
            if onPinDrop != nil {
                onPinDrop!(tapCoordinates)
            }
            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }
    
//    func dropPin(coordinates: CLLocationCoordinate2D) {
//        let annotation: MKPointAnnotation = MKPointAnnotation()
//        annotation.coordinate = CLLocationCoordinate2DMake(coordinates.latitude, coordinates.longitude);
//        annotation.title = "Bla"
//        mapView.addAnnotation(annotation)
//    }
    
    func refreshPins() {
        if mapView == nil {
            return
        }
        mapView.removeAnnotations(mapView.annotations)
        for pin in pins {
            let annotation: MKPointAnnotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(pin.location.latitude, pin.location.longitude);
            annotation.title = pin.name
            mapView.addAnnotation(annotation)
        }
    }
    
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error \(error)")
    }
    
}

struct LMMapView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MapViewController
    var pins: [Pin]
    let onPinDrop: (_ coordinates: CLLocationCoordinate2D) -> Void
    
    func makeUIViewController(context: Context) -> MapViewController {
        let mvc = MapViewController()
        mvc.onPinDrop = onPinDrop
        return mvc
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        uiViewController.pins = pins
        uiViewController.refreshPins()
    }
}
