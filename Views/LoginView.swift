import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var showingError: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToHome: Bool = false
    
    var body: some View {
        ZStack {
            // Background image using AsyncImage
            AsyncImage(url: URL(string: "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            
            VStack(spacing: 20) {
                // App Logo/Title
                Text("SwiftLogin")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                // Form inputs
                VStack(spacing: 15) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Login Button with loading indicator
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Button(action: login) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }
                
                // NavigationLink to HomeView (hidden)
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView()
                }
            }
            .padding()
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
