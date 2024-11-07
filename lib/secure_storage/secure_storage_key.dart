enum SecureStorageKey {
  userToken(rawValue: "User-Token");

  final String rawValue;

  const SecureStorageKey({required this.rawValue});
}
