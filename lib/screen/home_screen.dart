import 'package:flutter/material.dart';
import 'package:flutter_assignment/modals/category_modal.dart';
import 'package:flutter_assignment/modals/featured_items_modal.dart';
import 'package:flutter_assignment/modals/product_details_model.dart';
import 'package:flutter_assignment/screen/product_details_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModal> categories =[];
  List<FeaturedItemsModal> featuredItems = [];
  List<ProductDetails> popularRental = [];

  
  /* @override
  void initState() {
    super.initState();
    // Set your preferred status bar style for home screen
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color.fromARGB(0, 255, 255, 255),
      statusBarIconBrightness: Brightness.dark, // Dark icons on light background
      statusBarBrightness: Brightness.light,    // For iOS
    ));
  } */

  void _getIntialInfo()
  {
    categories = CategoryModal.getCategories();
    featuredItems = FeaturedItemsModal.getFeaturedItems();
    popularRental = ProductDetails.getProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    _getIntialInfo();
    return Scaffold(
      appBar: appbar(),
      body: ListView(
        children: [
          _searchField(),
          SizedBox(height: 26),
          _categories(),
          SizedBox(height:  34),
          _featuredItems(),
          SizedBox(height:  34),
          _popularRentals(),
          SizedBox(height: 36),
        ],
      ),
    );
  }

  Column _popularRentals() {

    final filteredRentals = popularRental.where((rental) => rental.popularRental == true).toList();
  
    // Calculate dynamic height based on number of filtered items
    final itemsPerRow = 2;
    final itemHeight = 280.0;
    final crossAxisSpacing = 12.0;
    final numberOfRows = (filteredRentals.length / itemsPerRow).ceil();
    final dynamicHeight = (numberOfRows * itemHeight) + ((numberOfRows - 1) * crossAxisSpacing);
    
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          "Popular Rentals",
          style: GoogleFonts.workSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 26),
      
      // Show message if no popular rentals found
      if (filteredRentals.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Center(
            child: Text(
              "No popular rentals available",
              style: GoogleFonts.workSans(
                fontSize: 16,
                color: Color(0xFF617D8A),
              ),
            ),
          ),
        )
      else
        SizedBox(
          height: dynamicHeight,
          child: GridView.builder(
            itemCount: filteredRentals.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 20, right: 20),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,           // max 2 items per row
              crossAxisSpacing: 12,        // horizontal space between items
              mainAxisSpacing: 12,         // vertical space between items
              mainAxisExtent: 280,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  // Navigate to ProductDetailsScreen with selected product data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        product: filteredRentals[index], // Passes the selected ProductDetails object
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        filteredRentals[index].imagePath,
                        fit: BoxFit.cover,
                        height: 200, // Fixed height for consistency
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredRentals[index].name,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.workSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            filteredRentals[index].caption,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF617D8A),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    ],
  );
}

  Column _featuredItems() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Featured Items",
                style: GoogleFonts.workSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 26), 
            SizedBox(
              //margin: EdgeInsets.only(left: 20, right: 20),
              height: 400,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 20, left: 20), 
                separatorBuilder: (context, index) => SizedBox(width: 18),
                itemCount: featuredItems.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(featuredItems[index].imgPath,
                            width: 300,
                            height: 300,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                featuredItems[index].name,
                                style: GoogleFonts.workSans(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.start,
                                featuredItems[index].caption,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFF617D8A),
                          
                                ),
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  
                  );
                }
              ),
            ),
          ],
        );
  }

  SizedBox _categories() {
    return SizedBox(
          height: 42,
          child:ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(width: 18),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24), // dynamic width
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index].name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                    
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }
          ),
        );
  }

  AppBar appbar() {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      title: Text("Home"),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.all(14),
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/cart.svg',
              width: 27,
              height: 27,
            ),
          ),
        ),
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: EdgeInsets.only(top:20, right:20, left:20),
      child: TextField(
        decoration: InputDecoration(
          fillColor: Color(0xFFF0F2F5),
          filled: true,
          contentPadding: EdgeInsets.all(15),
          hintText: "Search for Items",
          hintStyle: GoogleFonts.workSans(
            fontSize: 18,
            color: Color(0xFF617D8A),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/icons/Search.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xFF617D8A),
                BlendMode.srcIn,
              ),
              
              width: 25,
              height: 25,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 55, 
            minHeight: 20,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          )
        ),
      ),
    );
  }
}