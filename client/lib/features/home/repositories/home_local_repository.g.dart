// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeLocalrepository)
const homeLocalrepositoryProvider = HomeLocalrepositoryProvider._();

final class HomeLocalrepositoryProvider
    extends
        $FunctionalProvider<
          HomeLocalrepository,
          HomeLocalrepository,
          HomeLocalrepository
        >
    with $Provider<HomeLocalrepository> {
  const HomeLocalrepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeLocalrepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeLocalrepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeLocalrepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeLocalrepository create(Ref ref) {
    return homeLocalrepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeLocalrepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeLocalrepository>(value),
    );
  }
}

String _$homeLocalrepositoryHash() =>
    r'eda94ac30d8b7e21376b58c466727ada77bf56bd';
