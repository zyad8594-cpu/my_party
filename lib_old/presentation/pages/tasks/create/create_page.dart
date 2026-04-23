import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/controllers.dart' as controllers 
    show Auth, Task, Event;
import '../../../../data/models/models.dart' as models 
  show TaskModel, EventModel;
import '../../../widgets/widgets.dart' as widgets show AppBar;

part 'create_other_parts.dart';

// صفحة إنشاء وتعديل المهمة
class CreateTask extends GetView<controllers.Task> {

  final eventController = Get.find<controllers.Event>();
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  
  models.EventModel? _selectedEvent;
  bool _isEditMode = false;
  models.TaskModel? _editingTask;

  CreateTask({super.key});
  
  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth((){
    _initializePage();
    eventController.fetchEvents();
    
    return Scaffold(
      appBar: widgets.AppBar(
        title: (_isEditMode ? 'تعديل المهمة' : 'إنشاء مهمة جديدة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // اختيار الحدث
                ..._buildEventDropdown(),
              
                // عنوان المهمة
                ..._buildTitle(),
                
                // وصف المهمة
                ..._buildDescription(),
                
                // تاريخ الاستحقاق
                ..._buildStartDate(context),
                
                // زر الحفظ
                ..._buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  });

}