import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/user/info.dart';
import 'package:mlm/util/http_utils.dart';

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
  InfoResp? infoResp;

  @override
  void initState() {
    super.initState();
    HttpUtils.post4Object("/user/info")
        .then((value) => debugPrint("${value!.data}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
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
                            7);
                      } else if (index == 1) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(AppLocalizations.of(context)!
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
    return Container(
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
        ));
  }
}
