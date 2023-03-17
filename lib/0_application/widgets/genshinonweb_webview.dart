import 'dart:html';

import 'package:cs311hw10/1_domain/entities/genshin_character_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:cs311hw10/character_number.dart';
import 'dart:ui' as ui;

class GenshinOnWebWebView extends StatelessWidget {
  const GenshinOnWebWebView({super.key, required this.character});
  final GenshinCharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final IFrameElement iFrame = IFrameElement();
    iFrame.src =
        'https://genshin.hoyoverse.com/en/character/${character.nation.toLowerCase()}?char=${charId[character.id]}';
    iFrame.style.border = 'none';
    iFrame.style.height = '100%';
    iFrame.style.width = '100%';
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => iFrame,
    );

    return HtmlElementView(key: UniqueKey(), viewType: 'iframeElement');
  }
}
