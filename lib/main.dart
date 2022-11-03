import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  void _pushSaved(){
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved, 
            icon: Icon(Icons.list),
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
    
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
    
          final alreadySaved = _saved.contains(_suggestions[index]);
    
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: (){
              setState((){
                if(alreadySaved){
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}
