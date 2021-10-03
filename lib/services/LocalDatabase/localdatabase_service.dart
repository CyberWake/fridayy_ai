abstract class LocalDatabaseService {
  Future<String> fetchAuthKey();
  void fetchUser();
  void saveUserAuth(String authKey);
}
