// note to self: look into using firebase in order to connect to Google maps

//  GPSViewController.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/11/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

/*
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_UhallAthleticFields.pdf
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_ArtsArchitecture.pdf
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_HealthSystem.pdf
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_McCormickRdArea.pdf
 https://www.fm.virginia.edu/docs/ges/ADA_Regions_AldermanRd.pdf (this one is done already)
 
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
        // MIGHT JUST NEED TO MOVE THE MAP VIEW DOWN A LITTLE AND HAVE THE IMAGE VIEW GO ALL THE WAY ACROSS THE TOP
        
    }
    
    override func loadView() {
        // creates defualt map view
        let camera = GMSCameraPosition.camera(withLatitude: 38.0333, longitude: -78.5077, zoom: 17.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        // creates button that will allow user to show their location
        mapView.settings.myLocationButton = true
        view = mapView
        
        // Alderman Road Map
        let southWest = CLLocationCoordinate2D(latitude: 38.02843687053843, longitude: -78.52163982577622)
        let northEast = CLLocationCoordinate2D(latitude: 38.036711804252995, longitude: -78.50902510341258)
        let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
        
        let icon = UIImage(named: "Alderman Road")
        
        let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
        overlay.bearing = 0
        overlay.map = mapView
        
        
        // Central Grounds Map
        let southWest1 = CLLocationCoordinate2D(latitude: 38.03093744652292, longitude: -78.50874070543797)
        let northEast1 = CLLocationCoordinate2D(latitude: 38.03717455049366, longitude: -78.50160737056287)
        let overlayBounds1 = GMSCoordinateBounds(coordinate: southWest1, coordinate: northEast1)
        
        let icon1 = UIImage(named: "Central Grounds")
        
        let overlay1 = GMSGroundOverlay(bounds: overlayBounds1, icon: icon1)
        overlay1.bearing = 0
        overlay1.map = mapView
        
        // ADD THE REST OF THE MAPS AND YOU'LL BE DONE !!!
    }
    
    
    
}
