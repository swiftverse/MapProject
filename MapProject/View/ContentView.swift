//
//  ContentView.swift
//  MapProject
//
//  Created by Amit Shrivastava on 10/01/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isLocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 40, height: 40)
                                .background(.white)
                                .clipShape(Circle())
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                    }
                }
                //----
                //-----
                Circle()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.blue)
                    .opacity(0.5)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.save()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .font(.title)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                        
                    }
                }
            }
            .sheet(item: $viewModel.selectedLocation) {
                place in
                EditView(location: place) { location in
                    viewModel.update(location: location)
                }
            }
            
            //--
            
            //--
            
            
        }
        else {
            Button("Unlock places") {
                viewModel.authenticate()
                
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            //---
            .alert(isPresented: $viewModel.showPrivacyAlert) {
                Alert (title: Text("Acces to FaceCam is required to face cam setting"),
                       message: Text("Go to Settings?"),
                       primaryButton: .default(Text("Settings"), action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }),
                       secondaryButton: .default(Text("Cancel")))
            }
            //---
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
