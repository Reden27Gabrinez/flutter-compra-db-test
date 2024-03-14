import 'package:compra/consts/consts.dart';

Widget loadingIndicator()
{
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(Colors.yellow),
  );
}