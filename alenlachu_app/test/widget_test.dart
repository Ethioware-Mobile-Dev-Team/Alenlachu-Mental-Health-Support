// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:alenlachu_app/core/admin/app.dart';
import 'package:alenlachu_app/core/common/login_manager.dart';
import 'package:alenlachu_app/core/user/app.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alenlachu_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    try {
      UserModel? user = await LoginManager.getUser();
      if (user != null) {
        if (user.role == 'admin') {
          // Build our app and trigger a frame.
          await tester.pumpWidget(const AdminApp());
        } else {
          // Build our app and trigger a frame.
          await tester.pumpWidget(const UserApp());
        }
      }
    } catch (e) {
      showToast(e.toString());
    }

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
