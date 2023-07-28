import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/product_model.dart';
import 'package:flutter_ecommerce/service/product_service.dart';
import 'package:flutter_ecommerce/widgets/product_large.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ProductService _productService = ProductService();

  String _searchQuery = '';
  List<Product> _searchResults = [];

  void _loadData(String query) {
    _productService.searchProducts(query).then((value) {
      _searchResults = value!;
      debugPrint(_searchResults.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: Color.fromARGB(255, 19, 57, 86),
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 3,
                    color: Color.fromARGB(255, 19, 57, 86),
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Enter search query',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 19, 57, 86),
                  ),
                  onPressed: () {
                    _loadData(_searchQuery);
                  },
                ),
              ),
              onChanged: (value) {
                setState(
                  () {
                    _searchQuery = value;
                    _loadData(_searchQuery);
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          Text('Search results for: $_searchQuery'),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? const Text('No results found.')
                : SingleChildScrollView(
                    child: Column(
                      children: _searchResults
                          .map(
                              (product) => LargeProductWidget(product: product))
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
