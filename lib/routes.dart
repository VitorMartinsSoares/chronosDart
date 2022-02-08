import 'package:shelf_router/shelf_router.dart';
import 'package:chronos_dart/routes/users.dart';

class Routes {
  Routes();

  final _router = Router()
    //all
    ..post('/login', Users().login)
    ..post('/upload', Users().login)
    ..post('/historico', Users().login)
    ..post('/desfazer', Users().login)
    //professor
    ..post('/professor', Users().login)
    ..put('/professor', Users().login)
    ..get('/professor', Users().login)
    ..delete('/professor/<id>', Users().login)
    //datas
    ..post('/datas', Users().login)
    //resources
    ..post('/resources', Users().login)
    ..put('/resources', Users().login)
    ..get('/resources', Users().login)
    ..delete('/resources', Users().login)
    //dataresources
    ..get('/dataresources', Users().login)
    //typeresources
    ..get('/typeresources', Users().login)
    ..delete('/typeresources', Users().login)
    ..get('/typeresources', Users().login)
    ..post('/typeresources', Users().login)
    ..put('/typeresources', Users().login)
    //professorSchedule
    ..post('/professorSchedule', Users().login)
    ..get('/professorSchedule', Users().login)
    ..get('/professorSchedule/<horario>', Users().login)
    ..put('/professorSchedule', Users().login)
    ..delete('/professorSchedule/', Users().login);

  Router getRouter() {
    return _router;
  }
}
