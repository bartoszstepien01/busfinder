import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/bus_stop_list.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/loading_indicator.dart';
import 'package:busfinder/components/stop_selection_dialog.dart';
import 'package:busfinder/components/wizard_layout.dart';

import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddVariantRoute extends StatefulWidget {
  const AddVariantRoute({super.key, this.variant});

  final RouteVariantResponseDto? variant;

  @override
  State<AddVariantRoute> createState() => _AddVariantRouteState();
}

class _AddVariantRouteState extends State<AddVariantRoute> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PageController _pageViewController;
  List<BusStopResponseDto> _selectedStops = [];
  List<BusStopResponseDto> _availableStops = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(
      initialPage: widget.variant?.standard ?? false ? 1 : 0,
    );
    _fetchAvailableStops();
  }

  Future<void> _fetchAvailableStops() async {
    final api = context.read<ApiService>();
    final stopsApi = BusStopControllerApi(api.client);
    try {
      final response = await stopsApi.getAllBusStops();
      if (response != null) {
        setState(() {
          _availableStops = response.data;
          if (widget.variant != null) {
            _selectedStops = widget.variant!.busStops
                .map(
                  (id) => _availableStops.firstWhere(
                    (stop) => stop.id == id,
                    orElse: () =>
                        BusStopResponseDto(id: id, name: 'Unknown Stop', location: LocationDto(latitude: 0, longitude: 0)),
                  ),
                )
                .toList();
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveVariant() {
    final name = _formKey.currentState?.fields['name']?.value as String?;
    final variant = RouteVariantResponseDto(
      id: widget.variant?.id ?? '',
      name: name ?? '',
      busStops: _selectedStops.map((e) => e.id).toList(),
      standard: widget.variant?.standard ?? false
    );
    context.pop(variant);
  }

  void _addStop() {
    showDialog(
      context: context,
      builder: (context) => StopSelectionDialog(
        availableStops: _availableStops,
        onStopSelected: (stop) {
          setState(() {
            _selectedStops.add(stop);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
            title: Text(widget.variant == null ? 'Add Variant' : 'Edit Variant')),
        body: const LoadingIndicator(),
      );
    }

    return WizardLayout(
      title: widget.variant == null ? 'Add Variant' : 'Edit Variant',
      formKey: _formKey,
      pageController: _pageViewController,
      onNext: () {
        _formKey.currentState?.save();
        if (_formKey.currentState?.fields['name']?.validate() ?? false) {
          _pageViewController.animateToPage(
            1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
      onSave: _saveVariant,
      pages: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                initialValue: widget.variant?.name,
                decoration: const InputDecoration(
                  labelText: 'Variant Name',
                  icon: Icon(Icons.label),
                ),
                validator: FormBuilderValidators.required(),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Stops',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addStop,
                  ),
                ],
              ),
            ),
            Expanded(
              child: BusStopList(
                stops: _selectedStops,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final item = _selectedStops.removeAt(oldIndex);
                    _selectedStops.insert(newIndex, item);
                  });
                },
                onDelete: (index) {
                  setState(() {
                    _selectedStops.removeAt(index);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
