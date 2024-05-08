import 'package:postgres/postgres.dart';

void main() async {
  final conn = await Connection.open(
    Endpoint(
      host: 'localhost',
      port: 5433,
      database: 'postgres',
      username: 'postgres',
      password: 'admin',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );

  print('Verbindung erfolgreich hergestellt.');

  // Führen Sie hier Ihre Datenbankoperationen aus

  // Erstellen Sie eine Tabelle
  await conn.execute('CREATE TABLE test (id serial PRIMARY KEY, content varchar);');

  // Fügen Sie Daten in die Tabelle ein
  await conn.execute("INSERT INTO test (content) VALUES ('Test; 1234');");

  print('Datenbankoperationen erfolgreich ausgeführt.');

  await conn.close();
}
