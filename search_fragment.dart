import 'package:app/services/firebase_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  QuerySnapshot? searchResults;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _SearchBar(
                      onQueryChanged: (query) async {
                        // search in courses collection
                        searchResults =
                            await FirebaseServices().searchCourses(query);

                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Search',
                          style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: kTextFontSize,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outlined,
                            size: kDefaultIconSize,
                            color: kSecondaryColor,
                          ),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Search Result',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: kTextFontSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResults?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      return _SearcchListItem(
                        index: index,
                        course: searchResults?.docs[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearcchListItem extends StatelessWidget {
  const _SearcchListItem({
    Key? key,
    required this.index,
    this.course,
  }) : super(key: key);

  final int index;
  final QueryDocumentSnapshot? course;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: kSecondaryColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CachedNetworkImage(
                imageUrl: course?.get('image') ?? '',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${course?.get('name')}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: kTextFontSize,
                  ),
                ),
                Text(
                  '${course?.get('startDate').toDate().toString().split(' ')[0]}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({
    Key? key,
    required this.onQueryChanged,
  }) : super(key: key);
  final Function(String) onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.search,
            size: kDefaultIconSize,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: kTitlesFontSize,
          ),
        ),
      ),
    );
  }
}
