import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderName;
  final String orderId;
  final double totalPrice;
  final String? productImagePath;

  const OrderTrackingScreen({
    super.key,
    required this.orderName,
    required this.orderId,
    required this.totalPrice,
    required this.productImagePath,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Order Tracking',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Info Section
              Column(
                children: [
                  // Product Icon and Details
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: widget.productImagePath != null
                              ? Image.asset(
                                  widget.productImagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _getProductIcon(widget.orderName);
                                  },
                                )
                              : _getProductIcon(widget.orderName),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Name: ${widget.orderName}',
                              style: GoogleFonts.workSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Order ID: ${widget.orderId}',
                              style: GoogleFonts.workSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Price Section
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 227, 227, 227),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.attach_money,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Total Price: \$${widget.totalPrice.toStringAsFixed(0)}',
                        style: GoogleFonts.workSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              
              // Tracking Status Section
              Text(
                'Tracking Status',
                style: GoogleFonts.workSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              
              SizedBox(height: 20),
              
              // Tracking Timeline
              _buildTrackingTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline() {
    final trackingSteps = [
      TrackingStep(
        title: 'Order Placed',
        subtitle: 'Order placed on 07/25/2025',
        isCompleted: true,
        isActive: false,
      ),
      TrackingStep(
        title: 'Order Accepted',
        subtitle: 'Order accepted on 09/25/2025',
        isCompleted: true,
        isActive: false,
      ),
      TrackingStep(
        title: 'Order Packed',
        subtitle: 'Order packed on 09/26/2025',
        isCompleted: true,
        isActive: true,
      ),
      TrackingStep(
        title: 'Order Completed',
        subtitle: 'Order completed on 09/27/2025',
        isCompleted: false,
        isActive: false,
      ),
    ];

    return Column(
      children: List.generate(trackingSteps.length, (index) {
        final step = trackingSteps[index];
        final isLast = index == trackingSteps.length - 1;
        
        return _buildTrackingStep(
          step: step,
          isLast: isLast,
        );
      }),
    );
  }

  Widget _getProductIcon(String productName) {
    IconData icon;
    Color color = Color(0xFF2196F3);
    
    if (productName.toLowerCase().contains('bike')) {
      icon = Icons.directions_bike;
    } else if (productName.toLowerCase().contains('camera') || productName.toLowerCase().contains('gopro')) {
      icon = Icons.camera_alt;
    } else if (productName.toLowerCase().contains('drone')) {
      icon = Icons.flight;
    } else if (productName.toLowerCase().contains('headphone')) {
      icon = Icons.headphones;
    } else if (productName.toLowerCase().contains('nikon') || productName.toLowerCase().contains('dslr')) {
      icon = Icons.photo_camera;
    } else {
      icon = Icons.shopping_bag;
    }
    
    return Icon(
      icon,
      size: 32,
      color: color,
    );
  }

  Widget _buildTrackingStep({
    required TrackingStep step,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: step.isCompleted ? Colors.green : Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(
                  color: step.isActive ? Colors.green : Colors.transparent,
                  width: 3,
                ),
              ),
              child: step.isCompleted
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : Container(),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: step.isCompleted ? Colors.green : Colors.grey[300],
              ),
          ],
        ),
        
        SizedBox(width: 16),
        
        // Step content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: step.isCompleted ? Colors.black : Color(0xFF999999),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  step.subtitle,
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TrackingStep {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isActive;

  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isActive,
  });
}