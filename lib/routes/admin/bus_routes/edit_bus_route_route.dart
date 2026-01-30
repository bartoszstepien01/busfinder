import 'package:busfinder/services/api_service.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/dialogs/error_dialog.dart';
import 'package:busfinder/widgets/common/loading_indicator.dart';
import 'package:busfinder/widgets/layout/wizard_layout.dart';

import 'package:busfinder_api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditBusRouteRoute extends StatefulWidget {
  const EditBusRouteRoute({super.key, required this.busRoute});

  final BusRouteResponseShortDto busRoute;

  @override
  State<EditBusRouteRoute> createState() => _EditBusRouteRouteState();
}

class _EditBusRouteRouteState extends State<EditBusRouteRoute> {
  final _formKey = GlobalKey<FormBuilderState>();
  final PageController _pageViewController = PageController();
  late BusRouteResponseDto _route;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoute();
  }

  Future<void> _loadRoute() async {
    final api = context.read<ApiService>();
    final route = BusRouteControllerApi(api.client);

    try {
      final response = await route.getRoute(widget.busRoute.id);
      setState(() {
        _route = response!.data!;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _saveRoute() async {
    final name = _formKey.currentState?.fields['name']?.value;

    final api = context.read<ApiService>();
    final routes = BusRouteControllerApi(api.client);
    final payload = EditBusRouteDto(
      id: widget.busRoute.id,
      name: name,
      variants: _route.variants
          .map(
            (e) => EditRouteVariantDto(
              id: e.id,
              name: e.name,
              busStopIds: e.busStops,
            ),
          )
          .toList(),
    );

    try {
      await routes.editRoute(payload);
      if (mounted) {
        context.pop(
          BusRouteResponseShortDto(id: widget.busRoute.id, name: name),
        );
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, e);
      }
    }
  }

  Future<void> _addVariant() async {
    final result = await context.push<RouteVariantResponseDto>(
      '/admin/routes/edit/variant',
    );
    if (result != null) {
      setState(() {
        _route = BusRouteResponseDto(
          id: _route.id,
          name: _route.name,
          variants: [..._route.variants, result],
        );
      });
    }
  }

  Future<void> _editVariant(RouteVariantResponseDto variant) async {
    final result = await context.push<RouteVariantResponseDto>(
      '/admin/routes/edit/variant',
      extra: {'variant': variant},
    );
    if (result != null) {
      setState(() {
        final index = _route.variants.indexOf(variant);
        if (index != -1) {
          _route.variants[index] = result;
        }
      });
    }
  }

  void _deleteVariant(RouteVariantResponseDto variant) {
    setState(() {
      _route.variants = List.from(_route.variants)..remove(variant);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(localizations.editRoute)),
        body: const LoadingIndicator(),
      );
    }

    return WizardLayout(
      title: localizations.editRoute,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                initialValue: _route.name,
                decoration: InputDecoration(
                  icon: Icon(Icons.label),
                  labelText: localizations.routeName,
                ),
                validator: FormBuilderValidators.required(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.directional(start: 8),
                    child: Text(
                      localizations.variants,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addVariant,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _route.variants.length,
                  itemBuilder: (context, index) {
                    final variant = _route.variants[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          variant.standard
                              ? localizations.standard
                              : variant.name,
                        ),
                        subtitle: Text(
                          localizations.nStops(variant.busStops.length),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editVariant(variant),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: variant.standard
                                  ? null
                                  : () => _deleteVariant(variant),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
