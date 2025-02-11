import '../core/services/api_service.dart';
import '../core/services/storage_service.dart';
import '../models/user_model.dart';
import 'base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {
  final ApiService _apiService;
  final StorageService _storageService;
  UserModel? _user;

  AuthViewModel(this._apiService, this._storageService);

  UserModel? get user => _user;

  Future<bool> login(String email, String password) async {
    setLoading(true);
    clearError();

    try {
      final response = await _apiService.login(email, password);
      _user = UserModel.fromJson(response);
      await _storageService.saveAuthData(_user!.token, _user!.id);
      setLoading(false);
      return true;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      return false;
    }
  }
}
