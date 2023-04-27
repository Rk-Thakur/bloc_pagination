import 'dart:convert';

import 'package:bloc_pagination/postmodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final dio = Dio();

class PostRepo {
  fetchPosts(int page) async {
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_limit=10&_page=$page');
    // 'http://app.scanskill.com/public/api/content?limit=10&page=$page');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;

      return json;
    }
  }
}
