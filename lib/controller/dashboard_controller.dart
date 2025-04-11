import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:priceprediction/view/home/property_detail_screen.dart';
import 'package:priceprediction/view/onboarding/onboarding_screen.dart';

class DashboardController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxnString? _selectedCategory = RxnString(null);
  RxInt _selectedIndex = 0.obs;

  final List<Map<String, String>> _propertyList = [
    {'name': 'Opulent Villa 1', 'category': 'Luxury', 'image': 'assets/images/luxuray1.webp'},
    {'name': 'Elegant Mansion 1', 'category': 'Luxury', 'image': 'assets/images/luxuray2.jpg'},
    {'name': 'Stunning Estate 1', 'category': 'Luxury', 'image': 'assets/images/luxuray3.jpg'},
    {'name': 'Exclusive Residence 1', 'category': 'Luxury', 'image': 'assets/images/luxuray4.jpg'},
    {'name': 'Modern Apartment 1', 'category': 'Flat', 'image': 'assets/images/flat1.avif'},
    {'name': 'Cozy Studio 1', 'category': 'Flat', 'image': 'assets/images/flat2.avif'},
    {'name': 'Spacious Flat 1', 'category': 'Flat', 'image': 'assets/images/flat3.jpg'},
    {'name': 'Urban Loft 1', 'category': 'Flat', 'image': 'assets/images/flat4.jpg'},
    {'name': 'Luxury Penthouse 1', 'category': 'Penthouse', 'image': 'assets/images/penthouse1.jpg'},
    {'name': 'Skyline Penthouse 1', 'category': 'Penthouse', 'image': 'assets/images/penthouse2.jpg'},
    {'name': 'Panoramic Penthouse 1', 'category': 'Penthouse', 'image': 'assets/images/penthouse3.jpg'},
    {'name': 'Exclusive Penthouse 1', 'category': 'Penthouse', 'image': 'assets/images/penthouse4.jpg'},
    {'name': 'Charming Cottage 1', 'category': 'Cottage', 'image': 'assets/images/cottage1.jpg'},
    {'name': 'Secluded Cottage 1', 'category': 'Cottage', 'image': 'assets/images/cottage2.jpg'},
    {'name': 'Rustic Cottage 1', 'category': 'Cottage', 'image': 'assets/images/cottage3.avif'},
    {'name': 'Quaint Cottage 1', 'category': 'Cottage', 'image': 'assets/images/cottage4.jpg'},
    {'name': 'Opulent Villa 2', 'category': 'Luxury', 'image': 'assets/images/luxuray1.webp'},
    {'name': 'Elegant Mansion 2', 'category': 'Luxury', 'image': 'assets/images/luxuray2.jpg'},
    {'name': 'Modern Apartment 2', 'category': 'Flat', 'image': 'assets/images/flat1.avif'},
    {'name': 'Luxury Penthouse 2', 'category': 'Penthouse', 'image': 'assets/images/penthouse1.jpg'},
    {'name': 'Charming Cottage 2', 'category': 'Cottage', 'image': 'assets/images/cottage1.jpg'},
  ];

  final List<String> _availableCategories = ['Luxury', 'Flat', 'Cottage', 'Penthouse'];

  String? get selectedCategory => _selectedCategory?.value;
  int get selectedIndex => _selectedIndex.value;
  List<Map<String, String>> get propertyList => _propertyList;
  List<String> get availableCategories => _availableCategories;

  List<Map<String, String>> get filteredProperties {
    if (_selectedCategory?.value == null || _selectedCategory?.value == "All") {
      return _propertyList;
    } else {
      return _propertyList.where((property) => property['category'] == _selectedCategory?.value).toList();
    }
  }

  void selectCategory(String category) {
    _selectedCategory?.value = category == "View All" ? "All" : category;
  }

  void changeTabIndex(int index) {
    _selectedIndex.value = index;
  }

  void openPropertyDetail(Map<String, String> property) {
    Get.to(() => PropertyDetailScreen(property: property));
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.to(OnBoardingScreen());
  }
}