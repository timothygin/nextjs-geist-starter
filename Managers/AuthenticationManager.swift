import Foundation

enum AuthenticationError: LocalizedError {
    case invalidCredentials
    case networkError
    case invalidEmail
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "The email or password is incorrect."
        case .networkError:
            return "A network error occurred. Please try again later."
        case .invalidEmail:
            return "Please enter a valid email address."
        }
    }
}

@MainActor
final class AuthenticationManager: ObservableObject {
    static let shared = AuthenticationManager()
    
    @Published private(set) var isAuthenticated = false
    @Published private(set) var isLoading = false
    
    private init() {}
    
    /// Validates email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /// Modern async/await authentication process
    func authenticate(email: String, password: String) async throws {
        guard isValidEmail(email) else {
            throw AuthenticationError.invalidEmail
        }
        
        isLoading = true
        defer { isLoading = false }
        
        // Simulate network request
        try await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        // Dummy credentials for simulation:
        if email.lowercased() == "test@example.com" && password == "password" {
            isAuthenticated = true
        } else {
            throw AuthenticationError.invalidCredentials
        }
    }
    
    /// Signs out the current user
    func signOut() {
        isAuthenticated = false
    }
}
