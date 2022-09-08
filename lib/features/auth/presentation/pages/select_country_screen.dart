import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';


class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({Key? key}) : super(key: key);

  @override
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  List<dynamic>? dataRetrieved; // data decoded from the json file
  List<dynamic>? data; // data to display on the screen
  final _searchController = TextEditingController();
  var searchValue = "";
  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future _getData() async {
    final String response =
    await rootBundle.loadString('assets/country_cities.json');
    dataRetrieved = await json.decode(response) as List<dynamic>;
    setState(() {
      data = dataRetrieved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Select Country"),
            previousPageTitle: "Edit Number",
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20,),),
          SliverToBoxAdapter(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CupertinoSearchTextField(
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                controller: _searchController,
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate((data != null)
                ? data!
                .where((e) => e['name']
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase()))
                .map((e) => CupertinoListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              onTap: () {
                print(e['name']);
                Navigator.pop(context,
                    {"name": e['name'], "code": e['dial_code']});
              },
              title: Text(e['name']),
              trailing: Text(e['dial_code']),
            ))
                .toList()
                : [const Center(child: Text("Loading"))]),
          )
        ],
      ),
    );
  }
}