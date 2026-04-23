// استيراد الحزم المطلوبة
import 'package:flutter/material.dart' hide AppBar, Drawer;
import 'package:flutter/material.dart' as material show AppBar, Drawer;

import 'package:get/get.dart';
import '../../core/core.dart' as Consetents show Config;
import '../../data/models/models.dart' as models 
    show EventModel, TaskModel, EventMemberModel;
import '../controllers/controllers.dart' as controllers 
    show Auth;
import '../../routes/routes.dart' as routes;

part 'appbar_widget.dart';
part 'disabled_or_available_icon_button_widget.dart';
part 'drawar_widget.dart';
part 'event_card_widget.dart';
part 'event_member_card_widget.dart';
part 'loading_widget.dart';
part 'task_card_widget.dart';
part 'text_password_field_widget.dart';