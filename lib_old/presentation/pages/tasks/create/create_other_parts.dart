part of 'create_page.dart';


extension on CreateTask
{
   // تهيئة الصفحة
  void _initializePage() 
  {
    final dynamic arguments = Get.arguments;
    if (arguments is models.TaskModel) {
      _isEditMode = true;
      _editingTask = arguments;
      _fillFormData();
    }
  }

  // عنوان المهمة
  List<Widget> _buildTitle()
  {
    return [
      TextFormField(
        controller: _titleController,
        decoration: const InputDecoration(
          labelText: 'عنوان المهمة *',
          border: OutlineInputBorder(),
        ),
        validator: (value) 
        {
          if (value == null || value.isEmpty) {
            return 'يرجى إدخال عنوان المهمة';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }
  
  // وصف المهمة
  List<Widget> _buildDescription()
  {
    return [
      TextFormField(
        controller: _descController,
        decoration: const InputDecoration(
          labelText: 'وصف المهمة',
          border: OutlineInputBorder(),
          alignLabelWithHint: true,
        ),
        maxLines: 4,
        maxLength: 1000,
      ),
      const SizedBox(height: 16),
    ];
  }

  // تاريخ الاستحقاق
  List<Widget> _buildStartDate(BuildContext context)
  {
    return [
      Obx(()=> ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('تاريخ الاستحقاق'),
        subtitle: Text(controller.startDate.value != null ? _formatDate(controller.startDate.value!) : 'اختياري'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => controller.selectStartDate(context),
      ),
      ),
      const SizedBox(height: 24),
    ];
  }

  // 
  List<Widget> _buildSaveButton()
  {
    return [
      Obx(() => controller.isLoading.value? 
        const CircularProgressIndicator()
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(_isEditMode ? 'تحديث المهمة' : 'إنشاء المهمة'),
            ),
          ),
      ),
    ];
  }

  // تعبئة بيانات النموذج
  void _fillFormData() {
    if (_editingTask != null) 
    {
      _titleController.text = _editingTask!.title;
      _descController.text = _editingTask!.description ?? '';
      controller.startDate.value = _editingTask?.dueDate;
      // البحث عن الحدث المرتبط
      if (_editingTask!.eventId > 0) 
      {
        _selectedEvent = eventController.events.firstWhere(
          (event) => event.id == _editingTask!.eventId,
          orElse: () => models.EventModel(
            id: 0,
            name: 'حدث غير معروف',
            startDate: DateTime.now(),
            userId: 0,
            createdAt: DateTime.now(),
          ),
        );
      }
    }
  }
  

  // Dropdown اختيار الحدث
  List<Widget> _buildEventDropdown() 
  {
    return [
      Obx(()=> DropdownButtonFormField<models.EventModel>(
        // initialValue: controller.selectedEvent.value,
        decoration: const InputDecoration(
          labelText: 'الحدث المرتبط *',
          border: OutlineInputBorder(),
        ),
        items: eventController.events.map((event) 
        {
          return DropdownMenuItem<models.EventModel>(
            value: event,
            child: Text(event.name),
          );
        }).toList(),

        onChanged: (models.EventModel? value)
        {
            controller.selectedEvent.value = value;
        },
        // validator: (value) 
        // {
        //   if (controller.selectedEvent.value == null) 
        //   {
        //     return 'يرجى اختيار حدث';
        //   }
        //   return null;
        // },
      )),
      const SizedBox(height: 16),
    ];
  }

  // حفظ المهمة
  void _saveTask() async 
  {
    if (_formKey.currentState!.validate()) 
    {
      if (controller.selectedEvent.value == null) 
      {
        Get.snackbar('خطأ', 'يرجى اختيار حدث');
        return;
      }

      
      final task = models.TaskModel(
        id: _isEditMode ? _editingTask!.id : 0,
        eventId: _selectedEvent!.id,
        title: _titleController.text.trim(),
        description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
        status: _isEditMode ? _editingTask!.status : 'pending',
        dueDate: controller.startDate.value,
        userId: controllers.Auth.userAuth().id,
        createdAt: _isEditMode ? _editingTask!.createdAt : DateTime.now(),
      );

      bool success;
      if (_isEditMode) 
      {
        success = await controller.updateTask(task);
      } 
      else 
      {
        success = await controller.createTask(task);
      }

      if (success) 
      {
        Get.snackbar('نجاح', (_isEditMode? 'تم التعديل بنجاح' : 'تم الحفظ بنجاح'));
        Get.back();
      }
    }
  }

  // تنسيق التاريخ
  String _formatDate(DateTime date) 
  {
    return '${date.year}/${date.month}/${date.day}';
  }
  
}