import 'package:flutter/material.dart';
import 'package:radio_map/core/radio_api_service.dart';
import 'package:radio_map/domain/model/tag_detail.dart';
import 'package:radio_map/widgets/tagsRadio/radio_list_by_tag.dart';

class TagsList extends StatefulWidget {
  const TagsList({super.key});

  @override
  State<TagsList> createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {
  List<TagDetail> _tags = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTags();
  }

  Future<void> _fetchTags() async {
    if(!mounted) return;
    try {
      final tags = await RadioApiService.getTags(); 
      setState(() {
        _tags = tags;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_tags.isEmpty) return const Center(child: Text("Not tags found"));

    return ListView.builder(
      itemCount: _tags.length,
      itemBuilder: (context, index) {
        final tag = _tags[index];
        return ListTile(
          title: Text(tag.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RadioListByTag(tag: tag),
              ),
            );
          },
        );
      },
    );
  }
}
