import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {

  @override
  _RandomWordsState createState() => _RandomWordsState();

}

class _RandomWordsState extends State<RandomWords> {

  final _randomWordPairs = <WordPair>[];

  Widget _buildList() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final _index = item ~/ 2;

          if (_index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return ListTile(
            title: Text(_randomWordPairs[_index].asPascalCase),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Pair Genarator'),
      ),
      body: _buildList(),
    );
  }

}
