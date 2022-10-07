// // Copyright ©2022, GM Consult (Pty) Ltd. All rights reserved
// // End user is granted a non-exclusive non-transferable license the ("License")
// // to use GM Consult's proprietary software (the "Software").
// //

// part of 'oxford_dictionary.dart';

// abstract class _HttpTest {
//   //

//   /// Returns the [Uri] for the HTTP endpoint using the path, paramaters
//   /// and headers for the service API
//   static Uri getUri(
//       {required String host,
//       String? path,
//       Map<String, String>? queryParameters,
//       bool protocolIsHttps = true}) {
//     if (protocolIsHttps) {
//       return Uri.https(host, path ?? '/', queryParameters);
//     }
//     return Uri.http(host, path ?? '/', queryParameters);
//   }

//   /// Returns a HTTP [http.Response] from the [uri], adding [headers] to the GET.
//   static Future<http.Response?> httpGetUri(Uri uri,
//       {Map<String, String>? headers,
//       Duration timeout = const Duration(seconds: 5)}) async {
//     int tries = 0;
//     http.Response? response;
//     do {
//       try {
//         headers = headers?.isEmpty ?? true ? null : headers;
//         response = await http.get(uri, headers: headers).timeout(timeout);
//         final statusCode = response.statusCode;
//         if (statusCode != 200) {
//           response = null;
//           throw ('The response status code was $statusCode');
//         }
//       } on Exception {
//         await Future.delayed(const Duration(milliseconds: 1000));
//         tries++;
//         response = null;
//       }
//     } while (tries < 5 && response == null);
//     return response;
//   }

//   // /// Returns a HTTP [http.Response] from the raw [url].
//   // static Future<http.Response?> httpGetUrl(String url,
//   //         {Duration timeout = const Duration(seconds: 35)}) =>
//   //     httpGetUri(Uri.parse(url), headers: null, timeout: timeout);

//   // Future<http.Response?> httpGet(
//   //         {required String host,
//   //         String? path,
//   //         Map<String, String>? queryParameters,
//   //         Map<String, String>? headers,
//   //         bool protocolIsHttps = true,
//   //         Duration timeout = const Duration(seconds: 35)}) =>
//   //     httpGetUri(
//   //         getUri(
//   //             host: host,
//   //             path: path,
//   //             queryParameters: queryParameters,
//   //             protocolIsHttps: protocolIsHttps),
//   //         headers: headers,
//   //         timeout: timeout);

//   /// Fetches the JSON object from the HTTP endpoint using the path, paramaters
//   /// and headers for the service API
//   static Future<JSON?> getJson(
//       {required String host,
//       String? path,
//       Map<String, String>? queryParameters,
//       Map<String, String>? headers,
//       bool protocolIsHttps = true}) async {
//     final uri = getUri(
//         host: host,
//         path: path,
//         queryParameters: queryParameters,
//         protocolIsHttps: protocolIsHttps);
//     try {
//       final response = await httpGetUri(uri, headers: headers);
//       // parse response
//       if (response != null && response.statusCode == 200) {
//         // If the server did return a 200 OK response, convert to JSON and
//         // return the result.
//         // final body = response.;
//         return _decodeJson(response.body, path ?? '', queryParameters ?? {},
//             response.statusCode);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }

//   static JSON? _decodeJson(String responseBody, String path,
//       Map<String, String> query, int statusCode) {
//     responseBody = (!responseBody.startsWith('{'))
//         ? '{"data": ${responseBody.startsWith('[') ? responseBody : '"$responseBody"'}}'
//         : responseBody;

//     try {
//       final json = jsonDecode(responseBody);
//       if (json is Map<String, dynamic>) {
//         json['_%path'] = path;
//         json['_%status'] = statusCode;
//         json['_%query'] = query;
//         return json;
//       }
//     } on Exception catch (e) {
//       print(e);
//       if (e is FormatException) {
//         final start = (e.offset ?? 10) - 10;
//         final finish = (e.offset ?? 10) + 10;
//         final snippet = responseBody.substring(start, finish);
//         print(snippet);
//       }
//     }
//     return null;
//   }

//   // static Future<JSON?> fetchJsonByPost(
//   //     {required String host,
//   //     String? path,
//   //     Map<String, String>? queryParameters,
//   //     Map<String, String>? headers,
//   //     JSON? body,
//   //     bool protocolIsHttps = true}) async {
//   //   final uri = getUri(
//   //       host: host,
//   //       path: path,
//   //       queryParameters: queryParameters,
//   //       protocolIsHttps: protocolIsHttps);
//   //   final response =
//   //       await http.post(uri, headers: headers, body: jsonEncode(body));

//   //   if (response.statusCode == 200) {
//   //     // If the server did return a 200 OK response, convert to JSON and
//   //     // return the result.
//   //     return _decodeJson(response.body, path ?? '', queryParameters ?? {},
//   //         response.statusCode);
//   //   } else {
//   //     // If the server did not return a 200 OK response,
//   //     // then throw an exception.
//   //     throw Exception('The server failed to respond in a timely manner');
//   //   }
//   // }

//   // static Future<JSON?> apiRequest(
//   //     {required String host,
//   //     required Map<String, String> headers,
//   //     required JSON body,
//   //     String? path,
//   //     Map<String, String>? queryParameters,
//   //     bool protocolIsHttps = true}) async {
//   //   final httpClient = HttpClient();
//   //   final uri = getUri(
//   //       host: host,
//   //       path: path,
//   //       queryParameters: queryParameters,
//   //       protocolIsHttps: protocolIsHttps);
//   //   final request = await httpClient.postUrl(uri);
//   //   headers.forEach((key, value) {
//   //     request.headers.set(key, value);
//   //   });
//   //   request.add(utf8.encode(json.encode(body)));
//   //   final response = await request.close();
//   //   // todo - you should check the response.statusCode
//   //   if (response.statusCode == 200) {
//   //     // If the server did return a 200 OK response, convert to JSON and
//   //     // return the result.
//   //     final reply = await response.transform(utf8.decoder).join();
//   //     httpClient.close();
//   //     final responseBody =
//   //         (!reply.startsWith('{')) ? '{"data": $reply}' : reply;
//   //     return _decodeJson(
//   //         responseBody, path ?? '', queryParameters ?? {}, response.statusCode);
//   //   } else {
//   //     // If the server did not return a 200 OK response,
//   //     // then throw an exception.
//   //     httpClient.close();
//   //     throw Exception('The server failed to respond in a timely manner');
//   //   }
//   // }
// }
