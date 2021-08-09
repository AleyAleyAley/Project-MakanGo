class InternalServerException implements Exception {
  @override
  String toString() => 'Internal server error';
}

class InvalidCredentialsException implements Exception {
  @override
  String toString() => 'Invalid credentials';
}

class InvalidSessionException implements Exception {
  @override
  String toString() => 'Invalid session';
}

class PostNotFoundException implements Exception {
  @override
  String toString() => 'Post not found';
// }
// class DrinkVendorException implements Exception{
//   @override
//   String toString()=>"Drink Vendor";
}
