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

class AddBusRouteRoute extends StatefulWidget {
  const AddBusRouteRoute({super.key});

  @override
  State<AddBusRouteRoute> createState() => _AddBusRouteRouteState();
}

class _AddBusRouteRouteState extends State<AddBusRouteRoute> {
  final _formKey = GlobalKey<FormBuilderState>();
  final PageController _pageViewController = PageController();
  final List<BusStopResponseDto> _selectedStops = [];
  List<BusStopResponseDto> _availableStops = [];
  bool _isLoadingStops = true;

  @override
  void initState() {
    super.initState();

    _fetchAvailableStops();
  }

  Future<void> _fetchAvailableStops() async {
    final api = context.read<ApiService>();
    final stopsApi = BusStopControllerApi(api.client);
    setState(() {
      _isLoadingStops = true;
    });
    try {
      final response = await stopsApi.getAllBusStops();
      if (response != null) {
        setState(() {
          _availableStops = response.data;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingStops = false;
        });
      }
    }
  }

  void _saveRoute() async {
    final name = _formKey.currentState?.fields['name']?.value as String;
    final api = context.read<ApiService>();
    final routes = BusRouteControllerApi(api.client);

    final payload = CreateBusRouteDto(
        name: name, busStops: _selectedStops.map((e) => e.id).toList());
    
    try {
      final response = await routes.createRoute(payload);
      if (mounted && response?.data != null) {
        context.pop(response!.data);
      } else if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  void _addStop() {
    showDialog(
      context: context,
      builder: (context) => StopSelectionDialog(
        availableStops: _availableStops,
        onStopSelected: (stop) {
          setState(() {
            _selectedStops.add(
              BusStopResponseDto(
                id: stop.id,
                name: stop.name,
                location: LocationDto(
                  latitude: stop.location.latitude,
                  longitude: stop.location.longitude,
                ),
              ),
            );
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WizardLayout(
      title: 'Add route',
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
      onSave: _saveRoute,
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
                decoration: InputDecoration(
                  icon: Icon(Icons.label),
                  labelText: 'Bus route name',
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
              child: _isLoadingStops
                  ? const LoadingIndicator()
                  : BusStopList(
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
