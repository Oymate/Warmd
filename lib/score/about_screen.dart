import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:markup_text/markup_text.dart';
import 'package:warmd/common/blue_card.dart';
import 'package:warmd/common/common.dart';
import 'package:warmd/common/screen_template.dart';
import 'package:warmd/generated/locale_keys.g.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      body: Column(
        children: [
          SvgPicture.asset(
            'assets/splash.svg',
          ),
          Gaps.h48,
          _buildWarmdProjectCard(context),
          _buildSourcesCard(context),
          Gaps.h48,
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              'assets/ice.svg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarmdProjectCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.aboutProjectTitle.tr(),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.aboutProjectDescription.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
          Gaps.h16,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                final inAppReview = InAppReview.instance;

                //TODO it seems the requestReview never works on Android, not sure why
                // see https://github.com/britannio/in_app_review/issues/12
                if (Platform.isIOS && await inAppReview.isAvailable()) {
                  await inAppReview.requestReview();
                } else {
                  await inAppReview.openStoreListing();
                }
              },
              child: Text(
                LocaleKeys.aboutRateIt.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.bold, color: warmdDarkBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourcesCard(BuildContext context) {
    return BlueCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.aboutSourcesTitle.tr(),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: warmdDarkBlue,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Gaps.h16,
          MarkupText(
            LocaleKeys.aboutSourcesDescription.tr(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
