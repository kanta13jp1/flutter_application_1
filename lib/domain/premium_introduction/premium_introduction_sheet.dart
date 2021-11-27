import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/analytics.dart';
import 'package:flutter_application_1/components/atoms/buttons.dart';
import 'package:flutter_application_1/components/atoms/color.dart';
import 'package:flutter_application_1/components/molecules/indicator.dart';
import 'package:flutter_application_1/components/page/hud.dart';
import 'package:flutter_application_1/domain/premium_introduction/components/premium_introduction_footer.dart';
import 'package:flutter_application_1/domain/premium_introduction/components/premium_introduction_header.dart';
import 'package:flutter_application_1/domain/premium_introduction/components/premium_introduction_discount.dart';
import 'package:flutter_application_1/domain/premium_introduction/components/premium_user_thanks.dart';
import 'package:flutter_application_1/domain/premium_introduction/components/purchase_buttons.dart';
import 'package:flutter_application_1/domain/premium_introduction/premium_introduction_store.dart';
import 'package:flutter_application_1/domain/premium_introduction/util/discount_deadline.dart';
import 'package:flutter_application_1/error/universal_error_page.dart';
import 'package:flutter_application_1/util/links.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumIntroductionSheet extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(premiumIntroductionStoreProvider);
    final state = ref.watch(premiumIntroductionStateProvider);
    final offerings = state.offerings;
    final discountEntitlementDeadlineDate =
        state.discountEntitlementDeadlineDate;
    final isOverDiscountDeadline = useProvider(
        isOverDiscountDeadlineProvider(discountEntitlementDeadlineDate));
    if (state.isNotYetLoad) {
      return Indicator();
    }

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return HUD(
          shown: state.isLoading,
          child: UniversalErrorPage(
              error: null,
              reload: () => store.reset(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: PilllColors.white,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: !state.isPremium && !isOverDiscountDeadline
                            ? DecorationImage(
                                image:
                                    AssetImage("images/premium_background.png"),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 40),
                      width: MediaQuery.of(context).size.width,
                    ),
                    SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.only(bottom: 100),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PremiumIntroductionHeader(),
                          if (state.isPremium) ...[
                            SizedBox(height: 32),
                            PremiumUserThanksRow(),
                          ],
                          if (!state.isPremium) ...[
                            if (state.hasDiscountEntitlement)
                              PremiumIntroductionDiscountRow(
                                discountEntitlementDeadlineDate:
                                    discountEntitlementDeadlineDate,
                              ),
                            if (offerings != null) ...[
                              SizedBox(height: 32),
                              PurchaseButtons(
                                offerings: offerings,
                                discountEntitlementDeadlineDate:
                                    discountEntitlementDeadlineDate,
                                hasDiscountEntitlement:
                                    state.hasDiscountEntitlement,
                              ),
                            ],
                          ],
                          SizedBox(height: 24),
                          AlertButton(
                              onPressed: () async {
                                analytics.logEvent(
                                    name: "pressed_premium_functions_on_sheet");
                                await launch(preimumLink);
                              },
                              text: "プレミアム機能を見る"),
                          SizedBox(height: 24),
                          PremiumIntroductionFotter(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

showPremiumIntroductionSheet(BuildContext context) {
  analytics.setCurrentScreen(screenName: "PremiumIntroductionSheet");
  showModalBottomSheet(
    context: context,
    builder: (_) => PremiumIntroductionSheet(),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
