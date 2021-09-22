import 'package:flutter/material.dart';

/// 歌单信息 Provider 模型
/// 
/// @author seliote
/// @version 2021-09-22

/// 歌单信息 Provider 模型
class MusicCatalogModel with ChangeNotifier {
  // 我的上传
  int? _uploadCount;

  int? get uploadCount => _uploadCount;

  set uploadCount(int? uploadCount) {
    _uploadCount = uploadCount;
    notifyListeners();
  }
}