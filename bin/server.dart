import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:postgresql2/pool.dart';
import 'package:shelf/shelf_io.dart' as io;

class Server {
  final Router _router;
  final Pool _pool;

  Server(this._pool)
      : _router = Router() {
    _router.get('/data', _handleGetData);
    _router.post('/data', _handlePostData);
    _router.delete('/data/<id>', _handleDeleteData);
  }

  Handler get handler => _router.call;

  Future<Response> _handleGetData(Request request) async {
    // Hier holen Sie die Daten aus der Datenbank
    // und senden sie als Antwort zurück
    // ...
    return Response.ok(jsonEncode({'data': 'data'}));
  }

  Future<Response> _handlePostData(Request request) async {
    // Hier nehmen Sie die Daten aus der Anfrage,
    // fügen sie in die Datenbank ein
    // und senden eine Bestätigungsantwort zurück
    // ...
    return Response.ok(jsonEncode({'result': 'success'}));
  }

  Future<Response> _handleDeleteData(Request request, String id) async {
    // Hier nehmen Sie die ID aus der Anfrage,
    // löschen den entsprechenden Datensatz aus der Datenbank
    // und senden eine Bestätigungsantwort zurück
    // ...
    return Response.ok(jsonEncode({'result': 'success'}));
  }
}

void main() {
  var uri = 'postgres://postgres:admin@localhost:5433/postgres';
  var pool = Pool(uri, minConnections: 2, maxConnections: 5);
  pool.messages.listen(print);
  pool.start().then((_) {
    print('Min connections established.');

    final server = Server(pool);

    // Starten Sie den Server und hören Sie auf Port 8080
    io.serve(server.handler, 'localhost', 8080).then((server) {
      print('Serving at http://${server.address.host}:${server.port}');
    });
  });
}
