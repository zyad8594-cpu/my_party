from pathlib import Path
import re


def create_structure_from_tree(tree_text):
    """
    تقوم هذه الدالة بتحليل نص شجرة الملفات وإنشاء المجلدات والملفات فعلياً.
    """
    lines = tree_text.strip().split('\n')
    # مكدس (Stack) لتتبع المسار الحالي بناءً على العمق
    # المفتاح هو مستوى المسافة البادئة، والقيمة هي اسم المجلد
    path_stack = { -1: Path(".") } 

    print("🚀 البدء في بناء هيكل المشروع...\n")

    for line in lines:
        if not line.strip():
            continue

        # 1. تنظيف السطر من رموز الشجرة (├── , └── , │)
        # نستخدم regex لإزالة الرموز مع الحفاظ على المسافات البادئة
        clean_name = re.sub(r'[│├└─]', ' ', line)
        name = clean_name.strip()
        
        # 2. حساب مستوى العمق بناءً على المسافات البادئة
        # نحدد مكان أول حرف في السطر المنظف
        depth = clean_name.find(name)

        # 3. تحديد المسار الأب
        # نبحث عن أقرب عمق أصغر من العمق الحالي في المكدس
        parent_depth = max([d for d in path_stack.keys() if d < depth])
        parent_path = path_stack[parent_depth]

        # 4. التمييز بين الملف والمجلد
        # إذا كان ينتهي بـ / أو لا يحتوي على نقطة (نقطة الامتداد) فهو مجلد
        is_directory = name.endswith('/') or '.' not in name
        current_path = parent_path / name.rstrip('/')

        if is_directory:
            current_path.mkdir(parents=True, exist_ok=True)
            path_stack[depth] = current_path
            print(f"📁 مجلد: {current_path}")
        else:
            current_path.parent.mkdir(parents=True, exist_ok=True)
            current_path.touch(exist_ok=True)
            print(f"📄 ملف  : {current_path}")

    print("\n✅ تم إنشاء الهيكل بنجاح!")

# نص الشجرة الخاص بك
project_tree = """
lib/
├── main.dart
├── core/
│   ├── constants/
│   │   └── api_constants.dart
│   ├── routes/
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   └── auth_service.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── helpers.dart
├── data/
│   ├── models/
│   │   ├── coordinator.dart
│   │   ├── supplier.dart
│   │   ├── service.dart
│   │   ├── client.dart
│   │   ├── event.dart
│   │   ├── task.dart
│   │   ├── income.dart
│   │   └── notification.dart
│   ├── providers/
│   │   └── api_provider.dart
│   └── repositories/
│       ├── auth_repository.dart
│       ├── coordinator_repository.dart
│       ├── supplier_repository.dart
│       ├── service_repository.dart
│       ├── client_repository.dart
│       ├── event_repository.dart
│       ├── task_repository.dart
│       └── income_repository.dart
├── logic/
│   └── controllers/
│       ├── auth_controller.dart
│       ├── home_controller.dart
│       ├── coordinator_controller.dart
│       ├── supplier_controller.dart
│       ├── service_controller.dart
│       ├── client_controller.dart
│       ├── event_controller.dart
│       ├── task_controller.dart
│       └── income_controller.dart
└── presentation/
    ├── screens/
    │   ├── auth/
    │   │   ├── login_screen.dart
    │   │   └── register_screen.dart
    │   ├── home/
    │   │   └── home_screen.dart
    │   ├── coordinators/
    │   │   ├── coordinator_list_screen.dart
    │   │   └── coordinator_detail_screen.dart
    │   ├── suppliers/
    │   │   ├── supplier_list_screen.dart
    │   │   └── supplier_detail_screen.dart
    │   ├── services/
    │   │   └── service_list_screen.dart
    │   ├── clients/
    │   │   └── client_list_screen.dart
    │   ├── events/
    │   │   ├── event_list_screen.dart
    │   │   └── event_detail_screen.dart
    │   ├── tasks/
    │   │   ├── task_list_screen.dart
    │   │   └── task_detail_screen.dart
    │   └── incomes/
    │       └── income_list_screen.dart
    ├── widgets/
    │   ├── loading_widget.dart
    │   └── custom_app_bar.dart
    └── bindings/
        ├── auth_binding.dart
        ├── home_binding.dart
        ├── coordinator_binding.dart
        ├── supplier_binding.dart
        ├── service_binding.dart
        ├── client_binding.dart
        ├── event_binding.dart
        ├── task_binding.dart
        └── income_binding.dart
"""
    

# ملاحظة: قمت بوضع النص كاملاً في المتغير أدناه عند التشغيل
if __name__ == "__main__":
    # استبدل النص بمتغير يحتوي على كامل الهيكل الذي أرسلته أنت
    create_structure_from_tree(project_tree)