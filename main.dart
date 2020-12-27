import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Searchable Listview demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  String _selected;

  Set<String> list = {
    'apple',
    'apricot',
    'banana',
    'blackberry',
    'blueberry',
    'grape',
    'grape fruit',
    'kiwi',
    'lemon',
    'lime',
    'orange',
    'peach',
    'pear',
    'plum',
    'raspberry',
    'strawberry',
  };

  List<String> _sortedList = [];
  List<String> _filteredList = [];

  @override
  void initState() {
    super.initState();
    _sortedList = List.from(list);
    _sortedList.sort();
    _filteredList = _sortedList;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateList(String str) {
    if(str.isEmpty){
      setState(() {
        _filteredList = List.from(list);
      });
    }
    else{
      setState(() {
        var filtered = list.where((list) => list.contains(str));

        _filteredList  = filtered.toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: ListTile(
                  title: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Find an item',
                    ),
                    controller: _controller,
                    onChanged: (text) {
                      updateList(_controller.text);
                    },
                  ),
                  trailing: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: _filteredList.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0? Colors.white : Color(0xFFEEEEEE),
                    ),
                    child: ListTile(
                      tileColor: _selected == _filteredList[index]? Colors.yellow : Colors.transparent,
                      title: Text('${_filteredList[index]}'),
                      onTap: () {
                        setState(() {
                          _selected = _filteredList[index];
                        });
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item Selected: ${_filteredList[index]}'),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
