import 'package:flutter/material.dart';

abstract class Pesquisar extends SearchDelegate<String> {
  final String searchFieldLabel;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  Pesquisar({
    this.searchFieldLabel='Pesquisar',
    this.keyboardType,
    this.textInputAction = TextInputAction.search,
  }) : super(
            searchFieldLabel: searchFieldLabel,
            keyboardType: keyboardType,
            textInputAction: textInputAction);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Faça uma Pesquisa!"),
    );
    // }
  }
}
