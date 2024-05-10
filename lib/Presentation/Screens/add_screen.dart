import 'package:flutter/material.dart';

abstract class AddScreen extends StatefulWidget {
  const AddScreen({super.key, bool isEditMode = false});

  abstract final bool isEditMode;
}