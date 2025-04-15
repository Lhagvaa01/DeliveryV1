// ignore_for_file: avoid_print, prefer_const_constructors, prefer_adjacent_string_concatenation, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:deliery_app/model/product_list.dart';
import 'package:deliery_app/model/service_history_hdr.dart';

import '../constant.dart';
import '../model/customers_model.dart';
import '../model/UserInfo.dart';
import '../model/payment_list.dart';
import '../model/repair_history_dtl.dart';
import '../model/repair_history_hdr.dart';
import '../model/sales_history_dtl.dart';
import '../model/sales_history_hdr.dart';
import '../model/search_serial.dart';

var apiName = "tegsh-bayan-arwai.vercel.app";

Future<UserInfo> postLoginCheck(BuildContext ctx, String body) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.https(apiName, '/api/login/');
    print(uri);
    print(body.length);
    var request = await httpClient.postUrl(uri);
    request.headers
        .set(HttpHeaders.contentTypeHeader, 'application/json; charset=UTF-8');
    request.headers.set('Content-Length', body.length);
    request.write(body);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(responseBody);
    httpClient.close();
    var resCode = json.decode(responseBody);

    var getList = UserInfo();
    getList = UserInfo.fromJson(resCode);
    loginInfo = UserInfo.fromJson(resCode);
    return getList;
  } catch (e) {
    print("throwing new error: " + '$e');
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}

Future<List<SalesHistoryHdr>> getSalesHistoryHDRList(
    BuildContext ctx, String startDate, String endDate) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.https(apiName, '/api/history/', {
      // 'search': SearchVal,
      'start_date': startDate,
      'end_date': endDate
    });
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(response.statusCode);
    print(responseBody);
    httpClient.close();
    var resCode = json.decode(responseBody);
    var getList = <SalesHistoryHdr>[];
    print(response.statusCode);
    if (response.statusCode == 200) {
      for (var gJson in resCode) {
        getList.add(SalesHistoryHdr.fromJson(gJson));
      }
      print(getList.length);
      return getList;
    } else if (response.statusCode == 404) {
      print(responseBody);
    } else {
      toasty(ctx, "Сервэрийн алдаа: " + response.statusCode.toString(),
          bgColor: Colors.redAccent,
          textColor: whiteColor,
          gravity: ToastGravity.BOTTOM,
          length: Toast.LENGTH_LONG);
      throw "Unable to retrieve posts.";
    }
    return getList;
  } catch (e) {
    print("throwing new error: " + '$e');
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}

Future<List<CustomersListModel>> getCustomersList(BuildContext ctx) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.http(apiName, '/api/info-sectors/');
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(response.statusCode);
    print(responseBody);
    httpClient.close();
    var resCode = json.decode(responseBody);
    var getList = <CustomersListModel>[];
    print(response.statusCode);
    if (response.statusCode == 200) {
      for (var gJson in resCode) {
        getList.add(CustomersListModel.fromJson(gJson));
      }
      print(getList.length);
      return getList;
    } else if (response.statusCode == 404) {
      print(responseBody);
    } else {
      toasty(ctx, "Сервэрийн алдаа: " + response.statusCode.toString(),
          bgColor: Colors.redAccent,
          textColor: whiteColor,
          gravity: ToastGravity.BOTTOM,
          length: Toast.LENGTH_LONG);
      throw "Unable to retrieve posts.";
    }
    return getList;
  } catch (e) {
    print("throwing new error: " + '$e');
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}

List<String> ret = [];
Future<SearchSerial> getSearchSerial(BuildContext ctx, String itemCode) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.https(apiName, '/api/product/search/', {
      // 'search': SearchVal,
      'itemCode': itemCode,
      // 'itemName': itemName
    });
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(response.statusCode);
    print(responseBody);
    httpClient.close();
    var getList = SearchSerial();
    print(responseBody);
    if (responseBody != "") {
      var resCode = json.decode(responseBody);
      // ret = [];
      // for (var element in resCode) {
      //   ret.add(element['itemCode'][1]);
      // }
      // return ret;

      print(response.statusCode);

      if (response.statusCode == 200) {
        print("object");
        var getJson = jsonDecode(responseBody);
        // for (var gJson in getJson) {
        getList = SearchSerial.fromJson(getJson[0]);

        return getList;
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(
              "Сервэрийн алдаа: " + response.statusCode.toString(),
            ),
            backgroundColor: Colors.redAccent,
          ),
        );
        throw "Unable to retrieve posts.";
      }
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            "Энэ бараа бүртгэгдээгүй байна: " + itemCode,
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    return getList;
  } catch (e) {
    print("throwing new error: " + '$e');

    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}

Future<String> postProdctSold(BuildContext ctx, String body) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.https(apiName, '/api/history/');
    print(uri);
    print(body);
    var request = await httpClient.postUrl(uri);
    request.headers
        .set(HttpHeaders.contentTypeHeader, 'application/json; charset=UTF-8');
    request.headers.set('Content-Length', body.length);
    request.write(body);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(response.statusCode);
    print(responseBody);
    httpClient.close();
    var resCode = json.decode(responseBody);
    return resCode['message'];
  } catch (e) {
    print("throwing new error: " + '$e');
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}

Future<List<SearchSerial>> getProductsList(BuildContext ctx) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.http(apiName, '/api/products/');
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(response.statusCode);
    print(responseBody);
    httpClient.close();
    var resCode = json.decode(responseBody);
    var getList = <SearchSerial>[];
    print(response.statusCode);
    if (response.statusCode == 200) {
      for (var gJson in resCode) {
        getList.add(SearchSerial.fromJson(gJson));
      }
      print(getList.length);
      return getList;
    } else if (response.statusCode == 404) {
      print(responseBody);
    } else {
      toasty(ctx, "Сервэрийн алдаа: " + response.statusCode.toString(),
          bgColor: Colors.redAccent,
          textColor: whiteColor,
          gravity: ToastGravity.BOTTOM,
          length: Toast.LENGTH_LONG);
      throw "Unable to retrieve posts.";
    }
    return getList;
  } catch (e) {
    print("throwing new error: " + '$e');
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}

Future<List<CustomersListModel>> getSeactionList(BuildContext ctx) async {
  try {
    var httpClient = HttpClient();
    var uri = Uri.http(apiName, '/api/info-sectors/');
    print(uri);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();

    var responseBody = await response.transform(Utf8Decoder()).join();
    print(response.statusCode);
    print(responseBody);
    httpClient.close();
    var resCode = json.decode(responseBody);
    var getList = <CustomersListModel>[];
    print(response.statusCode);
    if (response.statusCode == 200) {
      for (var gJson in resCode) {
        getList.add(CustomersListModel.fromJson(gJson));
      }
      print(getList.length);
      return getList;
    } else if (response.statusCode == 404) {
      print(responseBody);
    } else {
      toasty(ctx, "Сервэрийн алдаа: " + response.statusCode.toString(),
          bgColor: Colors.redAccent,
          textColor: whiteColor,
          gravity: ToastGravity.BOTTOM,
          length: Toast.LENGTH_LONG);
      throw "Unable to retrieve posts.";
    }
    return getList;
  } catch (e) {
    print("throwing new error: " + '$e');
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "Сервэрийн алдаа: " + '$e',
        ),
        backgroundColor: Colors.redAccent,
      ),
    );
    throw Exception("Error on server");
  }
}
