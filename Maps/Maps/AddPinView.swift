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
            TextField("Name", text: $name)
            Button("Save") {
                onSave(name, location)
            }
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
