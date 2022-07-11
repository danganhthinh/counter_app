import 'dart:convert';

import 'package:counter_app/models/comment.dart';
import 'package:http/http.dart' as http;

getCommentsFromApi(int start, int limit) async {
  final url =
      "https://jsonplaceholder.typicode.com/comments?start=$start&limit=$limit";
  var httpClient = http.Client();

  try {
    final response = await httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List;
      final List<Comment> comments = responseData.map((comment) {
        return Comment(
            id: comment['id'],
            name: comment['name'],
            email: comment['email'],
            body: comment['body']);
      }).toList();
      print('object');
      return comments;
    }
  } catch (e) {
    httpClient.close();
  }
}
