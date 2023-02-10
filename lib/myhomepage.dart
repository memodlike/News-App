import 'package:flutter/material.dart';
import 'dart:math';
import 'package:english_words/english_words.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _iter = false;
  final ScrollController _scrollController = ScrollController();
  final List<int> _items = List.generate(20, (i) => i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white12,
        title: const Text(
          'News List',
          style: TextStyle(
            fontSize: 39,
            color: Colors.blue,
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return _iter ? _buildItemHorizan(index) : _buildItemList(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _iter = !_iter;
          });
        },
        child: _iter ? Icon(Icons.view_module) : Icon(Icons.list),
      ),
    );
  }

  Widget _buildItemHorizan(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(generateWordPairs().first.asPascalCase),
          SizedBox(height: 10),
          FutureBuilder(
            future: _loadImage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  snapshot.data ?? '',
                  fit: BoxFit.cover,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> _loadImage() async {
    return 'https://picsum.photos/id/${Random().nextInt(100)}/200/300';
  }

  Widget _buildItemList(int index) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://picsum.photos/id/${Random().nextInt(100)}/200/300'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            generateWordPairs().first.asPascalCase,
          ),
        ],
      ),
    );
  }
}
