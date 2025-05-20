import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  final HttpLink httpLink = HttpLink('https://graphqlzero.almansi.me/api');

  final client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(GraphQLProvider(
    client: client,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GraphQL Demo",
      home: TareasGraphQL(),
    );
  }
}

class TareasGraphQL extends StatelessWidget {
  final String consulta = """
    query {
      todos(options: {paginate: {page: 1, limit: 10}}) {
        data {
          id
          title
          completed
        }
      }
   }
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas con GraphQL"),
      ),
      body: Query(
        options: QueryOptions(document: gql(consulta)),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (result.hasException) {
            return Center(
              child: Text(result.exception.toString()),
            );
          }
          
          final tareas = result.data?['todos']['data'] ?? [];

          return ListView.builder(
            itemCount: tareas.length,
            itemBuilder: (context, index) {
              final tarea = tareas[index];
              return ListTile(
                title: Text(tarea['title']),
                trailing: Icon(
                  tarea['completed'] ? Icons.check : Icons.close,
                  color: tarea['completed'] ? Colors.green : Colors.red,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
