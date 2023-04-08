import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/news.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, required this.newsList, required this.index});
  final List<News> newsList;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: newsList[index].urlToImage.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: newsList[index].urlToImage,
              width: 100,
              height: 100,
            )
          : Container(
              color: Colors.black,
              width: 100,
              height: 100,
            ),
      title: Text(
        newsList[index].title,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        newsList[index].description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    );
  }
}
