import 'package:flutter/material.dart';
import 'package:newsletter_app/watch_channel.dart';
class LiveNews extends StatefulWidget {
  const LiveNews({super.key});

  @override
  State<LiveNews> createState() => _LiveNewsState();
}

class _LiveNewsState extends State<LiveNews> {

  List<Map<String, String>> newsChannel=[

    {"name":"ARY NEWS LIVE", "image": "https://img.youtube.com/vi/vYTfRrA0rBw/maxresdefault.jpg", "ytVideoID": "vYTfRrA0rBw"},
    {"name":"GEO NEWS LIVE", "image": "https://img.youtube.com/vi/_FwympjOSNE/maxresdefault.jpg", "ytVideoID": "_FwympjOSNE"},
    {"name":"DUNYA NEWS LIVE", "image": "https://img.youtube.com/vi/GlHSFtTFfJE/maxresdefault.jpg", "ytVideoID": "GlHSFtTFfJE"}
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: newsChannel.length,
        itemBuilder: (context, index) {
        return Card(

          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
          child: InkWell(
            onTap: () {
Navigator.of(context).push(MaterialPageRoute(builder: (context) => WatchChannelPage(name: newsChannel[index]["name"]!,videoId: newsChannel[index]["ytVideoID"]!),));
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(newsChannel[index]["image"]!,
                    fit: BoxFit.cover,),
                  ),
                  SizedBox(height: 12,),
                  Text("${newsChannel[index]["name"]}"),
                  // SizedBox(height: 12,),

                ]
              ),
            ),
          ),
        );
          
      },),
    );
  }
}
