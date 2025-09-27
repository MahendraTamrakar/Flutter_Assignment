import 'package:flutter/material.dart';
import 'package:flutter_assignment/modals/product_details_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetails product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedPeriod = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.product.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Product Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.product.name,
                style: GoogleFonts.workSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 8),

            // Product Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.product.caption,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
            ),

            SizedBox(height: 24),

            // Details Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Details',
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Details Grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [

                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem('Material', widget.product.material),
                        SizedBox(height: 16),
                        _buildDetailItem('Color', widget.product.color),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem('Dimensions', widget.product.dimensions),
                        SizedBox(height: 16),
                        _buildDetailItem('Condition', widget.product.condition),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Period Selection
            Container(
              margin: EdgeInsets.only(left:16,right: 16),
              padding: EdgeInsets.only(bottom:4,top: 4),
              decoration: BoxDecoration(
                color: Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPeriodButton('Daily'),
                  SizedBox(width: 14),
                  _buildPeriodButton('Weekly'),
                  SizedBox(width: 14),
                  _buildPeriodButton('Monthly'),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Related Products Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Related Products',
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Related Products Grid
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildRelatedProduct('Sony WH-CH720N', '\$9/month', 'assets/images/headphoneSony.webp'),
                  _buildRelatedProduct('Sony Alpha', '\$14/month', 'assets/images/camera.webp'),
                  _buildRelatedProduct('Scietific Calculator', '\$2/month', 'assets/images/calculator.jpg'),
                ],
              ),
            ),

            SizedBox(height: 100), // Space for bottom button
          ],
        ),
      ),
      
      // Bottom Price and Book Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 28,right:28 ,bottom: 12, top:12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _getPriceForPeriod(),
                    style: GoogleFonts.workSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  _showBookingDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1294D4),
                  padding: EdgeInsets.only(left: 24,right:24 ,bottom: 14, top:14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),

                child: Text(
                  'Book Now',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Product Details'),
      centerTitle: true,
      actions: [
        
        IconButton(
          padding: EdgeInsets.only(right:14),
          icon: SvgPicture.asset('assets/icons/share.svg'),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF617D8A),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.workSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodButton(String period) {
    bool isSelected = selectedPeriod == period;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = period;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(255, 255, 255, 255) : Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          period,
          style: GoogleFonts.workSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black : Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Widget _buildRelatedProduct(String name, String price, String imagePath) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.workSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  String _getPriceForPeriod() {
    switch (selectedPeriod) {
      case 'Daily':
        return '\$5/day';
      case 'Weekly':
        return '\$35/week';
      case 'Monthly':
        return '\$150/month';
      default:
        return '\$150/month';
    }
  }

  void _showBookingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Book ${widget.product.name}',
          style: GoogleFonts.workSans(fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rental Period: $selectedPeriod'),
            SizedBox(height: 8),
            Text('Price: ${_getPriceForPeriod()}'),
            SizedBox(height: 16),
            Text(
              'Are you sure you want to book this item?',
              style: TextStyle(color: Color(0xFF666666)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Booking confirmed! We\'ll contact you soon.'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2196F3),
            ),
            child: Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}