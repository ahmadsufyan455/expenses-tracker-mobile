// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTagline => 'Pendamping Finansial Cerdas Anda';

  @override
  String get appSubtitle => 'Catat • Analisis • Hemat';

  @override
  String get welcomeBack => 'Selamat Datang Kembali!';

  @override
  String get loginSubtitle =>
      'Masuk untuk melanjutkan mengelola pengeluaran Anda';

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get registerSubtitle =>
      'Bergabunglah dengan kami untuk mulai mencatat pengeluaran dengan cerdas';

  @override
  String get email => 'Alamat Email';

  @override
  String get emailHint => 'Masukkan email Anda';

  @override
  String get password => 'Kata Sandi';

  @override
  String get passwordHint => 'Masukkan kata sandi Anda';

  @override
  String get createPasswordHint => 'Buat kata sandi yang kuat';

  @override
  String get firstName => 'Nama Depan';

  @override
  String get firstNameHint => 'Masukkan nama depan';

  @override
  String get lastName => 'Nama Belakang';

  @override
  String get lastNameHint => 'Masukkan nama belakang';

  @override
  String get signIn => 'Masuk';

  @override
  String get signUp => 'Daftar';

  @override
  String get createAccountButton => 'Buat Akun';

  @override
  String get dontHaveAccount => 'Belum punya akun? ';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun? ';

  @override
  String get agreeToTerms => 'Saya menyetujui ';

  @override
  String get termsAndConditions => 'Syarat dan Ketentuan';

  @override
  String get and => ' dan ';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get loginSuccessful => 'Berhasil masuk!';

  @override
  String get accountCreatedSuccessfully => 'Akun berhasil dibuat!';

  @override
  String get pleaseAcceptTerms => 'Harap menyetujui syarat dan ketentuan';

  @override
  String get or => 'atau';

  @override
  String get emailRequired => 'Email wajib diisi';

  @override
  String get emailInvalid => 'Harap masukkan alamat email yang valid';

  @override
  String get passwordRequired => 'Kata sandi wajib diisi';

  @override
  String passwordTooShort(int minLength) {
    return 'Kata sandi harus minimal $minLength karakter';
  }

  @override
  String fieldRequired(String fieldName) {
    return '$fieldName wajib diisi';
  }

  @override
  String fieldTooShort(String fieldName, int minLength) {
    return '$fieldName harus minimal $minLength karakter';
  }

  @override
  String nameLettersOnly(String fieldName) {
    return '$fieldName hanya boleh berisi huruf';
  }

  @override
  String numberRequired(String fieldName) {
    return '$fieldName wajib diisi';
  }

  @override
  String numberInvalid(String fieldName) {
    return '$fieldName harus berupa angka yang valid';
  }

  @override
  String numberMustBePositive(String fieldName) {
    return '$fieldName harus lebih besar dari 0';
  }
}
