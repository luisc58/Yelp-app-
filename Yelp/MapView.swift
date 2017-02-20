//
//  MapView.swift
//  Yelp
//
//  Created by luis castillo on 2/15/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{
    var businesses: [Business]!
    var pinAnnotationView:MKPinAnnotationView!
    var myposCli = CLLocationCoordinate2D(latitude: MyVariables.latitud, longitude: MyVariables.longitud)
    var locationMananger : CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMananger = CLLocationManager()
        locationMananger.delegate = self
        locationMananger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationMananger.distanceFilter = 200
        locationMananger.requestWhenInUseAuthorization()
        addAnnotationAtCoordinate(coordinate: myposCli)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse { locationMananger.startUpdatingLocation() }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // add an Annotation with a coordinate: CLLocationCoordinate2D
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        // Index through array
        for index in 0...MyVariables.latitudes.count - 1 {
            let lat: CLLocationDegrees = MyVariables.latitudes[index]
            let long: CLLocationDegrees = MyVariables.longitudes[index]
            let name: String = MyVariables.names[index]
            let myposCli : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,long)
            let mypos = MKPointAnnotation()
            
            mypos.coordinate = myposCli
            mypos.title = name
            mypos.subtitle = "Anotacao" + " - " + String (index)
            
            self.mapView.addAnnotation(mypos)
        }
    }
    
    private func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "mapView"
        
        //custom image annotation
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if (annotationView == nil) { annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier) }
        else { annotationView!.annotation = annotation }
        
        annotationView?.image = UIImage(named: "map")
        return annotationView
    }
}
