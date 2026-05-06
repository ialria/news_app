import 'package:newsletter_app/live_news_page.dart';
import 'package:flutter/material.dart';
import 'package:newsletter_app/news_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
Widget currentPage=NewsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Live"),
        actions: [
PopupMenuButton(
  itemBuilder: (context) {
  return [
    PopupMenuItem(child: Text("Rate this App")),
PopupMenuItem(child: Text("Share")),
  ];
},)        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(8),
              child: SizedBox(
                // height: 60,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(radius: 36,
                    backgroundColor: Colors.grey,),
                    SizedBox(height: 12,),
                    Text("News Live",
                    style: Theme.of(context).textTheme.titleMedium
                      ,),
                    // SizedBox(height: 12,),
                    Text("powered by thenews.com.pk",
                      style: Theme.of(context).textTheme.bodyMedium
                      ,),
                  ],
                ),
              ),

            ),

            ListTile(
              selected: currentPage is NewsPage,
              onTap: () {
if(currentPage is! NewsPage)
  {
    setState((){
      currentPage=NewsPage();
    });

  }
Navigator.of(context).pop();
            },
            title: Text("Home"),
            leading: Icon(Icons.home),),
            ListTile(
              selected: currentPage is LiveNews,
              onTap: () {
              if(currentPage is! LiveNews)
              {
                setState((){
                  currentPage=LiveNews();
                });
              }
              Navigator.of(context).pop();// to close the drawer
            },
              title: Text("Watch Live News"),
              leading: Icon(Icons.tv),),
            ListTile(onTap: () {

            },
              title: Text("Shop"),
              leading: Icon(Icons.shopping_cart),),
            ListTile(onTap: () {

            },
              title: Text("Subscribe"),
              leading: Icon(Icons.check),),
            ListTile(onTap: () {

            },
              title: Text("Settings"),
              leading: Icon(Icons.settings),),
            ListTile(onTap: () {

            },
              title: Text("Careers"),
              leading: Icon(Icons.cases_outlined ),)
          ],
        ),
      ),
      body: currentPage,
    );
  }
}
