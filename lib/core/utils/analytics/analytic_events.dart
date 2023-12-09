/// Constraints:
/// - Can report up to 500 different types of Events per app.
/// - Can associate up to 25 unique parameters with each Event type.
/// - Event names can be up to 40 characters long, may only contain alphanumeric characters and underscores ("_"),
///   and must start with an alphabetic character.
/// - The "firebase_", "google_" and "ga_" prefixes are reserved and should not be used.

enum AnalyticsEvent {
  signInWithGoogle,
}

enum AnalyticsParameter {
  signUpMethod,
}
