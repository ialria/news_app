import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsletter_app/news_item.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

// when we place vertical list view in column we place it in expanded widget-in case of horizontal list view we place it in sized box

class _NewsPageState extends State<NewsPage> {
  Future<List<NewsItem>> getNewsData() async {
    //   fetch the data here
    Response response = await get(
      Uri.parse(
        'http://androidstudent.com/apis/thenews/news.php?category=${chipItems[selectedIndex]["url"]}',
      ),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(
        response.body,
      ); // all the data is in json format in kind-of a list of map or objects that are stored in key value pairs-pass data object by object one by one to get a news item
      List<NewsItem> newsList = data.map((e) => NewsItem.fromJson(e)).toList();
      // print(newsList.length);
      return newsList;
    } else {
      throw Exception("Could not load data");
    }
  }

  void launchNewsLink(String link) async {
    Uri uri = Uri.parse(link);

    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to launch link url")));
    }
  }

  late Future<List<NewsItem>> newsList;
  List<Map<String, String>> chipItems = [
    {'name': 'World', "url": "world"},
    {'name': 'Trending', "url": "trending"},
    {'name': 'Technology', "url": "technology"},
    {'name': 'Health', "url": "health"},
    {'name': 'Sports', "url": "sports"},
    {'name': 'Entertainment', "url": "entertainment"},
    {'name': 'Science', "url": "science"},
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsList = getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: chipItems.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      newsList = getNewsData();
                    });
                  },
                  child: Chip(
                    backgroundColor: selectedIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    labelStyle: selectedIndex == index
                        ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : Theme.of(context).textTheme.bodyMedium,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: Text('${chipItems[index]["name"]}'),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: newsList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text("Error! ${snapshot.error}"),
                      SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            newsList = getNewsData();
                          });
                        },
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final newsList = snapshot.data!;
                return ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    final newsItem = newsList[index];
                    if (index == 0) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              launchNewsLink(newsItem.link);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Image.network(
                                        newsItem.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(newsItem.publishDate),
                                  Text(
                                    newsItem.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    newsItem.detail,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              launchNewsLink(newsItem.link);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,

                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: AspectRatio(
                                        aspectRatio: 4 / 3,
                                        child: Image.network(
                                          newsItem.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      children: [
                                        Text(newsItem.publishDate, maxLines: 1),
                                        Text(
                                          newsItem.title,
                                          maxLines: 2,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          newsItem.detail,
                                          maxLines: 3,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(children: [Text("No data Available")]),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
