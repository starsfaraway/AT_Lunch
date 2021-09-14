//
//  MapViewController.swift
//  AllTrails_Lunchtime
//
//  Created by Matthew Riley on 9/13/21.
//

import UIKit
import MapKit
import Combine

class MapViewController: UIViewController {
    
    var map: MKMapView?
    var viewModel: RestaurantViewModel?
    let initialSpan = 5000.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContent()
        NotificationCenter.default.addObserver(self, selector: #selector(updateRestaurants(note:)), name: NotificationNames.updateRestaurants, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocaiton(note:)), name: NotificationNames.updateLocation, object: nil)
    }

    func setupContent() {
        let mapView = MKMapView(frame: self.view.frame)
        self.map = mapView
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: LunchAnnotation.reuseId)
        mapView.isUserInteractionEnabled = true
        self.view.addSubview(mapView)
        
        let constraints = [
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        mapView.delegate = self
        guard let vm = viewModel else {
            return
        }
        mapView.region = MKCoordinateRegion(center: vm.currentLocation.coordinate, latitudinalMeters: initialSpan, longitudinalMeters: initialSpan)
        self.updateContent()
    }
    
    func updateContent() {
        guard let vm = viewModel else {
            return
        }
        for restaurant in vm.restuarants {
            let place = LunchAnnotation()
            place.coordinate = CLLocationCoordinate2D(latitude: restaurant.geometry?.location.lat ?? 0.0, longitude: restaurant.geometry?.location.lng ?? 0.0)
            place.restuarant = restaurant
            self.map?.addAnnotation(place)
        }
    }
    
    @objc func updateRestaurants(note: Notification) {
        if let annotations = self.map?.annotations {
            self.map?.removeAnnotations(annotations)
        }
        self.updateContent()
    }
    
    @objc func updateLocaiton(note: Notification) {
        guard let span = self.map?.region.span, let center = self.viewModel?.currentLocation else {
            return
        }
        map?.setRegion(MKCoordinateRegion(center: center.coordinate, span: span), animated: true)
    }

}

extension MapViewController: MKMapViewDelegate {
    //TODO: need to update when user stops scrolling
//    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        let radius = mapView.region.span
//        self.token = self.viewModel.updateRestaurants(location: self.viewModel.currentLocation, radius: radius.latitudeDelta)
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: LunchAnnotation.reuseId, for: annotation)
        if let annotationMarker = annotationView as? MKMarkerAnnotationView {
            annotationMarker.animatesWhenAdded = true
            annotationMarker.canShowCallout = true
            annotationMarker.markerTintColor = UIColor(named: "ATGreen") ?? .green
            
            let detailView = DetailViewContent(frame: .zero, hideLikes: true)
            NSLayoutConstraint.activate([
                detailView.widthAnchor.constraint(equalToConstant: 240.0),
                detailView.heightAnchor.constraint(equalToConstant: 100.0),
                
            ])
            if let lunchAnnotation = annotation as? LunchAnnotation, let lunchRestaurant = lunchAnnotation.restuarant {
                detailView.updateContent(restaurant: lunchRestaurant)
            }
            annotationMarker.detailCalloutAccessoryView = detailView
        }
        return annotationView
    }

}
    
