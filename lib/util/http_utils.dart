import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';
import 'package:mlm/conf.dart';
import 'package:mlm/main.dart';
import 'package:mlm/model/api/resp.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/util/ui_utils.dart';

/// HTTP 工具
///
/// @author seliote
/// @version 2021-08-07

/// HTTP 工具类
class HttpUtils {
  // Authorization 请求头
  static const String AUTHORIZATION_HEADER = "Authorization";

  // 认证类型
  static const String AUTHORIZATION_TYPE = "Bearer";

  // 请求 Token，当为 null 时请求将不会携带 Token
  static String _token = "";

  static set token(String token) {
    if (token.isEmpty) {
      debugPrint("Empty token to set");
      return;
    }
    _token = token;
  }

  static String get token => _token;

  /// 创建 URI
  ///
  /// uri 部分 URI
  static Uri getUri(String uri) {
    return Uri.parse(
            "$BASE_URL/$uri".replaceAll(RegExp("(?<!(http:|https:))/+"), "/"))
        .normalizePath();
  }

  /// 请求单对象响应
  ///
  /// param uri 请求 URI
  /// param reqBody POST 请求体对象，会被自动转换为 JSON
  /// param timeout 请求超时，单位毫秒，为空时默认为 3000 毫秒
  /// return RespObject 对象，请求失败时返回 null
  static Future<RespObject?> post4Object(String uri,
      {Object? reqBody, int timeout = 3000}) async {
    var resp = await _postBody(uri, reqBody: reqBody, timeout: timeout);
    if (resp == null) {
      debugPrint("Request $uri return null");
      return null;
    }
    var respObject = RespObject.fromJson(json.decode(resp));
    if (!isRequestSuccess(respObject)) {
      debugPrint("Request $uri failed, response is $resp");
      return null;
    }
    return respObject;
  }

  /// 请求列表对象响应
  ///
  /// param uri 请求 URI
  /// param reqBody POST 请求体对象，会被自动转换为 JSON
  /// param timeout 请求超时，单位毫秒，为空时默认为 3000 毫秒
  /// return RespObject 对象，请求失败时返回 null
  static Future<RespArray?> post4Array(String uri,
      {Object? reqBody, int timeout = 3000}) async {
    var resp = await _postBody(uri, reqBody: reqBody, timeout: timeout);
    if (resp == null) {
      debugPrint("Request $uri return null");
      return null;
    }
    var respArray = RespArray.fromJson(json.decode(resp));
    if (!isRequestSuccess(respArray)) {
      debugPrint("Request $uri failed, response is $resp");
      return null;
    }
    return respArray;
  }

  /// 发送 POST 请求，请求异常时自动弹出 Toast 信息
  ///
  /// param uri 请求 URI
  /// param reqBody POST 请求体对象，会被自动转换为 JSON
  /// param timeout 请求超时，单位毫秒，为空时默认为 3000 毫秒
  /// return HTTP Response，请求失败时返回 null
  static Future<String?> _postBody(String uri,
      {Object? reqBody, int timeout = 3 * 1000}) async {
    debugPrint("POST $uri, request body $reqBody, timeout $timeout");
    // 拼接 URL 并格式化，Uri 居然不支持格式化多个反斜线
    var url = getUri(uri);
    var headers = {
      "Content-Type": "application/json",
      if (_token.isNotEmpty) AUTHORIZATION_HEADER: "$AUTHORIZATION_TYPE $_token"
    };
    Response resp;
    try {
      resp = await post(url,
              headers: headers,
              body: reqBody == null ? null : json.encode(reqBody))
          .timeout(Duration(milliseconds: timeout));
    } on TimeoutException {
      debugPrint("Request $uri timeout");
      showToast(AppLocalizations.of(globalKey.currentContext!)!
          .networkTimeoutToastMsg);
      return null;
    } catch (e) {
      debugPrint("Request $uri failed, ${e.toString()}");
      showToast(
          AppLocalizations.of(globalKey.currentContext!)!.networkErrorToastMsg);
      return null;
    }
    // 判断状态码
    if (resp.statusCode != HttpStatus.ok) {
      debugPrint("Request $uri resp code is ${resp.statusCode}");
      showToast(
          AppLocalizations.of(globalKey.currentContext!)!.networkErrorToastMsg);
      return null;
    }
    // 默认用 Content-Type，识别不到就用 latin1，直接就乱码了，所以得手动转
    return utf8.decode(resp.bodyBytes);
  }

  /// 判断请求响应是否正常，通用异常时弹出相应错误信息或执行相应的错误恢复操作
  ///
  /// param resp Resp 响应对象
  /// return 通用异常时返回 false，否则返回 true
  static bool isRequestSuccess(Resp resp) {
    if (resp.code >= 0) {
      // 请求正常或业务失败
      return true;
    }
    debugPrint("Request failed, code is ${resp.code}, message is ${resp.msg}");
    if (resp.code >= -19999 && resp.code <= -10000) {
      // 系统异常，如 HTTP 请求方法不正确
      showToast(AppLocalizations.of(globalKey.currentContext!)!.serverError);
      return false;
    } else if (resp.code >= -29999 && resp.code <= -20000) {
      // 认证与授权异常，如 Token 失效
      if (resp.code == -21000) {
        // 401 unauthorized，未带 Token 或 Token 无效
        showToast(
            AppLocalizations.of(globalKey.currentContext!)!.unauthorizedError);
        // 登录异常直接重定向到登录页
        Navigator.pushReplacementNamed(globalKey.currentContext!, AUTH_PAGE);
        return false;
      } else if (resp.code == -21100) {
        // 403 Forbidden 无权访问
        showToast(
            AppLocalizations.of(globalKey.currentContext!)!.forbiddenError);
        return false;
      }
    } else if (resp.code >= -39999 && resp.code <= -30000) {
      // 客户端异常
      if (resp.code == -31000) {
        // 接口请求频率过快
        showToast(
            AppLocalizations.of(globalKey.currentContext!)!.frequencyError);
        return false;
      }
    }
    // 未知异常
    showToast(AppLocalizations.of(globalKey.currentContext!)!.systemError);
    return false;
  }
}
