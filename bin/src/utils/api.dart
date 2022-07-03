import 'package:shelf/shelf.dart';

import '../infra/dependency_injector/dependency_injector.dart';
import '../infra/security/security_service.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool securityRoute = true,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool securityRoute = true,
  }) {
    middlewares ??= [];

    if (securityRoute) {
      SecurityService securityService =
          DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        securityService.authorization,
        securityService.verifyJwt,
      ]);
    }

    Pipeline pipeline = Pipeline();
    for (Middleware middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }
    return pipeline.addHandler(router);
  }
}
