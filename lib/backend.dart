import 'dart:convert';

import 'package:http/http.dart' as http;

String baseUrl = 'https://indus-traveller.herokuapp.com/';

Future<String> generateToken(String username, String channel) async {
  Uri url = Uri.parse('${baseUrl}token?uid=$username&channel=$channel');
  var responce = await http.get(url);
  Map result = jsonDecode(responce.body);
  return (result.keys.contains('token')) ? result['token'] : 'error';
  // return '006a2c04255fbe0486dabf46a35c3c328daIACB09A4HqCGIO0hgnBYWAlz8AeUAYzJr7ixkfsoHbRooQx+f9gAAAAAEAATtvR9o4IbYgEAAQCjghti';
}

void leaveChannel(String username, String channel) async {
  Uri url = Uri.parse('${baseUrl}unsubscribe?uid=$username&channel=$channel');
  var responce = await http.get(url);
  print(jsonDecode(responce.body));
}
