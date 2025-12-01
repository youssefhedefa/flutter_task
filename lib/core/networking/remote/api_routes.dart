class ApiRoutes {
  ApiRoutes._();

  static const String baseUrl = 'https://fakestoreapi.com/';
  static const String _authSegment = 'auth/';
  static const String _productsSegment = 'products';

  static const String login = '${_authSegment}login';
  static const String categories = '$_productsSegment/categories';
  static const String products = _productsSegment;
  static String productsByCategory(String category) => '$_productsSegment/category/$category';
  static String productDetails(int id) => '$_productsSegment/$id';
}
