import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:chat_hasura/app/models/MessageModel.dart';
import 'package:hasura_connect/hasura_connect.dart';

import 'models/UserModel.dart';

class AppRepository extends Disposable {
  final HasuraConnect connection;

  AppRepository(this.connection);

  // CRUD

  Future<dynamic> getUser(String user) async {
    var userQuery = """
    
    getUser(\$name:String!){
      user(where: {name: {_eq: \$name}}) {
        name
        id
      }
    }
    """;

    var userData = await connection.query(userQuery, variables: {"name": user});

    if (userData["data"]["user"].isEmpty) {
      // Cria mutation

      return createUser(user);
    } else {
      return UserModel.fromJson(userData["data"]["user"][0]);
    }
  }

  Future<dynamic> createUser(String name) async {
    var createQuery = """
    createUser(\$name:String!){
      insert_user(objects: {name: \$name}) {
        returning {
          id
    }
  }
}

      """;

    var data =
        await connection.mutation(createQuery, variables: {"name": name});

    var id = data["data"]["inser_user"]["returning"][0]["id"];

    UserModel(id: id, name: name);
  }

  Stream<List<MessageModel>> getMessages() {
    var messageQuery = """

  subscription {
      messages(order_by: {id: desc}) {
        content
        id
        user {
          name
          id
    }
  }
}

    """;

    Snapshot snapshot = connection.subscription(messageQuery);
    return snapshot.map(
        (jsonList) => MessageModel.fromJsonList(jsonList["data"]["messages"]));
  }

  Future<dynamic> sendMessage(String message, int userId) {
    var query = """

  sendMessage(\$message:String!, \$userId:Int!) {

      insert_messages(objects: {id_usuario: \$userId, content: \$message}) {
        affected_rows
  }
}

    """;

    return connection
        .mutation(query, variables: {"message": message, "userId": userId});
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
