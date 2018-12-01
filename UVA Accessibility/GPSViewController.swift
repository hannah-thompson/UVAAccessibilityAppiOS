// note to self: look into using firebase in order to connect to Google maps

//  GPSViewController.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/11/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

/*
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_UhallAthleticFields.pdf (done)
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_ArtsArchitecture.pdf (done)
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_HealthSystem.pdf (done)
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_McCormickRdArea.pdf (done)
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_AldermanRd.pdf (done)
 
 to get coords: https://www.maps.ie/coordinates.html
 */

// https://developers.google.com/maps/documentation/ios-sdk/start
import UIKit
import GoogleMaps
import GooglePlaces

class GPSViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var legend: UIImageView!
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Just added a nav bar so that you could add the legend over the map
        let logo = UIImage(named: "LegendSmaller")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
    }
    
    override func loadView() {
        // creates defualt map view at Clark Hall
        let camera = GMSCameraPosition.camera(withLatitude: 38.0333, longitude: -78.5077, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        // creates button that will allow user to show their location
        mapView.settings.myLocationButton = true
        view = mapView
        
        // Alderman Road Map
        let southWest = CLLocationCoordinate2D(latitude: 38.02843687053843, longitude: -78.52163982577622)
        // left increase long
        // up increase latitude
        let northEast = CLLocationCoordinate2D(latitude: 38.03676, longitude: -78.5091475)
        let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        
        let icon = UIImage(named: "Alderman Road")
        
        let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
        overlay.bearing = 0
        overlay.map = mapView
        
        
        // McCormick Rd Map
        let southWest1 = CLLocationCoordinate2D(latitude: 38.02955, longitude: -78.51343)
        let northEast1 = CLLocationCoordinate2D(latitude: 38.03854, longitude: -78.504025)
        let overlayBounds1 = GMSCoordinateBounds(coordinate: southWest1, coordinate: northEast1)
        
        let icon1 = UIImage(named: "McCormick")
        
        let overlay1 = GMSGroundOverlay(bounds: overlayBounds1, icon: icon1)
        overlay1.bearing = 0
        overlay1.map = mapView
        
        // Hospital Map
        // long left right
        let southWest2 = CLLocationCoordinate2D(latitude: 38.029075, longitude: -78.50405)
        let northEast2 = CLLocationCoordinate2D(latitude: 38.035075, longitude: -78.494975)
        let overlayBounds2 = GMSCoordinateBounds(coordinate: southWest2, coordinate: northEast2)
        
        let icon2 = UIImage(named: "Hospital")
        
        let overlay2 = GMSGroundOverlay(bounds: overlayBounds2, icon: icon2)
        overlay2.bearing = 0
        overlay2.map = mapView
        
        // Arts Grounds Map
        // long left right
        let southWest3 = CLLocationCoordinate2D(latitude: 38.03535, longitude: -78.5083)
        let northEast3 = CLLocationCoordinate2D(latitude: 38.0430, longitude: -78.50065)
        let overlayBounds3 = GMSCoordinateBounds(coordinate: southWest3, coordinate: northEast3)
        
        let icon3 = UIImage(named: "Arts Grounds")
        
        let overlay3 = GMSGroundOverlay(bounds: overlayBounds3, icon: icon3)
        overlay3.bearing = 0
        overlay3.map = mapView
        
        // Athletics Map
        // long left right
        let southWest4 = CLLocationCoordinate2D(latitude: 38.0411, longitude: -78.5147)
        let northEast4 = CLLocationCoordinate2D(latitude: 38.047975, longitude: -78.5056)
        let overlayBounds4 = GMSCoordinateBounds(coordinate: southWest4, coordinate: northEast4)
        
        let icon4 = UIImage(named: "Athletics")
        
        let overlay4 = GMSGroundOverlay(bounds: overlayBounds4, icon: icon4)
        overlay4.bearing = 0
        overlay4.map = mapView
    }
    
    
    
}
