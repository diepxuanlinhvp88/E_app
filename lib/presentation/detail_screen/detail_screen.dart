import 'package:flutter/material.dart';
import 'package:untitled/core/app_export.dart';
import 'package:untitled/model/product.dart';
import 'package:untitled/presentation/orders_screen/order_screen.dart';
import 'package:untitled/services/cart_service.dart';
import 'package:untitled/services/product_service.dart';
import 'package:untitled/theme/custom_text_style.dart';
import 'package:untitled/widgets/custom_elevated_button.dart';
import 'package:untitled/widgets/custom_rating_bar.dart';
import 'package:untitled/widgets/product_card.dart';
import '../../model/Cart/cart_item.dart';
import '../../model/reviews.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isExpandedDetails = false;
  bool isExpandedReviews = false;

  late Future<List<Product>> futureRelatedProducts;

  // late Future<List<Product>> jsonProduct;
  late Future<List<Product>> firestoreProductList;
  late CartService cartService;
  var userId = '';

  @override
  void initState() {
    super.initState();

    // jsonProduct = ProductService().loadProductsFromJson();
    firestoreProductList = ProductService().fetchAllProducts();
    userId = AuthService().getCurrentUser()!.uid;
    // userId = 'NOlPPPEdwEhXEfi8IBGLHFOgl9k1';
    cartService = CartService();
  }

  Future<List<Product>> fetchRelatedProducts() async {
    final products = await firestoreProductList;
    return products.take(20).toList();
  }

  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightCodeColors().deepPurpleA200,
        elevation: 1,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.homeScreen)),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cartScreen);
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
                aspectRatio: 1,
                child: CustomImageView(
                  imagePath: widget.product.img_link,
                )),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price and Discount
                Container(
                  color: LightCodeColors().deepPurpleA200,
                  height: 60.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 18.h,
                      ),
                      Text('\$ ${widget.product.discounted_price}',
                          style: CustomTextStyles.labelLargePrimary.copyWith(
                              fontSize: 20.h,
                              color: LightCodeColors().orangeA200)),
                      const SizedBox(width: 8),
                      Text(
                        '\$ ${widget.product.actual_price}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white,
                            fontSize: 20.h),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: LightCodeColors().orangeA200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '\$ ${widget.product.discount_percentage}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Product Title and Rating
                  Text('${widget.product.product_name}]',
                      style: CustomTextStyles.titleProductBlack),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '${widget.product.rating}',
                        style:
                            TextStyle(fontSize: 16, color: appTheme.orangeA200),
                      ),
                      CustomRatingBar(
                        ignoreGestures: true,
                        initialRating: widget.product.rating,
                        color: appTheme.orangeA200,
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In Stock',
                        style: CustomTextStyles.bodyMediumDeeppurpleA200_1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                            color: LightCodeColors().gray200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Quantity',
                            style: CustomTextStyles.bodySmallBlack900.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Spacer(),
                          Center(
                            child: Container(
                              height: 28.h,
                              decoration: BoxDecoration(
                                  color: LightCodeColors().gray5001,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,

                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: decrement,
                                      icon: Icon(Icons.remove)),
                                  Text('$quantity'),
                                  IconButton(
                                      onPressed: increment,
                                      icon: Icon(Icons.add))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print(userId);
                          cartService.addToCart(
                              widget.product, userId, quantity);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LightCodeColors().deepPurpleA200,
                          minimumSize: Size(3.h, 60.h),
                        ),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      SizedBox(width: 16),
                      Expanded(
                        child: Expanded(
                          child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderScreen(items: [
                                            CartItem(
                                                productId:
                                                    widget.product.product_id,
                                                quantity: quantity,
                                                productName:
                                                    widget.product.product_name,
                                                imageUrl:
                                                    widget.product.img_link,
                                                price:
                                                    widget.product.actual_price)
                                          ])));
                            },
                            text: 'Buy now',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Details
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpandedDetails = !isExpandedDetails;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Product Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              isExpandedDetails
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.about_product,
                          maxLines: isExpandedDetails ? null : 3,
                          overflow:
                              isExpandedDetails ? null : TextOverflow.ellipsis,
                        ),
                        if (!isExpandedDetails)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isExpandedDetails = true;
                              });
                            },
                            child: Text(
                              'More',
                              style: CustomTextStyles.titleSmallPrimary,
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Customer Reviews
                  Container(
                      padding: EdgeInsets.all(2), child: Customer_review()),

                  // Related Products
                  const Text(
                    'Related Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildRelatedProductItem(widget.product)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column Customer_review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Customer Reviews',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isExpandedReviews = !isExpandedReviews;
                });
              },
              child: Text(
                isExpandedReviews ? 'Show Less' : 'See All',
                style: TextStyle(color: Color(0xFFFA993A)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${widget.product.rating}',
              style: TextStyle(fontSize: 16, color: appTheme.orangeA200),
            ),
            const SizedBox(width: 4),
            CustomRatingBar(
              ignoreGestures: true,
              initialRating: widget.product.rating,
              color: appTheme.orangeA200,
            ),
            Text(
              '${widget.product.rating_count}',
              style: TextStyle(fontSize: 16, color: appTheme.orangeA200),
            ),
          ],
        ),
        Column(
          children: List.generate(
            isExpandedReviews
                ? (widget.product.reviews.length)
                : (widget.product.reviews.length > 0 ? 1 : 0),
            (index) {
              final review = widget.product.reviews[index];
              return _buildReviewItem(review);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Review review) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CircleAvatar(
            child: Text('N'.toUpperCase()),
          ),
          SizedBox(
            width: 12,
          ),
          Text(review.user_name,
              style: CustomTextStyles.titleProductBlack
                  .copyWith(fontWeight: FontWeight.normal)),
        ]),
        SizedBox(
          height: 9,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.review_title,
                style: CustomTextStyles.titleProductBlack),
            SizedBox(height: 4),
            Text(review.review_content,
                style: CustomTextStyles.bodyMediumGray200
                    .copyWith(color: Colors.black)),
          ],
        ),
      ]),
    );
  }

  Widget _buildRelatedProductItem(Product product) {
    return FutureBuilder<List<Product>>(
      future: fetchRelatedProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No related products found.'));
        } else {
          final relatedProducts = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 20,
            itemBuilder: (context, index) {
              final product = relatedProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: ProductCard(product),
              );
            },
          );
        }
      },
    );
  }
}
