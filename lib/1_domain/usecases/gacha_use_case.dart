import 'dart:math';

import 'package:cs311hw10/1_domain/entities/genshin_character_entity.dart';
import 'package:cs311hw10/2_data/repositories/gacha_repo_impl.dart';
import 'package:flutter/material.dart';

class GachaUseCase extends ChangeNotifier {
  GenshinCharacterEntity? randomCharacter;
  List<String>? nations;
  Map<String, List<String>>? charWithNation;
  final gachaRepo = GachaRepoImpl();

  Future<GenshinCharacterEntity> getRandomCharacter() async {
    final characters = await gachaRepo.getCharactersFromApi();
    if (nations == null && charWithNation == null) {
      nations = await gachaRepo.getNationsFromApi();
      charWithNation = await generateMapCharacter(characters);
      nations = charWithNation!.keys.toList();
    }
    final randomNations = nations![Random().nextInt(nations!.length)];
    final randomCharacters = charWithNation![randomNations]![
        Random().nextInt(charWithNation![randomNations]!.length)];
    randomCharacter = await gachaRepo.getCharacterInfo(randomCharacters);
    notifyListeners();
    return randomCharacter!;
  }

  Future<Map<String, List<String>>> generateMapCharacter(
      List<String> characters) async {
    Map<String, List<String>> charWithNation = {};
    for (var char in characters) {
      GenshinCharacterEntity tempChar = await gachaRepo.getCharacterInfo(char);
      if (charWithNation.containsKey(tempChar.nation.toLowerCase())) {
        charWithNation[tempChar.nation.toLowerCase()]!.add(tempChar.id);
      } else {
        nations!.add(tempChar.nation.toLowerCase());
        charWithNation[tempChar.nation.toLowerCase()] = [tempChar.id];
      }
    }
    return charWithNation;
  }
}
