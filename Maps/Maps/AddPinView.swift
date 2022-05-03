//
//  AddPinView.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-21.
//

import SwiftUI
import MapKit

struct AddPinView: View {
    let location: CLLocationCoordinate2D
    let onSave: (_ name: String, _ location: CLLocationCoordinate2D) -> Void
    @State var name: String = ""
    
    var body: some View {
        VStack {
            Text("Name your pinned location:").bold()
                .padding(30)
            TextField("Name", text: $name)
            Button("Save") {
                onSave(name, location)
            }.buttonStyle(BlueButton())
        }
    }
}

struct AddPinView_Previews: PreviewProvider {
    static var previews: some View {
        AddPinView(location: CLLocationCoordinate2DMake(0, 0), onSave: { name, location in
            // do nothing for preview
        })
    }
}


struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}


