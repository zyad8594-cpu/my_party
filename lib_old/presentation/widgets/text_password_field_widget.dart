part of 'widgets.dart';

class TextPasswordField extends StatelessWidget
{
  final String label;
  final String name;
  final void Function(String) update;
  final IconData prefixIcon;
  final controllers.Auth controller;

  const TextPasswordField({
    super.key, 
    required this.controller,
    required this.update,
    required this.name,
    this.prefixIcon = Icons.lock,
    this.label = 'كلمة المرور'
  });
  @override
  Widget build(BuildContext context) {
    return Obx(()=>TextField(
          onChanged: (val)=> update(val),
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: IconButton
            (
              onPressed: controller.fileds.show.toggle(name),
              icon: Icon(controller.fileds.show[name]!? Icons.visibility : Icons.visibility_off)
            ),
            
            border: OutlineInputBorder(),
          ),
          obscureText: !controller.fileds.show[name]!,                                // إخفاء النص (كلمة مرور)
        ),
    );
  }
  
}