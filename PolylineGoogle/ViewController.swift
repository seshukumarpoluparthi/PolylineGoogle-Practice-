//
//  ViewController.swift
//  PolylineGoogle
//
//  Created by venkatarao on 22/05/18.
//  Copyright © 2018 Exaact. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController,GMSMapViewDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    
    let marker = [
        Markers(name : "hyderabad",lat:42.759338315480704, long: -91.86545984650242 ),
        Markers(name: "vijayawada", lat: 42.76286721794273, long: -91.85773508453829),
        Markers(name: "vizag", lat: 42.758645114593605, long: -91.85807840729122),
        Markers(name: "orissa", lat: 42.759338315480704, long: -91.86545984650242),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.mapType = .satellite
        for i in marker {
            let mark = GMSMarker()
            mark.position = CLLocationCoordinate2D(latitude: i.lat, longitude: i.long)
            mark.title = i.name
            mark.snippet = "hey this is \(i.name)"
            mark.map = mapView
        }
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 42.759338315480704, longitude: -91.86545984650242))
        path.add(CLLocationCoordinate2D(latitude: 42.76286721794273, longitude: -91.85773508453829))
        path.add(CLLocationCoordinate2D(latitude: 42.758645114593605, longitude: -91.85807840729122))
        path.add(CLLocationCoordinate2D(latitude: 42.759338315480704, longitude: -91.86545984650242))
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 4.0
        polyline.geodesic = true
        // polyline.strokeColor = UIColor.green
        let styles = [GMSStrokeStyle.solidColor(.clear),
                      GMSStrokeStyle.solidColor(.red)]
        let lengths: [NSNumber] = [15,15]
        polyline.spans = GMSStyleSpans(polyline.path!, styles, lengths,GMSLengthKind(rawValue: 1)!)
        // GMSLengthKind.rhumb
        polyline.map = mapView
        let bounds = GMSCoordinateBounds(path: path)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50))
    }
    
}

