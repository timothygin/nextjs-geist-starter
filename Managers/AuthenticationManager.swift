import Foundation

enum AuthenticationError: LocalizedError {
    case invalidCredentials
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "The email or password is incorrect."
        case .networkError:
            return "A network error occurred. Please try again later."
        }
    }
}

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    /// Simulates an asynchronous authentication process.
    func authenticate(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Simulate networking delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // Dummy credentials for simulation:
            if email.lowercased() == "test@example.com" && password == "password" {
                completion(.success(()))
            } else {
                completion(.failure(AuthenticationError.invalidCredentials))
            }
        }
    }
}
