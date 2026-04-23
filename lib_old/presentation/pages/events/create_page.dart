part of 'events_page.dart';

// صفحة إنشاء وتعديل الحدث مع الوراثة من GetView
class CreateEvent extends GetView<controllers.Event> 
{
  
  final _formKey = GlobalKey<FormState>();                    // مفتاح نموذج التحقق
  final TextEditingController _nameController = TextEditingController(); // 
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  
  bool _isEditMode = false;                                   // وضع التعديل
  models.EventModel? _editingEvent;                                  // الحدث الذي يتم تعديله

  
  CreateEvent({super.key});

  // تهيئة بيانات الصفحة
  void _initializePage() 
  {
    final dynamic arguments = Get.arguments;
    if (arguments is models.EventModel) 
    {
      _isEditMode = true;
      _editingEvent = arguments;
      _fillFormData();                                        // تعبئة بيانات التعديل
    }
  }

  // تعبئة النموذج ببيانات الحدث
  void _fillFormData() 
  {
    if (_editingEvent != null) 
    {
      _nameController.text = _editingEvent!.name;
      _descController.text = _editingEvent!.description ?? '';
      _locationController.text = _editingEvent!.location ?? '';
      controller.startDate.value =  _editingEvent!.startDate;
      controller.endDate.value =  _editingEvent!.endDate ?? controller.endDate.value;
    }
  }

  @override
  Widget build(BuildContext context) => controllers.Auth.widgetAuth(() {
    _initializePage();
    return Scaffold
    (
      appBar: widgets.AppBar
      (
        title: (_isEditMode ? 'تعديل الحدث' : 'إنشاء حدث جديد'),
      ),

      body: Padding
      (
        padding: const EdgeInsets.all(16.0),
        child: Form
        (
          key: _formKey,
          child: SingleChildScrollView
          (
            child: Column
            (
              children: 
              [
                // حقل اسم الحدث
                TextFormField
                (
                  controller: _nameController,
                  decoration: const InputDecoration
                  (
                    labelText: 'اسم الحدث *',
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) 
                  {
                    if (value == null || value.isEmpty) 
                    {
                      return 'يرجى إدخال اسم الحدث';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // حقل موقع الحدث
                TextFormField
                (
                  controller: _locationController,
                  decoration: const InputDecoration
                  (
                    labelText: 'موقع الحدث *',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                
                // حقل وصف الحدث
                TextFormField
                (
                  controller: _descController,
                  decoration: const InputDecoration
                  (
                    labelText: 'وصف الحدث',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),

                  maxLines: 3,
                  maxLength: 500,
                ),
                const SizedBox(height: 16),
                
                // تاريخ البدء
                Obx(()=>ListTile
                  (
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('تاريخ البدء *'),
                    subtitle: Text(_formatDate(controller.startDate.value)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => controller.selectStartDate(context),
                  ),
                ),
                const SizedBox(height: 8),
                
                // تاريخ الانتهاء
                Obx(()=>ListTile
                  (
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('تاريخ الانتهاء'),
                    subtitle: Text(controller.endDate.value != null ? _formatDate(controller.endDate.value!) : 'اختياري'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => controller.selectEndDate(context),
                  ),
                ),
                const SizedBox(height: 24),
                
                // زر الحفظ
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ()=>_saveEvent(_formKey.currentState!.validate()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(_isEditMode ? 'تحديث الحدث' : 'إنشاء الحدث'),
                        ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });

  

 
  // حفظ الحدث
  void _saveEvent(bool validate) async 
  {
    if (controllers.Auth.auth() && validate) 
    {

      final event = models.EventModel(
        id: _isEditMode ? _editingEvent!.id : 0,
        name: _nameController.text.trim(),
        description: _descController.text.trim().isEmpty ? null : _descController.text.trim(),
        startDate: controller.startDate.value,
        endDate: controller.endDate.value,
        userId: controllers.Auth.user!.id,
        location: _locationController.text.trim().isEmpty? null : _locationController.text.trim(),
        createdAt: _isEditMode ? _editingEvent!.createdAt : DateTime.now(),
      );

      bool success = _isEditMode? await controller.updateEvent(event) : await controller.createEvent(event);

      if (success) 
      {
        var message = _isEditMode? 'تم تعديل الحدث بنجاح' : 'تم إنشاء احدث بنجاح';
        Get.snackbar('نجاح', message);
        Get.offAllNamed(routes.Names.EVENTS_INDEX); // العودة للصفحة السابقة
      }
    }
  }

  // تنسيق التاريخ
  String _formatDate(DateTime date) 
  {
    return '${date.year}/${date.month}/${date.day}';
  }

}