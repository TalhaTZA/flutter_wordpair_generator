import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _randomWordPairsSaved = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final _index = item ~/ 2;

          if (_index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_randomWordPairs[_index]);
        });
  }

  Widget _buildRow(WordPair randomWordPair) {
    final _alreadySaved = _randomWordPairsSaved.contains(randomWordPair);

    return ListTile(
      title: Text(
        randomWordPair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(_alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: _alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            _randomWordPairsSaved.remove(randomWordPair);
          } else {
            _randomWordPairsSaved.add(randomWordPair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> _tiles =
          _randomWordPairsSaved.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 16.0),
          ),
        );
      });

      final List<Widget> _divided =
          ListTile.divideTiles(tiles: _tiles, context: context).toList();

      return Scaffold(
        appBar: AppBar(title: Text('Saved Word Pairs')),
        body: ListView(children: _divided),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Pair Genarator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildList(),
    );
  }
}
