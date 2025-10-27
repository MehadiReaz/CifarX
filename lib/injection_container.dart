import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection_container.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  // externalPackageModulesAfter: [
  //   ExternalModule(AuthModule),
  //   ExternalModule(ProfileModule),
  // ],
)
Future<void> configureDependencies() async => getIt.init();

Future<void> setup() async {
  await configureDependencies();
}
