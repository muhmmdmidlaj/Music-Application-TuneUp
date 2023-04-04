import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_one_tuneup/DB/functions/function_playlist.dart';
import 'package:project_one_tuneup/model/model.dart';
import 'package:project_one_tuneup/playlist/playlist_addsong.dart';

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Play List',
          style: GoogleFonts.orbitron(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 5, 12, 25),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable: Hive.box<PlayModel>('playlistDB').listenable(),
                builder: (BuildContext context, Box<PlayModel> musiclist,
                    Widget? child) {
                  return ListView.builder(
                    itemCount: musiclist.length,
                    itemBuilder: (context, index) {
                      final data = musiclist.values.toList()[index];
                      return Slidable(
                        endActionPane:
                            ActionPane(motion: const BehindMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              deleteplaylist(context, musiclist, index);
                            },
                            icon: Icons.delete_outline,
                            foregroundColor: Colors.red,
                            backgroundColor:
                                const Color.fromARGB(255, 37, 37, 54),
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              editplaylistname(context, data, index);
                            },
                            icon: Icons.edit,
                            backgroundColor:
                                const Color.fromARGB(255, 37, 37, 54),
                          ),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 5, 12, 25),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white30)),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistToAddsong(
                                          sindex: index, playlist: data),
                                    ));
                              },
                              leading: const Icon(
                                Icons.music_note_outlined,
                                color: Color.fromARGB(255, 29, 29, 45),
                              ),
                              title: Text(
                                data.name,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                tooltip: 'Drag Left',
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newplaylist(context, formkey);
        },
        tooltip: 'Add New Playlist',
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//create new playlist

void newplaylist(BuildContext context, formkey) {
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          backgroundColor: Colors.white70,
          children: [
            SimpleDialogOption(
              child: Text(
                'New Playlist',
                style: GoogleFonts.orbitron(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SimpleDialogOption(
              child: Form(
                key: formkey,
                child: TextFormField(
                  controller: playlistnamecontroller,
                  maxLength: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(5)),
                      labelText: 'Playlist Name',
                      labelStyle: GoogleFonts.orbitron(
                        color: const Color.fromARGB(255, 39, 33, 55),
                      ),
                      fillColor: Colors.white70.withOpacity(0.2),
                      filled: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Playlist Name';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      playlistnamecontroller.clear();
                    },
                    child: Text(
                      'CANCEL',
                      style: GoogleFonts.orbitron(
                        color: const Color.fromARGB(255, 39, 33, 55),
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        okbuttompressing(context);
                      }
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.orbitron(
                        color: const Color.fromARGB(255, 39, 33, 55),
                      ),
                    ))
              ],
            ),
          ]);
    },
  );
}

// ok Button  click time , add data to database

Future<void> okbuttompressing(context) async {
  final name = playlistnamecontroller.text.trim();
  final music = PlayModel(name: name, songid: []);
  if (name.isEmpty) {
    return;
  } else {
    PlayListDatabase.addplaylist(music);
    final addplaylistsnak = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(
            child: Text('Playlist Added',
                style: GoogleFonts.orbitron(color: Colors.white60))));
    ScaffoldMessenger.of(context).showSnackBar(addplaylistsnak);
    Navigator.pop(context);
    playlistnamecontroller.clear();
  }
}

//Delete playlist show dialoge and delete

Future<dynamic> deleteplaylist(
    BuildContext context, Box<PlayModel> musiclist, int index) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white60,
      title: Text(
        'Delete Playlist',
        style: GoogleFonts.orbitron(
          color: const Color.fromARGB(222, 38, 46, 67),
        ),
      ),
      content: Text('Are You Sure Delete',
          style: GoogleFonts.orbitron(
            color: const Color.fromARGB(222, 38, 46, 67),
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel',
                style: GoogleFonts.orbitron(
                  color: const Color.fromARGB(222, 38, 46, 67),
                ))),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              musiclist.deleteAt(index);
              final deletesnake = SnackBar(
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.red,
                  content: Center(
                      child: Text('Playlist Deleted',
                          style: GoogleFonts.orbitron(color: Colors.white60))));
              ScaffoldMessenger.of(context).showSnackBar(deletesnake);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)))
      ],
    ),
  );
}

//edit name playlist
// final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
TextEditingController namecontroller = TextEditingController();

Future<dynamic> editplaylistname(
    BuildContext context, PlayModel data, int index) {
  namecontroller = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10),
      )),
      backgroundColor: const Color.fromARGB(255, 37, 37, 54),
      children: [
        SimpleDialogOption(
          child: Form(
            key: formkey,
            child: Text(
              "Edit Playlist",
              style: GoogleFonts.orbitron(fontSize: 15, color: Colors.white60),
            ),
          ),
        ),
        SimpleDialogOption(
            child: TextFormField(
          decoration: InputDecoration(
              counterStyle: const TextStyle(color: Colors.white10),
              fillColor: Colors.white10.withOpacity(0.2),
              filled: true,
              border: const OutlineInputBorder()),
          controller: namecontroller,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white60),
          textAlign: TextAlign.center,
          maxLength: 10,
        )),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                namecontroller.clear();
              },
              child: Text(
                'CANCEL',
                style: GoogleFonts.orbitron(),
              ),
            ),
            TextButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  final name = namecontroller.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistname = PlayModel(name: name, songid: []);
                    PlayListDatabase.playlistedit(playlistname, index);
                  }

                  Navigator.pop(context);
                }
              },
              child: Text(
                'OK',
                style: GoogleFonts.orbitron(),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Future<void> saveButtonPressed(context) async {
  final name = namecontroller.text.trim();
  final music = PlayModel(name: name, songid: []);
  final datas =
      PlayListDatabase.playlistdata.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    final snackbar3 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist already exist',
          style: GoogleFonts.orbitron(color: Colors.redAccent),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar3);
    Navigator.of(context).pop();
  } else {
    PlayListDatabase.addplaylist(music);
    final snackbar4 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist created successfully',
          style: GoogleFonts.orbitron(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar4);
    Navigator.pop(context);
    namecontroller.clear();
  }
}
