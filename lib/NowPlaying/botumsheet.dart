import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_one_tuneup/model/model.dart';
import 'package:project_one_tuneup/playlist/play_list.dart';

showPlaylistdialognow(BuildContext context, SongModel songModel) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 5, 12, 25),
          title: const Text(
            "choose your playlist",
            style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
          ),
          content: SizedBox(
            height: 200,
            width: double.maxFinite,
            child: ValueListenableBuilder(
                valueListenable: Hive.box<PlayModel>('playlistDB').listenable(),
                builder: (BuildContext context, Box<PlayModel> musicList,
                    Widget? child) {
                  return Hive.box<PlayModel>('playlistDB').isEmpty
                      ? Center(
                          child: Stack(
                            children: const [
                              Positioned(
                                right: 30,
                                left: 30,
                                bottom: 50,
                                child: Center(
                                  child: Text('No Playlist found!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: musicList.length,
                          itemBuilder: (ctx, index) {
                            final data = musicList.values.toList()[index];

                            return Card(
                              color: const Color.fromARGB(255, 8, 120, 175),
                              shadowColor: Colors.purpleAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: Colors.white)),
                              child: ListTile(
                                title: Text(
                                  data.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'poppins'),
                                ),
                                trailing: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  songaddtoplaylist(
                                      songModel, data, data.name, ctx);
                                  Navigator.pop(ctx);
                                },
                              ),
                            );
                          },
                        );
                }),
          ),
        );
      });
}

void songaddtoplaylist(
    SongModel data, datas, String name, BuildContext context) {
  if (!datas.isvalule(data.id)) {
    datas.add(data.id);
    final snake1 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: const Color.fromARGB(222, 38, 46, 67),
        content: Center(
            child: Text(
          'Playlist Add To $name',
          style: const TextStyle(color: Colors.white60),
        )));
    ScaffoldMessenger.of(context).showSnackBar(snake1);
  } else {
    final snake2 = SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.red,
        content: Center(child: Text('Song Alredy Added In $name')));
    ScaffoldMessenger.of(context).showSnackBar(snake2);
  }
}

Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: namecontroller,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                namecontroller.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  saveButtonPressed(context);
                }
              },
              child: const Text(
                'Create',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
