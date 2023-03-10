import 'package:heatable_poki/data/model/pokemon.dart';

List<Pokemon> pokemonListFromList(List<dynamic> list, int page) {
  List<Pokemon> listPokemon = <Pokemon>[];
  list.forEach((element) {
    listPokemon.add(Pokemon.fromJson(element, page));
  });
  return listPokemon;
}

class PokemonResponse {
  PokemonResponse(
      this.count, this.next, this.previous, this.results, this.page);

  int count;
  String? next;
  String? previous;
  int page;
  List<Pokemon> results;

  factory PokemonResponse.fromJson(Map<String, dynamic> json, int page) =>
      PokemonResponse(
        json["count"] as int,
        json["next"] as String?,
        json["previous"] as String?,
        pokemonListFromList(json["results"], page),
        page,
      );
}
