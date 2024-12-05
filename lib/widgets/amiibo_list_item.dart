import 'package:flutter/material.dart';

class AmiiboListItem extends StatelessWidget {
  final Map amiibo;
  final Function onFavorite;
  final Function onTap;

  AmiiboListItem({
    required this.amiibo,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(amiibo['image']),
      title: Text(amiibo['name']),
      subtitle: Text(amiibo['gameSeries']),
      trailing: IconButton(
        icon: Icon(Icons.favorite_outline),
        onPressed: () => onFavorite(),
      ),
      onTap: () => onTap(),
    );
  }
}
