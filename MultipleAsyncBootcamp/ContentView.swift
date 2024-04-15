//
//  ContentView.swift
//  MultipleAsyncBootcamp
//
//  Created by sonam sodani on 2024-04-05.
//

import SwiftUI

struct ContentView: View {
    @State var images:[UIImage] = []
    
    
    private var grids = [GridItem(.fixed(100))]
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                
            }label: {
                ScrollView{
                    LazyVGrid(columns: grids) {
                        ForEach(images, id:\.self) {image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 150)
                        }
                    }
                    .padding(.horizontal)
                }
               
            }
            .navigationTitle("Async Let 🥳")
            .onAppear {
                images.removeAll()
                Task {
                    do {
                        async let fetchImage1 = fetchImages()
                        async let fetchImage2 = fetchImages()
                        async let fetchImage3 = fetchImages()
                        async let fetchImage4 = fetchImages()
                        
                        let(image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
                        
                        self.images.append(contentsOf: [image1, image2, image3, image4])
                        
                    }catch {
                        
                    }
                }
            }
        }
        .padding()
        
    }
    
    func fetchImages() async throws -> UIImage {
        guard let url = URL(string: "https://picsum.photos/300") else { return UIImage() }
        do {
            let (data,response) = try await URLSession.shared.data(from: url)
            //handel response error here
            
            //get image form data here
            guard let image = UIImage(data: data) else { return UIImage() }
            return image
        }catch let error {
            throw error
        }
    }
}

#Preview {
    ContentView()
}
