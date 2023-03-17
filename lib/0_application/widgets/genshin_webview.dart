import 'package:cs311hw10/1_domain/entities/genshin_character_entity.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cs311hw10/character_number.dart';

class GenshinWebView extends StatelessWidget {
  const GenshinWebView({Key? key, required this.character}) : super(key: key);
  final GenshinCharacterEntity character;
  @override
  Widget build(BuildContext context) {
    String nation = character.nation.toLowerCase();
    switch (nation) {
      case 'snezhnaya':
        nation = 'liyue';
        break;
      case 'unknown':
        nation = 'monstadt';
        break;
      default:
        break;
    }
    final url =
        'https://genshin.hoyoverse.com/en/character/$nation?char=${charId[character.id]}';
    print(url);
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (url) {},
        onWebResourceError: (error) {},
        onNavigationRequest: (request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title: const Text('Character Information')),
      body: WebViewWidget(controller: controller),
    );
  }
}
