import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/screen/order_tracking_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Text(
          'Orders',
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color.fromARGB(255, 0, 0, 0),
              unselectedLabelColor: Color(0xFF666666),
              labelStyle: GoogleFonts.workSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.workSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Past'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Orders Tab
          _buildActiveOrders(),
          
          // Past Orders Tab
          _buildPastOrders(),
        ],
      ),
    );
  }

  Widget _buildActiveOrders() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          status: 'Pending',
          title: 'Modern Apartment',
          orderId: '#123456',
          imagePath: 'assets/images/apartment.png',
          totalPrice: 150,
          statusColor: Color.fromARGB(255, 255, 152, 0),
        ),
        SizedBox(height: 16),
        _buildOrderCard(
          status: 'Ongoing',
          title: 'Modern Apartment',
          orderId: '#789012',
          imagePath: 'assets/images/apartment2.png',
          statusColor: Color(0xFF4CAF50),
          totalPrice: 300,
        ),
      ],
    );
  }

  Widget _buildPastOrders() {
    return ListView(
       padding: EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          status: 'Completed',
          title: 'Modern Villa',
          orderId: '#456789',
          imagePath: 'assets/images/villa.jpeg',
          statusColor: Color(0xFF2196F3),
          totalPrice: 200.0,
        ),
        SizedBox(height: 16),
        _buildOrderCard(
          status: 'Completed',
          title: 'City Apartment',
          orderId: '#345678',
          imagePath: 'assets/images/city.jpg',
          statusColor: Color(0xFF2196F3),
          totalPrice: 100.0,
        ),
      ],
    );
  }

  Widget _buildOrderCard({
    required String status,
    required String title,
    required String orderId,
    required String imagePath,
    required Color statusColor,
    required double totalPrice,
  }) {
    return InkWell(
      onTap: () {
        // Navigate to Order Tracking screen (only for active orders)
        if (status == 'Pending' || status == 'Ongoing' || status == 'Processing') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderTrackingScreen(
                orderName: title,
                orderId: orderId,
                totalPrice: totalPrice,
                productImagePath: imagePath,
              ),
            ),
          );
        } else {
          // Show order details for completed/cancelled orders
          _showOrderDetails(title, orderId, status, totalPrice);
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: 8,right: 8),
        child: Row(
          children: [
            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status
                  Text(
                    status,
                    style: GoogleFonts.workSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // Title
                  Text(
                    title,
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  
                  // Order ID
                  Text(
                    'Order ID: $orderId',
                    style: GoogleFonts.workSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
            
            // Order Image
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2196F3).withOpacity(0.3),
                            Color(0xFF21CBF3).withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.apartment,
                        size: 32,
                        color: Color(0xFF2196F3),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(String title, String orderId, String status, double totalPrice) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Details',
              style: GoogleFonts.workSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildDetailRow('Product', title),
            _buildDetailRow('Order ID', orderId),
            _buildDetailRow('Status', status),
            _buildDetailRow('Total Price', "$totalPrice"),
            SizedBox(height: 20),
            if (status == 'Completed')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Add reorder functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reorder functionality coming soon!'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Reorder',
                    style: GoogleFonts.workSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.workSans(
              fontSize: 14,
              color: Color(0xFF666666),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.workSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}