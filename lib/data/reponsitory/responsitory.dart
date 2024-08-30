import 'dart:math';

import 'package:mp3_music/data/source/soucre.dart';

import '../model/song.dart';

abstract interface class Responsitory{
  Future<List<Song>?> loadData();
}

class DefaultResponsitory implements Responsitory{
  final _localDataSource = LocalDataSource(); //Data cục bộ
  final _remoteDataSource = RemoteDataSource(); //Từ xa


  @override
  Future<List<Song>?> loadData() async {
    try {
      List<Song>? songs = await _remoteDataSource.loadData();
      if(songs == null){
        print('Không load được dữ liệu qua http chuyển qua data cục bộ');
        songs = await _localDataSource.loadData();
      }
      return songs;
    }catch(e){
      print('Lỗi trong lớp DefaultResponsitory : $e');
      return null; // Trả về null nếu xảy ra lỗi
    }
  }

}