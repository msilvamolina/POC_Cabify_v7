import 'package:flutter/material.dart';

import 'place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == "" ? null : apiClient.fetchSuggestions(query),
      builder: (context, snapshot) => query == ""
          ? Container(child: Text("Ingresá tu dirección"))
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, i) => ListTile(
                    title: Text((snapshot.data[i] as Suggestion).description),
                    onTap: () {},
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Center(child: CircularProgressIndicator())),
    );
  }
}
