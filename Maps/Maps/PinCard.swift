////
////  MyPins.swift
////  Maps
////
////  Created by Liliia Makashova on 2022-04-21.
////
//
import SwiftUI
import MapKit

struct PinCard: View {
    
    let pin: Pin
    
    var body: some View {
        ScrollView {
            PinCardMapView(pin: pin)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            VStack(alignment: .leading) {
                            Text(pin.name)
                                .font(.title)
            }
        }
    }
}

struct PinCard_Previews: PreviewProvider {
    static var previews: some View {
        PinCard(pin:
            Pin(location: CLLocationCoordinate2DMake(34.011_286, -116.166_868), name: "Bla"))
    }
}


struct PinCardMapView: View {
    @State private var region = MKCoordinateRegion()
    let pin: Pin

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [pin]) { _ in
            MapPin(coordinate: pin.location)
        }
        .onAppear {
            setRegion(pin.location)
        }
    
    }
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }

}
