//Banner List
import 'package:shop/module/model/banner_model.dart';
import 'package:shop/module/model/category_model.dart';

import 'assets_path.dart';

//Bottom Nav Bar
List<Map<String, String>> navBarItems = [
  {
    'label': 'Home',
    'inactive': 'assets/icons/home.svg',
    'active': 'assets/icons/home-fill.svg',
  },
  // {
  //   'label': 'Category',
  //   'inactive': 'assets/icons/cat.svg',
  //   'active': 'assets/icons/cat-fill.svg',
  // },
  {
    'label': 'Store',
    'inactive': 'assets/icons/store.svg',
    'active': 'assets/icons/store-fill.svg',
  },
  {
    'label': 'Cart',
    'inactive': 'assets/icons/cart-icon.svg',
    'active': 'assets/icons/cart-fill.svg',
  },
  {
    'label': 'Account',
    'inactive': 'assets/icons/profile.svg',
    'active': 'assets/icons/profile-fill.svg',
  },
];

List<BannerModel> bannerList = [
  BannerModel(
    title: 'Immersive\nMonitors',
    offerText: '50% Off!',
    imgUrl: banner4,
  ),
  BannerModel(
    title: 'High-Quality \nAudio only for you',
    offerText: '50% Off!',
    imgUrl: banner5,
  ),
  BannerModel(
    title: 'Beautiful Outfit \nand Makeup Set',
    offerText: '50% Off!',
    imgUrl: banner6,
  ),
];

//Feature List
List<BannerModel> featureList = [
  BannerModel(
    title: 'Special\nDiscounts',
    offerText: '\$499.00',
    imgUrl: featuretable,
  ),
  BannerModel(
    title: 'Best Price\n& Quality',
    offerText: '20% Off',
    imgUrl: featureclothe,
  ),
  BannerModel(
    title: 'Branded\nProducts',
    offerText: '5% Off',
    imgUrl: featurefreezer,
  ),
];

List<String> productTabs = [
  "All",
  "Computers",
  "Laptop",
  "TV",
  "Mobiles",
  "Headphones",
  "Battery",
  "Watch",
  "Cameras",
  "Accessories",
];

List<String> detailsCriteria = [
  'tag',
  'stock',
];
List reivewText = [
  {
    'name': 'Jonathond H.',
    'time': '3 weeks ago',
    'comment':
        "100% Authentic Product. Recommend highly the shop Store. Great Product!"
  },
  {
    'name': 'Anderson Coo.',
    'time': '5 weeks ago',
    'comment':
        "100% Authentic Product. Recommend highly the shop Store. Great Product!"
  }
];

List<Category> categoryList = [
  Category(
    title: 'Computer',
    icon: deskctopIcon,
    activeIcon: desktopFillIcon,
  ),
  Category(
    title: 'Laptop',
    icon: laptopIcon,
    activeIcon: laptopFillIcon,
  ),
  Category(
    title: 'TV',
    icon: tvIcon,
    activeIcon: tvFillIcon,
  ),
  Category(
    title: 'Headphone',
    icon: headphoneIcon,
    activeIcon: headphoneFillIcon,
  ),
  Category(
    title: 'Mobile',
    icon: mobileIcon,
    activeIcon: mobileFillIcon,
  ),
  Category(
    title: 'Battery',
    icon: batteryIcon,
    activeIcon: batteryFillIcon,
  ),
  Category(
    title: 'Watch',
    icon: watchIcon,
    activeIcon: watchFillIcon,
  ),
  Category(
    title: 'Sterio',
    icon: stereoIcon,
    activeIcon: stereoFillIcon,
  ),
  Category(
    title: 'Camera',
    icon: cameraIcon,
    activeIcon: cameraFillIcon,
  ),
  Category(
    title: 'Accessories',
    icon: accessoriesIcon,
    activeIcon: accessoriesFillIcon,
  ),
];

List<CategoryModel> categoryItemsList = [
  CategoryModel(title: 'Airpod', image: airpod, price: 79.0),
  CategoryModel(title: 'Game Pad', image: games, price: 45.0),
  CategoryModel(title: 'Camera', image: camera3, price: 99.0),
  CategoryModel(title: 'CCTV', image: cctv, price: 99.0),
  CategoryModel(title: 'Speaker', image: speaker, price: 35.0),
  CategoryModel(title: 'Lens', image: lens, price: 55.0),
  CategoryModel(title: 'Laptops', image: laptop3, price: 650.0),
  CategoryModel(title: 'Headphones', image: headphone2, price: 109.0),
  CategoryModel(title: 'Microphones', image: microphone, price: 99.0),
  CategoryModel(title: 'Smart-Watch', image: watch, price: 85.0),
  CategoryModel(title: 'MacBook', image: macbook, price: 990.0),
  CategoryModel(title: 'Watch', image: watch2, price: 60.0),
  CategoryModel(title: 'LCD', image: lcd, price: 199.0),
  CategoryModel(title: 'Projector', image: projector, price: 89.0),
  CategoryModel(title: 'Keyboard', image: keyboard1, price: 55.0),
  CategoryModel(title: 'Mouse', image: mouse, price: 40.0),
];

List<String> serviceList = [
  "100% Authentic",
  "10 days easy return",
];

const loremDummyText =
    "Grow a Business Online From Scratch Make Money as an Affiliate Marketer Land a High-Paying Job in Digital Marketing. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse.\n\nGrow a Business Online From Scratch Make Money as an Affiliate Marketer Land a High-Paying Job in Digital Marketing.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse.\n\nGrow a Business Online From Scratch Make Money as an Affiliate Marketer Land a High-Paying Job in Digital Marketing.";
