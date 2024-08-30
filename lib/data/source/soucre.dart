import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mp3_music/data/model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource{
  Future<List<Song>?> loadData();
}
//Từ xa
class RemoteDataSource implements DataSource{
  @override
  Future<List<Song>?> loadData() async{
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){ // trạng thái HTTP của phản hồi.
      final bodyContent = utf8.decode(response.bodyBytes); //các byte biểu diễn nội dung của phản hồi. => kiểu dữ liệu json
      var songWrapper = jsonDecode(bodyContent) as Map;
      var songList = songWrapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    }else {
      return null;
    }

  }
}
//Cục bộ
class LocalDataSource implements DataSource{
  @override
  Future<List<Song>?> loadData() async{
    final String response = await rootBundle.loadString('assets/songs.json');
    final jsonBody = jsonDecode(response) as Map;
    final songList = jsonBody['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }

}