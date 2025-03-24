import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List> getAllProducts(int page) async {
    int limit = 30;
    int skip = (page - 1) * limit;

    final String url = "https://dummyjson.com/products?skip=$skip&limit=$limit";

    final response = await http.get(Uri.parse(url));
    final decodedBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return decodedBody['products'];
    } else {
      throw Exception('Error fetching the products');
    }
  }
}
