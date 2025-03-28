// ViewModels.swift
import Foundation
import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var subscriptionTier: SubscriptionTier = .basic
    @Published var wardrobe: [ClothingItem] = []
    @Published var outfitHistory: [Outfit] = []
    @Published var profileImage: UIImage?
    
    init() {
        // For demo purposes, we'll add some sample data
        loadSampleData()
    }
    
    func login(email: String, password: String) {
        // Mock login functionality
        self.isLoggedIn = true
        self.email = email
    }
    
    func logout() {
        isLoggedIn = false
        // Clear sensitive data
        password = ""
    }
    
    func signup(name: String, email: String, password: String) {
        // Mock signup functionality
        self.name = name
        self.email = email
        self.isLoggedIn = true
    }
    
    func addClothingItem(_ item: ClothingItem) {
        wardrobe.append(item)
    }
    
    func removeClothingItem(at index: Int) {
        wardrobe.remove(at: index)
    }
    
    func loadSampleData() {
        // Sample clothing items
        let sampleWardrobe = [
            ClothingItem(name: "White T-Shirt", category: .tops, color: "White", imageURL: "tshirt_white"),
            ClothingItem(name: "Blue Jeans", category: .bottoms, color: "Blue", imageURL: "jeans_blue"),
            ClothingItem(name: "Black Hoodie", category: .outerwear, color: "Black", imageURL: "hoodie_black"),
            ClothingItem(name: "Red Dress", category: .dresses, color: "Red", imageURL: "dress_red"),
            ClothingItem(name: "Sneakers", category: .shoes, color: "White", imageURL: "sneakers_white"),
            ClothingItem(name: "Sunglasses", category: .accessories, color: "Black", imageURL: "sunglasses"),
            ClothingItem(name: "Baseball Hat", category: .accessories, color: "Navy", imageURL: "hat")
        ]
        
        // Sample outfit history
        let sampleOutfitHistory = [
            Outfit(
                date: Date().addingTimeInterval(-86400),
                top: sampleWardrobe[0],
                bottom: sampleWardrobe[1],
                outerwear: nil,
                shoes: sampleWardrobe[4],
                accessories: [sampleWardrobe[5], sampleWardrobe[6]],
                weather: .sunny,
                isAccepted: true
            )
        ]
        
        self.wardrobe = sampleWardrobe
        self.outfitHistory = sampleOutfitHistory
    }
    
    func getTodayOutfit() -> Outfit? {
        // Mock outfit generation
        // In a real app, this would use the AI to generate an outfit based on weather
        
        let today = Date()
        
        let outfit = Outfit(
            date: today,
            top: wardrobe.first(where: { $0.category == .tops }),
            bottom: wardrobe.first(where: { $0.category == .bottoms }),
            outerwear: wardrobe.first(where: { $0.category == .outerwear }),
            shoes: wardrobe.first(where: { $0.category == .shoes }),
            accessories: wardrobe.filter { $0.category == .accessories },
            weather: .sunny
        )
        
        return outfit
    }
    
    func updateProfileImage(_ image: UIImage) {
        profileImage = image
        // In a real app, you would also save this to persistent storage
    }
    
    func removeProfileImage() {
        profileImage = nil
        // In a real app, you would also remove this from persistent storage
    }
}
