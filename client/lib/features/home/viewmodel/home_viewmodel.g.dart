// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAllSongs)
const getAllSongsProvider = GetAllSongsProvider._();

final class GetAllSongsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SongModel>>,
          List<SongModel>,
          FutureOr<List<SongModel>>
        >
    with $FutureModifier<List<SongModel>>, $FutureProvider<List<SongModel>> {
  const GetAllSongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllSongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<SongModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SongModel>> create(Ref ref) {
    return getAllSongs(ref);
  }
}

String _$getAllSongsHash() => r'd6bdb875ad128521e8e6447de8749f93355a0ce6';

@ProviderFor(HomeViewModel)
const homeViewModelProvider = HomeViewModelProvider._();

final class HomeViewModelProvider
    extends $NotifierProvider<HomeViewModel, AsyncValue<dynamic>?> {
  const HomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewModelHash();

  @$internal
  @override
  HomeViewModel create() => HomeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<dynamic>?>(value),
    );
  }
}

String _$homeViewModelHash() => r'5e0be73c7d901ed0cdafe64e9ee4ee846da23bbe';

abstract class _$HomeViewModel extends $Notifier<AsyncValue<dynamic>?> {
  AsyncValue<dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<dynamic>?, AsyncValue<dynamic>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<dynamic>?, AsyncValue<dynamic>?>,
              AsyncValue<dynamic>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
