import 'dart:async';

import 'package:mp3_music/data/reponsitory/responsitory.dart';

import '../../data/model/song.dart';

class MusicAppViewmodel{
  StreamController<List<Song>> songStream = StreamController();

  void LoadSong(){
    final reponsitory = DefaultResponsitory();
    reponsitory.loadData().then((value) => songStream.add(value!));
  }
}