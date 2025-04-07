import 'package:flutter/material.dart';
import 'package:radio_map/widgets/tagsRadio/tags_list.dart';

class TagsListRadioScreen extends StatefulWidget {
  const TagsListRadioScreen({super.key});

  @override
  State<TagsListRadioScreen> createState() => _TagsListRadioState();
}

class _TagsListRadioState extends State<TagsListRadioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags', 
        style: TextStyle(color: Colors.white, fontFamily: 'StyleScript', fontSize: 50),
      ),
      centerTitle: false,
        
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          //CountrySearch(onSearch: _onSearch),
          Expanded(
              child: TagsList(),
            ),
        ],
      )
    );
  }
}