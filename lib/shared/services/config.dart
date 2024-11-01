enum Environment {
  staging,
  production,
}

class EnvironmentConfig {
  static const String baseapiUrl = String.fromEnvironment('API_URL');
  static Environment _environment = Environment.staging;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  static String get environmentPath => _environment.name;

  static String get rootCollection => _environment.name;

  // Base paths for different collections
  static String get usersCollection => '$rootCollection/$rootCollection/users';
  static String get businessesCollection =>
      '$rootCollection/$rootCollection/businesses';
  static String get ordersCollection =>
      '$rootCollection/$rootCollection/orders';
  static String get ticketsCollection =>
      '$rootCollection/$rootCollection/tickets';

  // User subcollections paths
  static String userTicketsCollection(String userId) =>
      '$usersCollection/$userId/tickets';
  static String userAddressCollection(String userId) =>
      '$usersCollection/$userId/address';
  static String userAccountCollection(String userId) =>
      '$usersCollection/$userId/account';

  // Account subcollections
  static String userBusinessDetailsCollection(String userId) =>
      '$userAccountCollection/$userId/businessDetails';
  static String userOrderHistoryCollection(String userId) =>
      '$userAccountCollection/$userId/orderHistory';

  // Administrative collections
  static String get deactivatedAccountCollection =>
      '$rootCollection/$rootCollection/deactivatedAccount';
  static String get bannedAccountCollection =>
      '$rootCollection/$rootCollection/bannedAccount';
}
