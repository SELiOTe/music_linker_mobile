import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/music_catalog/upload_list.dart';
import 'package:mlm/model/provider/user_info_model.dart';
import 'package:mlm/model/state/music_player.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:provider/provider.dart';

/// 我的上传页
///
/// @author seliote
/// @version 2021-09-27

const UPLOADED_PAGE = "/uploaded_page";

/// 上传的歌曲页
class UploadedPage extends StatefulWidget {
  const UploadedPage({Key? key}) : super(key: key);

  @override
  _UploadedPageState createState() => _UploadedPageState();
}

class _UploadedPageState extends State<UploadedPage> {
  // 音乐列表
  List<UploadListResp> _musicList = [];

  @override
  void initState() {
    super.initState();
    var req = UploadListReq(
        Provider.of<UserInfoModel>(context, listen: false).userId!);
    HttpUtils.post4Array("/music_catalog/upload_list", reqBody: req)
        .then((resp) {
      if (resp == null || resp.code != 0) {
        return;
      }
      setState(() {
        _musicList = UploadListResp.fromJsonArray(resp.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${Provider.of<UserInfoModel>(context, listen: false).nickname!}"
            "${AppLocalizations.of(context)!.uploadPageTitleSuffix}"),
      ),
      body: Container(
          color: Colors.grey[200],
          child: ListView.separated(
              itemCount: _musicList.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(_musicList[index].musicName,
                            style: TextStyle(fontSize: 18)),
                        Text(_musicList[index].singerName,
                            style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  onTap: () {
                    debugPrint("Start play music ${_musicList[index].musicId}");
                    MusicPlayer.play("/music/play_music?music_id="
                        "${_musicList[index].musicId}");
                  },
                );
              },
              separatorBuilder: (ctx, index) {
                return Container(height: 8, color: Colors.transparent);
              })),
    );
  }
}
