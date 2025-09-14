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

  @override
  String get goodMorning => 'Selamat Pagi!';

  @override
  String get goodAfternoon => 'Selamat Siang!';

  @override
  String get goodEvening => 'Selamat Malam!';

  @override
  String get overview => 'Ringkasan';

  @override
  String get totalIncome => 'Total Pemasukan';

  @override
  String get totalExpense => 'Total Pengeluaran';

  @override
  String get recentBudget => 'Anggaran Terbaru';

  @override
  String get recentTransactions => 'Transaksi Terbaru';

  @override
  String get viewAll => 'Lihat Semua';

  @override
  String get monthly => 'Bulanan';

  @override
  String get weekly => 'Mingguan';

  @override
  String get yearly => 'Tahunan';

  @override
  String get used => 'digunakan';

  @override
  String get today => 'Hari ini';

  @override
  String get yesterday => 'Kemarin';

  @override
  String daysAgo(int days) {
    return '$days hari lalu';
  }

  @override
  String get home => 'Beranda';

  @override
  String get transactions => 'Transaksi';

  @override
  String get budget => 'Anggaran';

  @override
  String get profile => 'Profil';

  @override
  String get manageTransactions => 'Kelola pemasukan dan pengeluaran Anda';

  @override
  String get budgetManagement => 'Manajemen Anggaran';

  @override
  String get planSpending => 'Rencanakan dan lacak pengeluaran Anda';

  @override
  String get welcomeUser => 'Selamat Datang Pengguna!';

  @override
  String get manageAccount => 'Kelola akun dan preferensi Anda';

  @override
  String get accountSettings => 'Pengaturan Akun';

  @override
  String get updatePersonalInfo => 'Perbarui informasi pribadi Anda';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get manageNotifications => 'Kelola preferensi notifikasi Anda';

  @override
  String get security => 'Keamanan';

  @override
  String get changePassword => 'Ubah kata sandi dan pengaturan keamanan';

  @override
  String get helpSupport => 'Bantuan & Dukungan';

  @override
  String get getHelp => 'Dapatkan bantuan dan hubungi dukungan';

  @override
  String get logout => 'Keluar';

  @override
  String get logoutConfirmation => 'Apakah Anda yakin ingin keluar?';

  @override
  String get cancel => 'Batal';

  @override
  String get somethingWentWrong => 'Terjadi kesalahan';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get ok => 'OK';

  @override
  String get addTransaction => 'Tambah Transaksi';

  @override
  String get updateTransaction => 'Ubah Transaction';

  @override
  String get expense => 'Pengeluaran';

  @override
  String get income => 'Pemasukan';

  @override
  String get amount => 'Jumlah';

  @override
  String get category => 'Kategori';

  @override
  String get description => 'Deskripsi';

  @override
  String get descriptionOptional => 'Deskripsi (Opsional)';

  @override
  String get saveTransaction => 'Simpan Transaksi';

  @override
  String get pleaseEnterAmount => 'Harap masukkan jumlah';

  @override
  String get pleaseEnterValidAmount => 'Harap masukkan jumlah yang valid';

  @override
  String get pleaseSelectCategory => 'Harap pilih kategori';

  @override
  String get transactionSavedSuccessfully => 'Transaksi berhasil disimpan!';

  @override
  String get transactionUpdatedSuccessfully => 'Transaksi berhasil diperbarui!';

  @override
  String get foodDining => 'Makanan & Restoran';

  @override
  String get transportation => 'Transportasi';

  @override
  String get shopping => 'Belanja';

  @override
  String get entertainment => 'Hiburan';

  @override
  String get billsUtilities => 'Tagihan & Utilitas';

  @override
  String get healthcare => 'Kesehatan';

  @override
  String get education => 'Pendidikan';

  @override
  String get others => 'Lainnya';

  @override
  String get salary => 'Gaji';

  @override
  String get business => 'Bisnis';

  @override
  String get investment => 'Investasi';

  @override
  String get gift => 'Hadiah';

  @override
  String get paymentMethod => 'Metode Pembayaran';

  @override
  String get pleaseSelectPaymentMethod => 'Harap pilih metode pembayaran';

  @override
  String get cash => 'Tunai';

  @override
  String get creditCard => 'Kartu Kredit';

  @override
  String get bankTransfer => 'Transfer Bank';

  @override
  String get digitalWallet => 'Dompet Digital';

  @override
  String get date => 'Tanggal';

  @override
  String get type => 'Tipe';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Hapus';

  @override
  String get transactionDetails => 'Detail Transaksi';

  @override
  String get past => 'Sebelumnya';

  @override
  String get deleteTransaction => 'Hapus Transaksi';

  @override
  String get deleteTransactionConfirmation =>
      'Apakah Anda yakin ingin menghapus transaksi ini? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get transactionDeletedSuccessfully => 'Transaksi berhasil dihapus';

  @override
  String get categories => 'Kategori';

  @override
  String get manageCategories => 'Kelola Kategori';

  @override
  String get manageCategoriesSubtitle => 'Tambah, edit, dan atur kategori Anda';

  @override
  String get addCategory => 'Tambah Kategori';

  @override
  String get editCategory => 'Edit Kategori';

  @override
  String get categoryName => 'Nama Kategori';

  @override
  String get chooseIcon => 'Pilih Ikon';

  @override
  String get chooseColor => 'Pilih Warna';

  @override
  String get addNewCategory => 'Tambah Kategori Baru';

  @override
  String get updateCategory => 'Perbarui Kategori';

  @override
  String get categoryAddedSuccessfully => 'Kategori berhasil ditambahkan!';

  @override
  String get categoryUpdatedSuccessfully => 'Kategori berhasil diperbarui!';

  @override
  String get categoryDeletedSuccessfully => 'Kategori berhasil dihapus!';

  @override
  String get deleteCategory => 'Hapus Kategori';

  @override
  String get deleteCategoryConfirmation =>
      'Apakah Anda yakin ingin menghapus kategori ini?';

  @override
  String get searchCategories => 'Cari kategori...';

  @override
  String get noCategoriesYet => 'Belum ada kategori';

  @override
  String get noCategoriesFound => 'Kategori tidak ditemukan';

  @override
  String get addFirstCategory => 'Tambah kategori pertama Anda untuk memulai';

  @override
  String get tryDifferentSearch => 'Coba istilah pencarian yang berbeda';

  @override
  String usedInTransactions(int count) {
    return 'Digunakan dalam $count transaksi';
  }

  @override
  String get categoryNameRequired => 'Harap masukkan nama kategori';

  @override
  String get categoryNameTooShort => 'Nama kategori harus minimal 2 karakter';

  @override
  String get addNewCategoryTooltip => 'Tambah kategori baru';
}
