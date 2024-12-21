import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/presentation/home_screen/provider/home_screen_provider.dart';

import '../../theme/theme_helper.dart';
import '../../widgets/product_card.dart';
import '../detail_screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isClickSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.deepPurpleA200,
        elevation: 0,
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              isClickSearch = false;
              print(isClickSearch);
              // Update search results when input changes
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isClickSearch = true;
                print(isClickSearch);
              });
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: isClickSearch
          ? SingleChildScrollView(
            child: Container(
                color: Colors.grey[60],
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSearchGrid(context)),
              ),
          )
          : Container(
              color: Colors.grey[60],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: searchController.text.isEmpty
                    ? Center(child: Text('Enter search keywords...'))
                    : _buildSearchResults(context),
              ),
            ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final provider = context.watch<HomeScreenProvider>();
    final filteredProducts = provider.filterProducts(searchController.text);

    if (filteredProducts.isEmpty) {
      return Center(child: Text('No products found.'));
    }

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        print(isClickSearch);
        return ListTile(
          title: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(2),
            child: Row(
              children: [
                Image.network(
                  product.img_link,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    product.product_name,
                    style: CustomTextStyles.titleProductBlack.copyWith(
                        overflow: TextOverflow.ellipsis, fontSize: 16),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSearchGrid(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, homeProvider, child) {
        final filteredProducts =
            homeProvider.filterProducts(searchController.text);

        if (filteredProducts.isEmpty) {
          return Center(child: Text('No related products found.'));
        }
        print(isClickSearch);

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredProducts.length > 20 ? 20 : filteredProducts.length,
          // Hiển thị tối đa 6 sản phẩm
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
              child: ProductCard(product),
            );
          },
        );
      },
    );
  }
}
