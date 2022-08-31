/// Generated file. Do not edit.
///
/// Locales: 2
/// Strings: 80 (40 per locale)
///
/// Built on 2022-08-30 at 02:37 UTC


// coverage:ignore-file
// ignore_for_file: type=lint


import 'package:flutter/widgets.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<_StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	id(languageCode: 'id', build: _StringsId.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<_StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(
		initLocale: LocaleSettings.instance.currentLocale,
		initTranslations: LocaleSettings.instance.currentTranslations,
	);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(
		locales: AppLocale.values,
		baseLocale: _baseLocale,
		utils: AppLocaleUtils.instance,
	);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale) => instance.setLocale(locale);
	static AppLocale setLocaleRaw(String rawLocale) => instance.setLocaleRaw(rawLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver;

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	final PluralResolver? _cardinalResolver; // ignore: unused_field
	final PluralResolver? _ordinalResolver; // ignore: unused_field

	late final _StringsEn _root = this; // ignore: unused_field

	// Translations
	String get poweredBy => 'Powered by';
	TextSpan animationBy({required InlineSpan name}) => TextSpan(children: [
		const TextSpan(text: 'Animation by '),
		name,
	]);
	String get noInternet => 'No internet connection!';
	late final _StringsLabelEn label = _StringsLabelEn._(_root);
	late final _StringsOnBoardingEn onBoarding = _StringsOnBoardingEn._(_root);
	late final _StringsSemanticsEn semantics = _StringsSemanticsEn._(_root);
	late final _StringsDialogsEn dialogs = _StringsDialogsEn._(_root);
}

// Path: label
class _StringsLabelEn {
	_StringsLabelEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsLabelBtnEn btn = _StringsLabelBtnEn._(_root);
	late final _StringsLabelPageEn page = _StringsLabelPageEn._(_root);
	late final _StringsLabelMenuEn menu = _StringsLabelMenuEn._(_root);
}

// Path: onBoarding
class _StringsOnBoardingEn {
	_StringsOnBoardingEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsOnBoardingTitleEn title = _StringsOnBoardingTitleEn._(_root);
	late final _StringsOnBoardingCaptionEn caption = _StringsOnBoardingCaptionEn._(_root);
}

// Path: semantics
class _StringsSemanticsEn {
	_StringsSemanticsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get appName => 'Integrated Statisticak Service Mobile';
	String get pstLogo => 'Integrated Statistical Service Logo';
	String get lottieFilesLogo => 'Lottie Files Logo';
	String get rbBpsLogo => 'Central Bureau of Statistics Bureaucratic Reform Logo';
	String get bpsLogo => 'Logo of the Central Bureau of Statistics of Pinrang Regency';
	String get bpsCoreValueLogo => 'Basic Values Logo of the Central Bureau of Statistics. P I A (PIA), an acronym for Professional or Professional, Integritas or Integrity, and Amanah or Trustworthy.';
	String get noInternet => 'No internet connection!. Please check your connection, wifi, or data connection!';
	late final _StringsSemanticsBtnEn btn = _StringsSemanticsBtnEn._(_root);
	late final _StringsSemanticsDialogsEn dialogs = _StringsSemanticsDialogsEn._(_root);
}

// Path: dialogs
class _StringsDialogsEn {
	_StringsDialogsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsDialogsTitleEn title = _StringsDialogsTitleEn._(_root);
	late final _StringsDialogsMessageEn message = _StringsDialogsMessageEn._(_root);
}

// Path: label.btn
class _StringsLabelBtnEn {
	_StringsLabelBtnEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get skip => 'Skip';
	String get see_more => 'See More';
}

// Path: label.page
class _StringsLabelPageEn {
	_StringsLabelPageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String infographic({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Infographic',
		other: 'Infographics',
	);
}

// Path: label.menu
class _StringsLabelMenuEn {
	_StringsLabelMenuEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String publication({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Publication',
		other: 'Publications',
	);
	String get data_table => 'Data Table';
	String get statistics => 'Statistics';
	String get news => 'News';
	String get live_chat => 'Live Chat';
	String get book_appointment => 'Book\nAppointment';
	String get official_statistics_news => 'Official\nStatistics\nNews';
	String get molasapp => 'Molasapp';
}

// Path: onBoarding.title
class _StringsOnBoardingTitleEn {
	_StringsOnBoardingTitleEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get publication => 'Publication';
	String get statistics => 'Statistics';
	String get activeHour => '24/7';
}

// Path: onBoarding.caption
class _StringsOnBoardingCaptionEn {
	_StringsOnBoardingCaptionEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get publication => 'Access various publications, releases, data, and various interesting insights from BPS Pinrang Regency';
	String get statistics => 'Access to statistical data, analysis, and strategic indicators for Pinrang Regency';
	String get activeHour => 'Access anytime, anywhere, PST Mobile is ready to serve you 7 x 24 hours.';
}

// Path: semantics.btn
class _StringsSemanticsBtnEn {
	_StringsSemanticsBtnEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get notification => 'Notification Button. Press here to see list of notifications you\'ve received.';
	String get search => 'Search Button. Press here to search for content of P S T Mobile.';
	String get next => 'Next Button. Press here to go to the next item.';
	String get prev => 'Previous Button. Press here to go to the previous item.';
	String get skip => 'Skip Button. Press here to skip to the next page.';
	String get done => 'Done Button. Press here to finish the slideshow.';
}

// Path: semantics.dialogs
class _StringsSemanticsDialogsEn {
	_StringsSemanticsDialogsEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsSemanticsDialogsTitleEn title = _StringsSemanticsDialogsTitleEn._(_root);
	late final _StringsSemanticsDialogsMessageEn message = _StringsSemanticsDialogsMessageEn._(_root);
}

// Path: dialogs.title
class _StringsDialogsTitleEn {
	_StringsDialogsTitleEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get failure => 'Failure!';
	String get success => 'Success!';
}

// Path: dialogs.message
class _StringsDialogsMessageEn {
	_StringsDialogsMessageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsDialogsMessageFailureEn failure = _StringsDialogsMessageFailureEn._(_root);
}

// Path: semantics.dialogs.title
class _StringsSemanticsDialogsTitleEn {
	_StringsSemanticsDialogsTitleEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsSemanticsDialogsTitleFailureEn failure = _StringsSemanticsDialogsTitleFailureEn._(_root);
}

// Path: semantics.dialogs.message
class _StringsSemanticsDialogsMessageEn {
	_StringsSemanticsDialogsMessageEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	late final _StringsSemanticsDialogsMessageFailureEn failure = _StringsSemanticsDialogsMessageFailureEn._(_root);
}

// Path: dialogs.message.failure
class _StringsDialogsMessageFailureEn {
	_StringsDialogsMessageFailureEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get permission => 'There is some permissions your not granted!';
}

// Path: semantics.dialogs.title.failure
class _StringsSemanticsDialogsTitleFailureEn {
	_StringsSemanticsDialogsTitleFailureEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get header => 'Failure!';
}

// Path: semantics.dialogs.message.failure
class _StringsSemanticsDialogsMessageFailureEn {
	_StringsSemanticsDialogsMessageFailureEn._(this._root);

	final _StringsEn _root; // ignore: unused_field

	// Translations
	String get permission => 'There is some permissions your not granted! Please give apps required permission to make it worked properly!';
}

// Path: <root>
class _StringsId implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsId.build({PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: _cardinalResolver = cardinalResolver,
		  _ordinalResolver = ordinalResolver;

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override final PluralResolver? _cardinalResolver; // ignore: unused_field
	@override final PluralResolver? _ordinalResolver; // ignore: unused_field

	@override late final _StringsId _root = this; // ignore: unused_field

	// Translations
	@override String get poweredBy => 'Dipersembahkan oleh';
	@override TextSpan animationBy({required InlineSpan name}) => TextSpan(children: [
		const TextSpan(text: 'Animasi oleh '),
		name,
	]);
	@override String get noInternet => 'Tidak ada koneksi internet!';
	@override late final _StringsLabelId label = _StringsLabelId._(_root);
	@override late final _StringsOnBoardingId onBoarding = _StringsOnBoardingId._(_root);
	@override late final _StringsSemanticsId semantics = _StringsSemanticsId._(_root);
	@override late final _StringsDialogsId dialogs = _StringsDialogsId._(_root);
}

// Path: label
class _StringsLabelId implements _StringsLabelEn {
	_StringsLabelId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsLabelBtnId btn = _StringsLabelBtnId._(_root);
	@override late final _StringsLabelPageId page = _StringsLabelPageId._(_root);
	@override late final _StringsLabelMenuId menu = _StringsLabelMenuId._(_root);
}

// Path: onBoarding
class _StringsOnBoardingId implements _StringsOnBoardingEn {
	_StringsOnBoardingId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsOnBoardingTitleId title = _StringsOnBoardingTitleId._(_root);
	@override late final _StringsOnBoardingCaptionId caption = _StringsOnBoardingCaptionId._(_root);
}

// Path: semantics
class _StringsSemanticsId implements _StringsSemanticsEn {
	_StringsSemanticsId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get appName => 'Pelayanan Statistik Terpadu P S T Mobile';
	@override String get pstLogo => 'Logo Pelayanan Statistik Terpadu';
	@override String get lottieFilesLogo => 'Logo Lottie Files';
	@override String get rbBpsLogo => 'Logo Reformasi Birokrasi Badan Pusat Statistik';
	@override String get bpsLogo => 'Logo Badan Pusat Statistik (BPS) Kabupaten Pinrang';
	@override String get bpsCoreValueLogo => 'Logo nilai dasar/core values Badan Pusat Statistik. P I A (PIA), akronim dari Profesional, Integritas, dan Amanah.';
	@override String get noInternet => 'Tidak ada koneksi internet!. Periksa koneksi anda, wifi, atau koneksi data anda!';
	@override late final _StringsSemanticsBtnId btn = _StringsSemanticsBtnId._(_root);
	@override late final _StringsSemanticsDialogsId dialogs = _StringsSemanticsDialogsId._(_root);
}

// Path: dialogs
class _StringsDialogsId implements _StringsDialogsEn {
	_StringsDialogsId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsDialogsTitleId title = _StringsDialogsTitleId._(_root);
	@override late final _StringsDialogsMessageId message = _StringsDialogsMessageId._(_root);
}

// Path: label.btn
class _StringsLabelBtnId implements _StringsLabelBtnEn {
	_StringsLabelBtnId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Lewati';
	@override String get see_more => 'Lihat Semua';
}

// Path: label.page
class _StringsLabelPageId implements _StringsLabelPageEn {
	_StringsLabelPageId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String infographic({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('id'))(count,
		one: 'Infografis',
		other: 'Infografis',
	);
}

// Path: label.menu
class _StringsLabelMenuId implements _StringsLabelMenuEn {
	_StringsLabelMenuId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String publication({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('id'))(count,
		one: 'Publikasi',
		other: 'Publikasi',
	);
	@override String get data_table => 'Data Tabel';
	@override String get statistics => 'Statistik';
	@override String get news => 'Berita';
	@override String get live_chat => 'Konsultasi\nLangsung';
	@override String get book_appointment => 'Booking\nKunjungan';
	@override String get official_statistics_news => 'Berita Resmi\nStatistik';
	@override String get molasapp => 'Molasapp';
}

// Path: onBoarding.title
class _StringsOnBoardingTitleId implements _StringsOnBoardingTitleEn {
	_StringsOnBoardingTitleId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get publication => 'Publikasi';
	@override String get statistics => 'Statistik';
	@override String get activeHour => '24/7';
}

// Path: onBoarding.caption
class _StringsOnBoardingCaptionId implements _StringsOnBoardingCaptionEn {
	_StringsOnBoardingCaptionId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get publication => 'Akses berbagai publikasi, rilis, data, dan berbagai insight menarik dari BPS Kabupaten Pinrang';
	@override String get statistics => 'Akses data-data statistik, analisis, dan indikator strategis Kabupaten Pinrang';
	@override String get activeHour => 'Akses kapan saja, dimana saja, PST Mobile siap melayani anda 7 x 24 jam.';
}

// Path: semantics.btn
class _StringsSemanticsBtnId implements _StringsSemanticsBtnEn {
	_StringsSemanticsBtnId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get notification => 'Tombol Notifikasi. Tekan untuk melihat daftar notifikasi atau pemberitahuan.';
	@override String get search => 'Tombol Pencarian. Tekan disini untuk mencari konten P S T Mobile.';
	@override String get next => 'Tombol Selanjutnya. Tekan disini untuk melihat konten selanjutnya.';
	@override String get prev => 'Tombol Sebelumnya. Tekan disini untuk melihat konten sebelumnya.';
	@override String get skip => 'Tombol Lewati. Tekan disini untuk langsung ke halaman terakhir atau halaman selanjutnya.';
	@override String get done => 'Tombol Selesai. Tekan disini untuk mengakhiri petunjuk atau tayangan slide.';
}

// Path: semantics.dialogs
class _StringsSemanticsDialogsId implements _StringsSemanticsDialogsEn {
	_StringsSemanticsDialogsId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsSemanticsDialogsTitleId title = _StringsSemanticsDialogsTitleId._(_root);
	@override late final _StringsSemanticsDialogsMessageId message = _StringsSemanticsDialogsMessageId._(_root);
}

// Path: dialogs.title
class _StringsDialogsTitleId implements _StringsDialogsTitleEn {
	_StringsDialogsTitleId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get failure => 'Kesalahan!';
	@override String get success => 'Berhasil!';
}

// Path: dialogs.message
class _StringsDialogsMessageId implements _StringsDialogsMessageEn {
	_StringsDialogsMessageId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsDialogsMessageFailureId failure = _StringsDialogsMessageFailureId._(_root);
}

// Path: semantics.dialogs.title
class _StringsSemanticsDialogsTitleId implements _StringsSemanticsDialogsTitleEn {
	_StringsSemanticsDialogsTitleId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsSemanticsDialogsTitleFailureId failure = _StringsSemanticsDialogsTitleFailureId._(_root);
}

// Path: semantics.dialogs.message
class _StringsSemanticsDialogsMessageId implements _StringsSemanticsDialogsMessageEn {
	_StringsSemanticsDialogsMessageId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override late final _StringsSemanticsDialogsMessageFailureId failure = _StringsSemanticsDialogsMessageFailureId._(_root);
}

// Path: dialogs.message.failure
class _StringsDialogsMessageFailureId implements _StringsDialogsMessageFailureEn {
	_StringsDialogsMessageFailureId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get permission => 'Masih ada izin yang belum anda izinkan!';
}

// Path: semantics.dialogs.title.failure
class _StringsSemanticsDialogsTitleFailureId implements _StringsSemanticsDialogsTitleFailureEn {
	_StringsSemanticsDialogsTitleFailureId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get header => 'Kesalahan!';
}

// Path: semantics.dialogs.message.failure
class _StringsSemanticsDialogsMessageFailureId implements _StringsSemanticsDialogsMessageFailureEn {
	_StringsSemanticsDialogsMessageFailureId._(this._root);

	@override final _StringsId _root; // ignore: unused_field

	// Translations
	@override String get permission => 'Masih ada izin yang belum anda izinkan! Mohon izinkan izin yang diperlukan agar aplikasi dapat berjalan sebagaimana mestinya!';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'poweredBy': 'Powered by',
			'animationBy': ({required InlineSpan name}) => TextSpan(children: [
				const TextSpan(text: 'Animation by '),
				name,
			]),
			'noInternet': 'No internet connection!',
			'label.btn.skip': 'Skip',
			'label.btn.see_more': 'See More',
			'label.page.infographic': ({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
				one: 'Infographic',
				other: 'Infographics',
			),
			'label.menu.publication': ({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
				one: 'Publication',
				other: 'Publications',
			),
			'label.menu.data_table': 'Data Table',
			'label.menu.statistics': 'Statistics',
			'label.menu.news': 'News',
			'label.menu.live_chat': 'Live Chat',
			'label.menu.book_appointment': 'Book\nAppointment',
			'label.menu.official_statistics_news': 'Official\nStatistics\nNews',
			'label.menu.molasapp': 'Molasapp',
			'onBoarding.title.publication': 'Publication',
			'onBoarding.title.statistics': 'Statistics',
			'onBoarding.title.activeHour': '24/7',
			'onBoarding.caption.publication': 'Access various publications, releases, data, and various interesting insights from BPS Pinrang Regency',
			'onBoarding.caption.statistics': 'Access to statistical data, analysis, and strategic indicators for Pinrang Regency',
			'onBoarding.caption.activeHour': 'Access anytime, anywhere, PST Mobile is ready to serve you 7 x 24 hours.',
			'semantics.appName': 'Integrated Statisticak Service Mobile',
			'semantics.pstLogo': 'Integrated Statistical Service Logo',
			'semantics.lottieFilesLogo': 'Lottie Files Logo',
			'semantics.rbBpsLogo': 'Central Bureau of Statistics Bureaucratic Reform Logo',
			'semantics.bpsLogo': 'Logo of the Central Bureau of Statistics of Pinrang Regency',
			'semantics.bpsCoreValueLogo': 'Basic Values Logo of the Central Bureau of Statistics. P I A (PIA), an acronym for Professional or Professional, Integritas or Integrity, and Amanah or Trustworthy.',
			'semantics.noInternet': 'No internet connection!. Please check your connection, wifi, or data connection!',
			'semantics.btn.notification': 'Notification Button. Press here to see list of notifications you\'ve received.',
			'semantics.btn.search': 'Search Button. Press here to search for content of P S T Mobile.',
			'semantics.btn.next': 'Next Button. Press here to go to the next item.',
			'semantics.btn.prev': 'Previous Button. Press here to go to the previous item.',
			'semantics.btn.skip': 'Skip Button. Press here to skip to the next page.',
			'semantics.btn.done': 'Done Button. Press here to finish the slideshow.',
			'semantics.dialogs.title.failure.header': 'Failure!',
			'semantics.dialogs.message.failure.permission': 'There is some permissions your not granted! Please give apps required permission to make it worked properly!',
			'dialogs.title.failure': 'Failure!',
			'dialogs.title.success': 'Success!',
			'dialogs.message.failure.permission': 'There is some permissions your not granted!',
		};
	}
}

extension on _StringsId {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'poweredBy': 'Dipersembahkan oleh',
			'animationBy': ({required InlineSpan name}) => TextSpan(children: [
				const TextSpan(text: 'Animasi oleh '),
				name,
			]),
			'noInternet': 'Tidak ada koneksi internet!',
			'label.btn.skip': 'Lewati',
			'label.btn.see_more': 'Lihat Semua',
			'label.page.infographic': ({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('id'))(count,
				one: 'Infografis',
				other: 'Infografis',
			),
			'label.menu.publication': ({required num count}) => (_root._cardinalResolver ?? PluralResolvers.cardinal('id'))(count,
				one: 'Publikasi',
				other: 'Publikasi',
			),
			'label.menu.data_table': 'Data Tabel',
			'label.menu.statistics': 'Statistik',
			'label.menu.news': 'Berita',
			'label.menu.live_chat': 'Konsultasi\nLangsung',
			'label.menu.book_appointment': 'Booking\nKunjungan',
			'label.menu.official_statistics_news': 'Berita Resmi\nStatistik',
			'label.menu.molasapp': 'Molasapp',
			'onBoarding.title.publication': 'Publikasi',
			'onBoarding.title.statistics': 'Statistik',
			'onBoarding.title.activeHour': '24/7',
			'onBoarding.caption.publication': 'Akses berbagai publikasi, rilis, data, dan berbagai insight menarik dari BPS Kabupaten Pinrang',
			'onBoarding.caption.statistics': 'Akses data-data statistik, analisis, dan indikator strategis Kabupaten Pinrang',
			'onBoarding.caption.activeHour': 'Akses kapan saja, dimana saja, PST Mobile siap melayani anda 7 x 24 jam.',
			'semantics.appName': 'Pelayanan Statistik Terpadu P S T Mobile',
			'semantics.pstLogo': 'Logo Pelayanan Statistik Terpadu',
			'semantics.lottieFilesLogo': 'Logo Lottie Files',
			'semantics.rbBpsLogo': 'Logo Reformasi Birokrasi Badan Pusat Statistik',
			'semantics.bpsLogo': 'Logo Badan Pusat Statistik (BPS) Kabupaten Pinrang',
			'semantics.bpsCoreValueLogo': 'Logo nilai dasar/core values Badan Pusat Statistik. P I A (PIA), akronim dari Profesional, Integritas, dan Amanah.',
			'semantics.noInternet': 'Tidak ada koneksi internet!. Periksa koneksi anda, wifi, atau koneksi data anda!',
			'semantics.btn.notification': 'Tombol Notifikasi. Tekan untuk melihat daftar notifikasi atau pemberitahuan.',
			'semantics.btn.search': 'Tombol Pencarian. Tekan disini untuk mencari konten P S T Mobile.',
			'semantics.btn.next': 'Tombol Selanjutnya. Tekan disini untuk melihat konten selanjutnya.',
			'semantics.btn.prev': 'Tombol Sebelumnya. Tekan disini untuk melihat konten sebelumnya.',
			'semantics.btn.skip': 'Tombol Lewati. Tekan disini untuk langsung ke halaman terakhir atau halaman selanjutnya.',
			'semantics.btn.done': 'Tombol Selesai. Tekan disini untuk mengakhiri petunjuk atau tayangan slide.',
			'semantics.dialogs.title.failure.header': 'Kesalahan!',
			'semantics.dialogs.message.failure.permission': 'Masih ada izin yang belum anda izinkan! Mohon izinkan izin yang diperlukan agar aplikasi dapat berjalan sebagaimana mestinya!',
			'dialogs.title.failure': 'Kesalahan!',
			'dialogs.title.success': 'Berhasil!',
			'dialogs.message.failure.permission': 'Masih ada izin yang belum anda izinkan!',
		};
	}
}
