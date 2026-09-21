import 'package:flutter/material.dart';

import 'data/load_store.dart';
import 'models/truck_load.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TruckingApp(store: SharedPreferencesLoadStore()));
}

class TruckingApp extends StatelessWidget {
  const TruckingApp({super.key, required this.store});

  final LoadStore store;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trucking Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: DashboardPage(store: store),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.store});

  final LoadStore store;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<TruckLoad>> _loadsFuture;

  @override
  void initState() {
    super.initState();
    _reloadLoads();
  }

  void _reloadLoads() {
    _loadsFuture = widget.store.getLoads();
  }

  Future<void> _openCreateLoad() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => CreateLoadPage(store: widget.store),
      ),
    );

    if (created == true && mounted) {
      setState(_reloadLoads);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Load saved successfully.')),
      );
    }
  }

  Future<void> _refreshLoads() async {
    setState(_reloadLoads);
    await _loadsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trucking Platform'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      drawer: const _AppDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('create-load-button'),
        onPressed: _openCreateLoad,
        icon: const Icon(Icons.add),
        label: const Text('Create load'),
      ),
      body: FutureBuilder<List<TruckLoad>>(
        future: _loadsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _ErrorState(
              message: 'Could not load saved loads.',
              onRetry: () => setState(_reloadLoads),
            );
          }

          final loads = snapshot.data ?? <TruckLoad>[];

          return RefreshIndicator(
            onRefresh: _refreshLoads,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _StatCard(
                          label: 'Loads posted',
                          value: '${loads.length}',
                          icon: Icons.inventory_2_outlined,
                        ),
                        _StatCard(
                          label: 'Active loads',
                          value:
                              '${loads.where((load) => load.status == 'Posted').length}',
                          icon: Icons.local_shipping_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Latest loads',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                if (loads.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyLoads(),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                    sliver: SliverList.builder(
                      itemCount: loads.length,
                      itemBuilder: (context, index) =>
                          _LoadCard(load: loads[index]),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CreateLoadPage extends StatefulWidget {
  const CreateLoadPage({super.key, required this.store});

  final LoadStore store;

  @override
  State<CreateLoadPage> createState() => _CreateLoadPageState();
}

class _CreateLoadPageState extends State<CreateLoadPage> {
  final _formKey = GlobalKey<FormState>();
  final _pickupController = TextEditingController();
  final _deliveryController = TextEditingController();
  final _cargoController = TextEditingController();
  final _weightController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _pickupController.dispose();
    _deliveryController.dispose();
    _cargoController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? _validateWeight(String? value) {
    final requiredMessage = _required(value);
    if (requiredMessage != null) return requiredMessage;

    final weight = double.tryParse(value!.trim());
    if (weight == null || weight <= 0) {
      return 'Enter a weight greater than 0.';
    }
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final now = DateTime.now();
    final load = TruckLoad(
      id: now.microsecondsSinceEpoch.toString(),
      pickup: _pickupController.text.trim(),
      delivery: _deliveryController.text.trim(),
      cargo: _cargoController.text.trim(),
      weightTons: double.parse(_weightController.text.trim()),
      createdAt: now,
    );

    try {
      await widget.store.saveLoad(load);
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not save the load. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create load')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                key: const Key('pickup-field'),
                controller: _pickupController,
                decoration: const InputDecoration(
                  labelText: 'Pickup location',
                  prefixIcon: Icon(Icons.trip_origin),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('delivery-field'),
                controller: _deliveryController,
                decoration: const InputDecoration(
                  labelText: 'Delivery location',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('cargo-field'),
                controller: _cargoController,
                decoration: const InputDecoration(
                  labelText: 'Cargo type',
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                  border: OutlineInputBorder(),
                ),
                textInputAction: TextInputAction.next,
                validator: _required,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('weight-field'),
                controller: _weightController,
                decoration: const InputDecoration(
                  labelText: 'Weight (tons)',
                  prefixIcon: Icon(Icons.scale_outlined),
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                validator: _validateWeight,
                onFieldSubmitted: (_) {
                  if (!_saving) _save();
                },
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                key: const Key('save-load-button'),
                onPressed: _saving ? null : _save,
                icon: _saving
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(_saving ? 'Saving...' : 'Save load'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadCard extends StatelessWidget {
  const _LoadCard({required this.load});

  final TruckLoad load;

  @override
  Widget build(BuildContext context) {
    final date = load.createdAt.toLocal();
    final dateLabel =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          child: Text(load.cargo.substring(0, 1).toUpperCase()),
        ),
        title: Text(
          '${load.pickup} → ${load.delivery}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${load.cargo} • ${load.weightTons.toStringAsFixed(1)} tons • $dateLabel',
          ),
        ),
        trailing: Chip(label: Text(load.status)),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(label),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyLoads extends StatelessWidget {
  const _EmptyLoads();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              'No loads yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            const Text(
              'Create your first load. It will remain available after restarting the app.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.redAccent),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Trucking Platform',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard_outlined),
            title: Text('Dashboard'),
          ),
          ListTile(
            leading: Icon(Icons.local_shipping_outlined),
            title: Text('My loads'),
          ),
        ],
      ),
    );
  }
}
