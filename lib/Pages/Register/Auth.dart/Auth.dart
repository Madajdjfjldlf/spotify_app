import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // =========================
  // التسجيل (Sign Up)
  // =========================
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );
  }

  // =========================
  // تحديث الملف الشخصي (إضافة الاسم)
  // =========================
  Future<void> updateUserProfile({required String fullName}) async {
    await _supabase.auth.updateUser(
      UserAttributes(data: {'full_name': fullName}),
    );
  }

  // =========================
  // تسجيل الدخول (Sign In)
  // =========================
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // =========================
  // تسجيل الخروج (Sign Out)
  // =========================
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // =========================
  // جلب المستخدم الحالي
  // =========================
  User? get currentUser => _supabase.auth.currentUser;
}
