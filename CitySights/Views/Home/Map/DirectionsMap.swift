//
//  DirectionsMap.swift
//  CitySights
//
//  Created by Jeffrey Sweeney on 1/9/22.
//

import SwiftUI
import MapKit

struct DirectionsMap: UIViewRepresentable {
    
    @EnvironmentObject var contentModel: ContentModel
    
    var business: Business
    
    // Destination coordinate - used twice so define here
    var destination: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: business.coordinates?.latitude ?? CLLocationDegrees(),
            longitude: business.coordinates?.longitude ?? CLLocationDegrees()
        )
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        let request = MKDirections.Request()
        
        // Set a start (source) and end (destination) of the request
        request.source = MKMapItem(
            placemark: MKPlacemark(
                coordinate: contentModel.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
            )
        )
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        // Build directions and add route overlay on map
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if error == nil && response != nil {
                for route in response!.routes {
                    // NOTE: Note actually visible until the delegate says 'how' to draw them.
                    mapView.addOverlay(route.polyline)
                    
                    // Zoom in and give edge padding so route isn't stuffed on edges
                    mapView.setVisibleMapRect(
                        route.polyline.boundingMapRect,
                        edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                        animated: true)
                }
            }
        }
        
        // Give annotation for the end point
        let annotation = MKPointAnnotation()
        annotation.coordinate = destination
        annotation.title = business.name ?? ""
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // No real need for updates - business is well defined by the time we get here
    }
    
    static func dismantleUIView(_ mapView: MKMapView, coordinator: ()) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    // MARK: Coordinator
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    internal class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
        }
    }
}
