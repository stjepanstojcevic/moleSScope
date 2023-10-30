//
//  ContentView.swift
//  moleSScope
//
//  Created by Stjepan Stojčević on 30.10.2023..
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    
    @State private var isOption1Selected = false
    @State private var isOption2Selected = false
    @State private var isOption3Selected = false

    @State private var age: String = ""
    @State private var genderOptions = ["Muški", "Ženski"]
    @State private var selectedGender = "Muški"
    @State private var number: String = ""
    @State private var location = ["Ruke", "Noge","Leđa","Prsa","Trbuh","Glava","Vrat"]
    @State private var selectedLocation = "Ruke"



    var body: some View {
        VStack {
            PhotosPicker("Izaberi sliku iz galerije", selection: $avatarItem, matching: .images)

            if let avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .shadow(color: Color.black.opacity(0.99), radius: 40, x: 0, y: 5)

            }
            Form {
                
                        Section(header: Text("Informacije")) {
                    
                        Toggle("Mijenja li madež veličinu?", isOn: $isOption1Selected)
                        Toggle("Imaš li plave oči?", isOn: $isOption2Selected)
                        Toggle("Ima li madež više boja?", isOn: $isOption3Selected)

                        TextField("Godine", text: $age)
                                .keyboardType(.numberPad)

                        Picker("Spol", selection: $selectedGender) {
                                ForEach(genderOptions, id: \.self) {
                                        Text($0)
                                        }
                                    }
                        Picker("Lokacija", selection: $selectedLocation) {
                            ForEach(location, id: \.self) {
                                    Text($0)
                                    }
                                }
                                TextField("Promjer madeža (mm)", text: $number)
                                    .keyboardType(.numberPad)
                            }
                        }
            Button("Provjeri svoj madež. Sretno!") {print("Gumb pritisnut!")}
                        .padding()
        }
        .onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        return
                    }
                }

                print("Failed")
            }
        }
        
        
        
    }
}
struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
