import 'package:flutter/material.dart';

class AllUsersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          color: Color(0xff0b1035),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance: 1',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Gift: 1',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      'Wallet: 1',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Data Rows
                _buildDataRow('Complete Provider Storage', '100 '),
                _buildDataRow('Refend Storage', '50 '),
                _buildDataRow('Ref Storage', '200 '),
                _buildDataRow('Free Clicks Storage', '500 Clicks'),
                _buildDataRow('Number of Referrals', '10'),
                _buildDataRow('Unique Referrals', '8'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

