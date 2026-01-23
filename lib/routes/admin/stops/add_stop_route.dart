import 'package:busfinder/api_service.dart';
import 'package:busfinder/components/error_dialog.dart';
import 'package:busfinder/components/location_selector.dart';
import 'package:busfinder/components/wizard_layout.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class AddStopRoute extends StatefulWidget {
  const AddStopRoute({super.key, this.busStop});

  final BusStopResponseDto? busStop;

  @override
  State<AddStopRoute> createState() => _AddStopRouteState();
}

class _AddStopRouteState extends State<AddStopRoute> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final PageController _pageViewController = PageController();
  final MapController _mapController = MapController();

  Future<void> createBusStop(String name, LatLng location) async {
    final api = context.read<ApiService>();
    final stops = BusStopControllerApi(api.client);
    final payload = CreateBusStopDto(
      name: name,
      location: LocationDto(
        longitude: location.longitude,
        latitude: location.latitude,
      ),
    );

    try {
      final response = await stops.createBusStop(payload);
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

  Future<void> editBusStop(String name, LatLng location) async {
    final api = context.read<ApiService>();
    final stops = BusStopControllerApi(api.client);
    final payload = EditBusStopDto(
      id: widget.busStop?.id ?? '',
      name: name,
      location: LocationDto(
        longitude: location.longitude,
        latitude: location.latitude,
      ),
    );

    try {
      final response = await stops.editBusStop(payload);
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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return WizardLayout(
      title: widget.busStop == null
          ? localizations.addStop
          : localizations.editStop,
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
      onSave: () async {
        final name = _formKey.currentState!.fields['name']?.value;
        final location = _mapController.camera.center;

        if (widget.busStop == null) {
          await createBusStop(name, location);
        } else {
          await editBusStop(name, location);
        }
      },
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
                  labelText: localizations.stopName,
                ),
                initialValue: widget.busStop?.name,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ],
          ),
        ),
        LocationSelector(
          mapController: _mapController,
          initialPosition: LatLng(
            widget.busStop?.location.longitude ?? 0,
            widget.busStop?.location.latitude ?? 0,
          ),
        ),
      ],
    );
  }
}

