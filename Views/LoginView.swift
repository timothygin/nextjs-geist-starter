import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var showingError: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToHome: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
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
            
                ScrollView {
                    VStack(spacing: 25) {
                        // App Logo/Title
                        VStack(spacing: 8) {
                            Text("Welcome Back")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.primary)
                            
                            Text("Sign in to continue")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 60)
                        
                        // Form Container
                        VStack(spacing: 20) {
                            // Email Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                
                                TextField("", text: $email)
                                    .textFieldStyle(.plain)
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.background)
                                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                                    )
                            }
                            
                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                
                                SecureField("", text: $password)
                                    .textFieldStyle(.plain)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.background)
                                            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                                    )
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                
                        // Login Button
                        VStack(spacing: 16) {
                            Button(action: login) {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                } else {
                                    Text("Sign In")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.blue)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                            )
                            .disabled(isLoading)
                            
                            // Forgot Password Button
                            Button(action: {
                                // Handle forgot password
                            }) {
                                Text("Forgot Password?")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                    }
                    .frame(minHeight: geometry.size.height)
                }
                
                // NavigationLink to HomeView (hidden)
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Login Error"),
                  message: Text(errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    // MARK: - Login Function with Validation and Error Handling
    func login() {
        // Basic validation
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Both fields are required."
            showingError = true
            return
        }
        
        isLoading = true
        
        // Call to our authentication manager
        AuthenticationManager.shared.authenticate(email: email, password: password) { result in
            isLoading = false
            switch result {
            case .success:
                navigateToHome = true
            case .failure(let error):
                errorMessage = error.localizedDescription
                showingError = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
