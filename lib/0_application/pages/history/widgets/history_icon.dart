import 'package:cs311hw10/0_application/widgets/genshin_webview.dart';
import 'package:cs311hw10/1_domain/entities/genshin_character_entity.dart';
import 'package:flutter/material.dart';

class HistoryIcon extends StatelessWidget {
  const HistoryIcon({Key? key, required this.character}) : super(key: key);

  final GenshinCharacterEntity character;

  @override
  Widget build(BuildContext context) {
    String id = character.id;
    String url = 'https://api.genshin.dev/characters/$id/icon-big';
    print(id.contains('traveler'));
    if (id.contains('traveler')) {
      String url = 'https://api.genshin.dev/characters/$id/icon-big-lumine';
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GenshinWebView(character: character),
            ));
      },
      child: Image.network(url),
    );
  }
}
