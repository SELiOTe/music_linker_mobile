import 'package:flutter/material.dart';
import 'package:mlm/model/api/auth/country_list.dart';

/// 国家码列表页
///
/// @author seliote
/// @version 2021-08-12

const COUNTRY_LIST_PAGE = "/auth/country_list";

/// 国家码列表页
class CountryListPage extends StatelessWidget {
  // 国家列表
  final List<CountryListResp> _countryList;

  const CountryListPage(this._countryList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // 透明 AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: _getGradientBackgroundDecoration(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemCount: _countryList.length,
                separatorBuilder: (_, __) => SizedBox(height: 36),
                itemBuilder: (context, index) {
                  var item = _countryList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: GestureDetector(
                      child: Text("${item.localName} (+${item.phoneCode})",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      onTap: () => Navigator.pop(context, item),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取渐变背景
  ///
  /// return 渐变背景
  BoxDecoration _getGradientBackgroundDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent]));
  }
}
