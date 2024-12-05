import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'home_screen.dart'; // Make sure to import HomeScreen

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map> _favorites = []; // List of favorite items

  // Load favorites from SharedPreferences
  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    setState(() {
      _favorites = favorites
          .map((e) => json.decode(e) as Map)
          .toList(); // Decode the JSON
    });
  }

  // Remove an item from the favorites list
  void _removeFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    _favorites.removeAt(index); // Remove from the list
    await prefs.setStringList(
        'favorites',
        _favorites
            .map((e) => json.encode(e))
            .toList()); // Save updated list to SharedPreferences
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Karakter Telah Dihapus Dari Favorit')));
    setState(() {});
  }

  // Navigate between screens using BottomNavigationBar
  int _selectedIndex = 1; // Set the default screen as FavoriteScreen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      // Stay on Favorite Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FavoriteScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites(); // Load favorites when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'No favorites added yet.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final amiibo = _favorites[index]; // Get the Amiibo data

                return Dismissible(
                  key: Key(amiibo['name']), // Use name as key
                  onDismissed: (direction) {
                    // Remove favorite item on swipe
                    _removeFavorite(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ), // Red background on swipe
                  direction: DismissDirection.endToStart,
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          amiibo['image'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        amiibo['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        amiibo['gameSeries'],
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
