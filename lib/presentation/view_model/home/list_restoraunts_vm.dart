import 'package:injectable/injectable.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class ListRestorauntsVM extends BaseVM{
  ListRestorauntsVM(AppLocalizations appLocalizations) : super(appLocalizations);

}