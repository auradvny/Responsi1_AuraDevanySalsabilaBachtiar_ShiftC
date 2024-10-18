class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id/api'; // Base URL for the API
  static const String pariwisataBaseUrl =
      '$baseUrl/pariwisata'; // Base URL for pariwisata endpoints

  // User Authentication Endpoints
  static const String registrasi =
      '$baseUrl/registrasi'; // Registration endpoint
  static const String login = '$baseUrl/login'; // Login endpoint

  // Harga Tiket Endpoints
  static const String listHargaTiket =
      '$pariwisataBaseUrl/harga_tiket'; // Endpoint for listing ticket prices
  static const String createHargaTiket =
      '$pariwisataBaseUrl/harga_tiket'; // Endpoint for creating a ticket price

  // Dynamic URLs for ticket price management
  static String updateHargaTiket(int id) {
    return '$pariwisataBaseUrl/harga_tiket/$id/update'; // Endpoint for updating a ticket price
  }

  static String showHargaTiket(int id) {
    return '$pariwisataBaseUrl/harga_tiket/$id'; // Endpoint for showing ticket price details
  }

  static String deleteHargaTiket(int id) {
    return '$pariwisataBaseUrl/harga_tiket/$id/delete'; // Endpoint for deleting a ticket price
  }
}
