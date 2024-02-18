import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  // initialize package
  // dapatkan API-KEY disini https://ai.google.dev/tutorials/setup
  final model = GenerativeModel(
    model: 'gemini-pro',
    apiKey: 'API-KEY',
  );

  // controller dari textfield
  final controller = TextEditingController();

  // data dari history chat
  List<String> datas = [];

  getPrompt(String message) async {
    // menyimpan chat yg dikirim ke dalam datas
    datas.add('Kamu : $message');

    // hapus isi yg ada di textfield
    controller.clear();

    // update UI
    setState(() {});

    // buat list content
    final content = [Content.text(message)];

    // jalankan AI
    final response = await model.generateContent(content);

    // masukan hasil dari AI ke datas
    datas.add('Jarvis : ${response.text}');

    // update UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  children: datas
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Container(
              color: Colors.lightBlue,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: TextField(controller: controller)),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        getPrompt(controller.text);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
