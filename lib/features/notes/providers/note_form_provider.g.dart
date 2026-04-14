// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Провайдер страницы с формой заполнения заметки

@ProviderFor(NoteFormNotifier)
const noteFormProvider = NoteFormNotifierProvider._();

/// Провайдер страницы с формой заполнения заметки
final class NoteFormNotifierProvider
    extends $NotifierProvider<NoteFormNotifier, NoteFormState> {
  /// Провайдер страницы с формой заполнения заметки
  const NoteFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noteFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noteFormNotifierHash();

  @$internal
  @override
  NoteFormNotifier create() => NoteFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NoteFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NoteFormState>(value),
    );
  }
}

String _$noteFormNotifierHash() => r'b91df24958e837950ff2c3b2b757adf83802e6db';

/// Провайдер страницы с формой заполнения заметки

abstract class _$NoteFormNotifier extends $Notifier<NoteFormState> {
  NoteFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NoteFormState, NoteFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NoteFormState, NoteFormState>,
              NoteFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
