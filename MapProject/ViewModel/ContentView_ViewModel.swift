//
//  ContentView_ViewModel.swift
//  MapProject
//
//  Created by Amit Shrivastava on 11/01/22.
//

import Foundation
import MapKit
import LocalAuthentication



extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published  var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        @Published private(set) var locations: [Location]
        @Published var selectedLocation: Location?
        let savePath = FileManager.getDocumentsDirectory.appendingPathComponent("SavedPlaces")
        //function
        @Published var isLocked = false
        @Published var showPrivacyAlert = false
        init() {
            do {
                
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }
            
            catch {
                locations = []
            }
        }
        
        
        func save() {
            let sampleLocation = Location(id: UUID(), name: "New Map Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
                locations.append(sampleLocation)
                saveData()
        }
        
        func update(location: Location) {
            guard let selectedLocation = selectedLocation else {
                return
            }
            
            if let index = locations.firstIndex(of: selectedLocation) {
            locations[index] = location
            }
            saveData()
        }
        
        func saveData() {
            // when trying to save use encoder
            do {
                let data = try JSONEncoder().encode(locations)
                // write to enable saving
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
            catch {
                print("unable to save data")
            }
        }
        
        func authenticate()  {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Device needs authentication"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, localError in
                    if success {
                        Task {
                            @MainActor in
                                self.isLocked = true
                            
                        }
                       
                    }
                    else {
                        
                    }
                }
            }
            else {
                //no biometric
                showPrivacyAlert = true
            }
        }
    }
}
