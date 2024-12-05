import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map amiibo;

  // Constructor to receive the Amiibo details
  DetailScreen({required this.amiibo});

  // Function to add the Amiibo to favorites (you can implement it as before)
  Future<void> _addToFavorites(Map amiibo) async {
    // Implement favorite functionality, e.g., using SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    // Fetching the details from the amiibo map
    String name = amiibo['name'] ?? 'Unknown';
    String amiiboSeries = amiibo['amiiboSeries'] ?? 'Unknown';
    String character = amiibo['character'] ?? 'Unknown';
    String gameSeries = amiibo['gameSeries'] ?? 'Unknown';
    String imageUrl = amiibo['image'] ?? '';
    String type = amiibo['type'] ?? 'Unknown';
    String head = amiibo['head'] ?? 'Unknown';
    String tail = amiibo['tail'] ?? 'Unknown';
    String releaseAU = amiibo['release']['au'] ?? 'Unknown';
    String releaseEU = amiibo['release']['eu'] ?? 'Unknown';
    String releaseJP = amiibo['release']['jp'] ?? 'Unknown';
    String releaseNA = amiibo['release']['na'] ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blueAccent,
        actions: [
          // Favorite button to add the item to favorites
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () => _addToFavorites(amiibo),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the Amiibo image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Display Amiibo name and series
              Text(
                name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 8),
              _buildInfoCard('Amiibo Series', amiiboSeries),
              _buildInfoCard('Game Series', gameSeries),
              _buildInfoCard('Character', character),
              _buildInfoCard('Type', type),

              SizedBox(height: 16),

              // Display head and tail values in styled cards
              _buildInfoCard('Head', head),
              _buildInfoCard('Tail', tail),

              SizedBox(height: 16),

              // Display release dates for different regions in a styled card
              Text(
                'Release Dates:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              _buildInfoCard('AU', releaseAU),
              _buildInfoCard('EU', releaseEU),
              _buildInfoCard('JP', releaseJP),
              _buildInfoCard('NA', releaseNA),

              SizedBox(height: 30),
              // Add any other UI elements you may need
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build a reusable info card
  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
