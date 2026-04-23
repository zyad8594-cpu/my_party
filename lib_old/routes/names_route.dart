
part of 'routes.dart';

class Names 
{
  static const 
    PAGES = '/pages',
        AUTH = '$PAGES/auth', 
            AUTH_AUTH     = '$AUTH/auth_page',
            AUTH_LOGIN    = '$AUTH/login_page',
            AUTH_REGISTER = '$AUTH/register_page',

        HOME = '$PAGES/home',
            HOME_HOME  = '$HOME/home_page',
            HOME_INDEX = '$HOME/index_page',

        EVENTS = '$PAGES/events',
            EVENTS_EVENTS  = '$EVENTS/events_page',
            EVENTS_INDEX   = '$EVENTS/index_page',
            EVENTS_DATAIL  = '$EVENTS/detail_page',
            EVENTS_CREATE  = '$EVENTS/create_page',
            EVENTS_MEMBERS = '$EVENTS/members_page',

        TASKS = '$PAGES/tasks',
            TASKS_TASKS   = '$TASKS/tasks_page',
            TASKS_INDEX  = '$TASKS/index_page',
            TASKS_ASSIGN = '$TASKS/assign_page',
            TASKS_DATAIL = '$TASKS/detail_page',
            TASKS_CREATE = '$TASKS/create_page',
          
        PROFILE = '$PAGES/profile',
            PROFILE_PROFILE         = '$PROFILE/profile_page',
            PROFILE_INDEX           = '$PROFILE/index_page',
            PROFILE_CHANGE_PASSWORD = '$PROFILE/change_password_page',
            PROFILE_UPDATE          = '$PROFILE/update_page'
  ;



}