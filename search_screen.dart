import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _recent_search = [];
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: const Text('Search'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: CustomScrollView(slivers: [
          // search input field with saerch icon and clear button
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,

                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(left: 14.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _textController.text = '';
                          },
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _recent_search.add(_textController.text);
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          // tags for previous search
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Recent Search',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _recent_search.clear();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // wrap _buidChip()
          SliverToBoxAdapter(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recent_search.map((e) => _buildChip(e)).toList(),
              ),
            ),

          // text title search result
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Search Result',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          // search result 10 list of cards with placeholder images
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text('Search Result ${index}'),
                  subtitle: Text('Date ${index}'),
                ),
              ),
            ),
          ),
        ]));
  }

// create chip with remove button
  Widget _buildChip(String text) {
    return Chip(
      label: Text(text),
      deleteIcon: const Icon(Icons.cancel),
      backgroundColor: Colors.grey.shade100,
      onDeleted: () {},
    );
  }
}
