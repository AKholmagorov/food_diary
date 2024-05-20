import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key, bool isEditMode = false});

  abstract final bool isEditMode;
}