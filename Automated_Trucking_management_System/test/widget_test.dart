import 'package:automated_trucking_management_system/data/load_store.dart';
import 'package:automated_trucking_management_system/main.dart';
import 'package:automated_trucking_management_system/models/truck_load.dart';
import 'package:flutter_test/flutter_test.dart';

class MemoryLoadStore implements LoadStore {
  final List<TruckLoad> loads = [];

  @override
  Future<List<TruckLoad>> getLoads() async => List.unmodifiable(loads);

  @override
  Future<void> saveLoad(TruckLoad load) async {
    loads.insert(0, load);
  }
}

void main() {
  testWidgets('creates, stores, and reloads a load', (tester) async {
    final store = MemoryLoadStore();

    await tester.pumpWidget(TruckingApp(store: store));
    await tester.pumpAndSettle();

    expect(find.text('No loads yet'), findsOneWidget);

    await tester.tap(find.byKey(const Key('create-load-button')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('pickup-field')),
      'Lahore',
    );
    await tester.enterText(
      find.byKey(const Key('delivery-field')),
      'Karachi',
    );
    await tester.enterText(
      find.byKey(const Key('cargo-field')),
      'Textiles',
    );
    await tester.enterText(
      find.byKey(const Key('weight-field')),
      '12.5',
    );

    final saveButton = find.byKey(const Key('save-load-button'));
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pumpAndSettle();

    expect(store.loads, hasLength(1));
    expect(store.loads.single.pickup, 'Lahore');
    expect(store.loads.single.delivery, 'Karachi');
    expect(find.text('Lahore → Karachi'), findsOneWidget);
    expect(find.textContaining('Textiles • 12.5 tons'), findsOneWidget);

    await tester.pumpWidget(TruckingApp(store: store));
    await tester.pumpAndSettle();

    expect(find.text('Lahore → Karachi'), findsOneWidget);
    expect(find.text('No loads yet'), findsNothing);
  });

  testWidgets('rejects an empty load form', (tester) async {
    final store = MemoryLoadStore();

    await tester.pumpWidget(TruckingApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('create-load-button')));
    await tester.pumpAndSettle();

    final saveButton = find.byKey(const Key('save-load-button'));
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pump();

    expect(find.text('This field is required.'), findsNWidgets(4));
    expect(store.loads, isEmpty);
  });
}
