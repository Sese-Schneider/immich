import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/presentation/widgets/timeline/timeline.widget.dart';
import 'package:immich_mobile/providers/infrastructure/timeline.provider.dart';
import 'package:immich_mobile/providers/user.provider.dart';

@RoutePage()
class DriftFavoritePage extends StatelessWidget {
  const DriftFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        timelineServiceProvider.overrideWith(
          (ref) {
            final user = ref.watch(currentUserProvider);
            if (user == null) {
              throw Exception('User must be logged in to access favorite');
            }

            final timelineService =
                ref.watch(timelineFactoryProvider).favorite(user.id);
            ref.onDispose(timelineService.dispose);
            return timelineService;
          },
        ),
      ],
      child: const Timeline(),
    );
  }
}
