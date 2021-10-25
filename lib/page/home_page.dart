import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/music_catalog/upload_count.dart';
import 'package:mlm/model/api/user/info.dart';
import 'package:mlm/model/provider/user_info_model.dart';
import 'package:mlm/page/uploaded_page.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/ui_utils.dart';
import 'package:provider/provider.dart';

/// 主页
///
/// @author seliote
/// @version 2021-08-07

const HOME_PAGE = "/home";

/// 主页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _uploadCount;

  @override
  void initState() {
    super.initState();
    _initAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: Colors.black54),
                    onPressed: () => Scaffold.of(context).openDrawer())),
            actions: <Widget>[
              IconButton(
                  onPressed: () => null,
                  icon: Icon(Icons.search, color: Colors.black54))
            ]),
        drawer: Drawer(child: Container(color: Colors.blueAccent)),
        body: _contentBody());
  }

  Widget _contentBody() {
    return Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            SizedBox(height: 8),
            Expanded(
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (ctx, index) {
                      if (index == 0) {
                        return _getMusicCatalogCard(
                            Icon(Icons.cloud_upload),
                            AppLocalizations.of(context)!
                                .homePageMusicCatalogMyUpload,
                            _uploadCount == null ? 0 : _uploadCount!);
                      } else if (index == 1) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                                AppLocalizations.of(context)!
                                    .homePageMyMusicCatalog,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black54)));
                      } else {
                        return _getMusicCatalogCard(
                            Icon(Icons.cloud_upload),
                            AppLocalizations.of(context)!
                                .homePageMusicCatalogMyUpload,
                            7);
                      }
                    }))
          ],
        ));
  }

  Widget _getMusicCatalogCard(Widget leading, String title, int count) {
    var leadingSize = 40.0;
    return GestureDetector(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: IntrinsicHeight(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: leadingSize,
                          maxWidth: leadingSize,
                          minHeight: leadingSize,
                          maxHeight: leadingSize),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.black54,
                              )),
                          child: leading)),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black54)),
                      Expanded(child: Container()),
                      Text(AppLocalizations.of(context)!
                          .homePageMusicCatalogCount(count))
                    ],
                  )
                ]),
          )),
      onTap: () {
        Navigator.pushNamed(context, UPLOADED_PAGE);
      },
    );
  }

  void _initAll() async {
    var userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    await _initUserInfo(userInfoModel);
    _initMusicCatalog(userInfoModel);
  }

  Future<void> _initUserInfo(UserInfoModel model) async {
    var resp = await HttpUtils.post4Object("/user/info");
    if (resp == null) {
      return;
    }
    if (resp.code != 0) {
      showToast(AppLocalizations.of(context)!.homePageFailedGetUserInfo);
      return;
    }
    var info = InfoResp.fromJson(resp.data!);
    model.userId = info.userId;
    model.countryCode = info.countryCode;
    model.localName = info.localName;
    model.nickname = info.nickname;
    model.gender = info.gender;
    model.avatar = info.avatar;
  }

  void _initMusicCatalog(UserInfoModel userInfoModel) async {
    if (userInfoModel.userId == null) {
      return;
    }
    var req = UploadCountReq(userInfoModel.userId!);
    var resp = await HttpUtils.post4Object("/music_catalog/upload_count",
        reqBody: req);
    if (resp == null) {
      return;
    }
    if (resp.code == 1) {
      showToast(
          AppLocalizations.of(context)!.homePageGetCatalogCountUserNotExist);
      return;
    }
    var respModel = UploadCountResp.fromJson(resp.data!);
    setState(() {
      _uploadCount = respModel.count;
    });
  }
}
