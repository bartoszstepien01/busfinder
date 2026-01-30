import 'package:busfinder/widgets/keep_alive_wrapper.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:busfinder/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class WizardLayout extends StatefulWidget {
  const WizardLayout({
    super.key,
    required this.title,
    required this.formKey,
    required this.pageController,
    required this.pages,
    required this.onNext,
    required this.onSave,
  });

  final String title;
  final GlobalKey<FormBuilderState> formKey;
  final PageController pageController;
  final List<Widget> pages;
  final VoidCallback onNext;
  final Future<void> Function() onSave;

  @override
  State<WizardLayout> createState() => _WizardLayoutState();
}

class _WizardLayoutState extends State<WizardLayout> {
  bool _isLoading = false;

  @override
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ResponsiveContainer(
        child: FormBuilder(
          key: widget.formKey,
          child: Stack(
            children: [
              PageView(
                controller: widget.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: widget.pages
                    .map((page) => KeepAliveWrapper(child: page))
                    .toList(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedBuilder(
                    animation: widget.pageController,
                    builder: (context, child) {
                      final index = widget.pageController.page?.round() ?? 0;
                      return ElevatedButton.icon(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (index == 0) {
                                  widget.onNext();
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    await widget.onSave();
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                }
                              },
                        label: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                index == 0
                                    ? localizations.next
                                    : localizations.save,
                              ),
                        icon: _isLoading
                            ? const SizedBox.shrink()
                            : Icon(
                                index == 0 ? Icons.chevron_right : Icons.save,
                              ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
