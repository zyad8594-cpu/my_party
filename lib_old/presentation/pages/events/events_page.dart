import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/routes.dart' as routes;
import '../../controllers/controllers.dart' 
  as controllers show 
    Auth, 
    User, 
    Event, 
    EventMember;

import '../../../data/models/models.dart' 
  as models show 
    UserModel, 
    EventModel, 
    EventMemberModel;

import '../../widgets/widgets.dart' 
  as widgets show 
    AppBar, 
    LoadingWidget, 
    EmptyWidget;


export 'index/index_page.dart';

export 'detail/detail_page.dart';

part 'create_page.dart';

part 'members_page.dart';

