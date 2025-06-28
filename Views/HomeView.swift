import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Modern gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Blur effect overlay
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Welcome Section
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                        .symbolEffect(.bounce)
                    
                    Text("Welcome Back!")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("You've successfully signed in")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 16) {
                    // Profile Button
                    Button(action: {
                        // Handle profile action
                    }) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("View Profile")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.primary)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.background)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )
                    }
                    
                    // Settings Button
                    Button(action: {
                        // Handle settings action
                    }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Settings")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.primary)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(.background)
                                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                        )
                    }
                    
                    // Logout Button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Sign Out")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.red)
                                    .shadow(color: Color.red.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
