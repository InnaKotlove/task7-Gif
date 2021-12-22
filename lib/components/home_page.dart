import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task7/components/search_gifs.dart';
import 'package:task7/helpers/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //массив для ссылок на гифки
  final _gifsUrl = <String>[];
  String defaultGif =
      "https://media1.giphy.com/media/mlvseq9yvZhba/giphy.gif";

  void updateData(Map<String, dynamic>? gifData) {
    setState(() {
      if (gifData != null && gifData.containsKey('data') && gifData["data"].isNotEmpty) {
        debugPrint("from home_page updateData:");
        debugPrint(jsonEncode(gifData));
        int count = min(numberOfGifs, gifData["data"].length);
        for (int i = 0; i < count; i++) {
          _gifsUrl.add(
              gifData["data"][i]["images"]["fixed_width"]["url"].toString());
        }
      } else {
        for (int i = 0; i < numberOfGifs; i++) {
          _gifsUrl.add(defaultGif);
        }
      }
    });
  }


  _getGifs(searchString) async {
    debugPrint("from home_page _getGifs:");
    debugPrint(searchString);
    //при каждом новом поиске предыдущие ссылки на гифки очищаются
    _gifsUrl.clear();
    try {
      Map<String, dynamic>? dataDecoded;

      if (searchString != "") {
        dataDecoded = await GifsFetch.getGifs(searchString);
      }
      updateData(dataDecoded);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: "Search Giphy"),
                  onSubmitted: (String searchString) => _getGifs(searchString),
                ),
                if (_gifsUrl.isNotEmpty)
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 600,
                          child: ListView.builder(
                              itemCount: _gifsUrl.length ~/ 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(children: [
                                  Image.network(
                                    _gifsUrl[index * 2],
                                    width: 185,
                                  ),
                                  Image.network(
                                    _gifsUrl[index * 2 + 1],
                                    width: 185,
                                  ),
                                ]);
                              })))
              ],
            ),
          ),
        ));
  }
}

