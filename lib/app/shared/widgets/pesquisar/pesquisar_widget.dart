import 'package:flutter/material.dart';

abstract class Pesquisar extends SearchDelegate<String> {
  Pesquisar({
    String searchFieldLabel = 'Pesquisar',
    TextInputType? keyboardType,
    TextInputAction textInputAction = TextInputAction.search,
  }) : super(
          searchFieldLabel: searchFieldLabel,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Faça uma Pesquisa!"),
    );
  }
}
