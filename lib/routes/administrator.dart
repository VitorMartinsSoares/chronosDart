import 'dart:convert';
import 'package:chronos_dart/data_base.dart';
import 'package:chronos_dart/models/user.dart';
import 'package:chronos_dart/routes/abstract_routes.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shelf/shelf.dart';
import 'package:dbcrypt/dbcrypt.dart';

class Administrator extends AbstractRoutes {
  Administrator();

  DBCrypt dbcrypt = DBCrypt();

  Future<Response> registerUser(Request request) async {
    String message = await request.readAsString();
    String token = request.headers['Authorization']!;
    Map<String, dynamic> userMap = jsonDecode(message);
    print(userMap);
    User u = User.fromUser(userMap["user"]);
    u.hash = (dbcrypt.hashpw(
      userMap["user"]["password"]!,
      dbcrypt.gensalt(),
    ));
    if (verify(token)['isAdmin'] == 1) {
      print("This user is Admin");
    } else {
      print("This user is not Admin");
      return Response(
        400,
        body: "This user is not Admin",
      );
    }
    try {
      await DataBase().registerUser(u.toMap());
    } on MySqlException catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    } catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    }
    return Response.ok('Usuário registrado com sucesso!!');
  }

  Future<Response> getUsers(Request request) async {
    String token = request.headers['Authorization']!;
    if (verify(token)['isAdmin'] == 1) {
      print("This user is Admin");
    } else {
      print("This user is not Admin");
      return Response(
        400,
        body: "This user is not Admin",
      );
    }
    Results users;
    DataBase db = DataBase();
    try {
      users = await db.getUsers();
    } on MySqlException catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    } catch (e) {
      print(e);
      return Response(
        500,
        body: e.toString(),
      );
    }
    return Response.ok('${jsonEncode(users.toList())}\n');
  }
}
