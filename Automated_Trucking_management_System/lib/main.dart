import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Trucking Platform', style: TextStyle(fontFamily: 'Poppins')),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.person, color: Colors.black),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.yellow[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                ),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 24)),
              ),
              _buildDrawerItem(Icons.dashboard, 'Dashboard'),
              _buildDrawerItem(Icons.person, 'My Profile'),
              _buildDrawerItem(Icons.local_shipping, 'My Loads'),
              _buildDrawerItem(Icons.directions_car, 'My Trucks'),
              _buildDrawerItem(Icons.description, 'Manage Documents'),
              _buildDrawerItem(Icons.attach_money, 'Earnings/Billing'),
              _buildDrawerItem(Icons.settings, 'Settings'),
              _buildDrawerItem(Icons.logout, 'Logout'),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back, User 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Loads Posted', '25', Icons.upload_rounded),
                _buildStatCard('Loads Delivered', '18', Icons.check_circle),
                _buildStatCard('Active Trucks', '5', Icons.local_shipping),
                _buildStatCard('Earnings This Month', '\$12,000', Icons.monetization_on),
              ],
            ),
            SizedBox(height: 30),
            Text('Latest Loads', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
            Expanded(
              child: Center(
                child: Text('Load Table Placeholder', style: TextStyle(fontFamily: 'Poppins')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(fontFamily: 'Poppins')),
      onTap: () {
        // Handle navigation
      },
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Container(
        width: 150,
        height: 120,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.yellow[50],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.redAccent),
            SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
            Text(title, style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
          ],
        ),
      ),
    );
  }
}
