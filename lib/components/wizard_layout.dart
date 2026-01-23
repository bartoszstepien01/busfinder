import 'package:busfinder/components/keep_alive_wrapper.dart';
import 'package:busfinder/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class WizardLayout extends StatelessWidget {
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
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FormBuilder(
        key: formKey,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages.map((page) => KeepAliveWrapper(child: page)).toList(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    final index = pageController.page?.round() ?? 0;
                    return ElevatedButton.icon(
                      onPressed: index == 0 ? onNext : onSave,
                      label: Text(index == 0 ? localizations.next : 'Save'),
                      icon: Icon(index == 0 ? Icons.chevron_right : Icons.save),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
