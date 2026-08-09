import 'package:firebase_setup/route/route.dart';
import 'package:firebase_setup/route/route_generator.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.location_on_outlined, 'label': 'Address'},
    {'icon': Icons.credit_card_outlined, 'label': 'Payment method'},
    {'icon': Icons.confirmation_number_outlined, 'label': 'Voucher'},
    {'icon': Icons.favorite_border, 'label': 'My Wishlist'},
    {'icon': Icons.inventory_2_outlined, 'label': 'Add Products'},
    {'icon': Icons.star_border, 'label': 'Rate this app'},
    {'icon': Icons.logout, 'label': 'Log out'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.pink[100],
                    backgroundImage: AssetImage(
                      'assets/images/profile_avatar.png',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Simrika Raul',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'raulsimrika@gmail.com',
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.black),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(_menuItems.length, (index) {
                    final item = _menuItems[index];
                    final isLast = index == _menuItems.length - 1;
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            item['icon'] as IconData,
                            color: Colors.black54,
                          ),
                          title: Text(
                            item['label'] as String,
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing: isLast
                              ? null
                              : Icon(
                                  Icons.chevron_right,
                                  color: Colors.black38,
                                ),
                          onTap: () {
                            if (item['label'] == 'Add Products') {
                              RouteGenerator.navigateToPage(
                                context,
                                Routes.addProductRoute,
                              );
                            }
                          },
                        ),
                        if (!isLast)
                          Divider(height: 1, indent: 20, endIndent: 20),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
