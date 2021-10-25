import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mlm/util/http_utils.dart';

/// 全局音乐播放
///
/// @author seliote
/// @version 2021-10-20

class MusicPlayer {
  // 全局唯一 AudioPlayer
  static final AudioPlayer _audioPlayer = AudioPlayer();

  /// 播放音乐
  ///
  /// url 音乐 URL
  static Future<Duration?> play(String uri) async {
    var url = HttpUtils.getUri(uri).toString();
    debugPrint("Play audio $url");
    var duration = await _audioPlayer.setUrl(url, headers: {
      HttpUtils.AUTHORIZATION_HEADER:
          "${HttpUtils.AUTHORIZATION_TYPE} ${HttpUtils.token}"
    });
    _audioPlayer.play();
    return duration;
  }
}
