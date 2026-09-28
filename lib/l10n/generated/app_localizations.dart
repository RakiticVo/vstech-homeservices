import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'HomeService'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In vi, this message translates to:
  /// **'Nhà tốt hơn mỗi ngày'**
  String get appTagline;

  /// No description provided for @skip.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ qua'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp theo'**
  String get next;

  /// No description provided for @startNow.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu ngay'**
  String get startNow;

  /// No description provided for @continueText.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get continueText;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy bỏ'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirm;

  /// No description provided for @back.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại'**
  String get back;

  /// No description provided for @retry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get retry;

  /// No description provided for @done.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất'**
  String get done;

  /// No description provided for @close.
  ///
  /// In vi, this message translates to:
  /// **'Đóng'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa'**
  String get edit;

  /// No description provided for @langVi.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get langVi;

  /// No description provided for @langEn.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get langEn;

  /// No description provided for @changeLanguage.
  ///
  /// In vi, this message translates to:
  /// **'Đổi ngôn ngữ'**
  String get changeLanguage;

  /// No description provided for @splashLoading.
  ///
  /// In vi, this message translates to:
  /// **'Đang khởi động...'**
  String get splashLoading;

  /// No description provided for @ob1Title.
  ///
  /// In vi, this message translates to:
  /// **'Nhà sạch tinh tươm\nSống khỏe mỗi ngày'**
  String get ob1Title;

  /// No description provided for @ob1Desc.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ vệ sinh, dọn dẹp chuyên nghiệp giúp không gian sống luôn thoáng đãng, trong lành.'**
  String get ob1Desc;

  /// No description provided for @ob2Title.
  ///
  /// In vi, this message translates to:
  /// **'Thợ chuẩn tay nghề\nAn tâm tuyệt đối'**
  String get ob2Title;

  /// No description provided for @ob2Desc.
  ///
  /// In vi, this message translates to:
  /// **'Đội ngũ kỹ thuật viên được đào tạo bài bản, có chứng chỉ hành nghề và lý lịch rõ ràng.'**
  String get ob2Desc;

  /// No description provided for @ob3Title.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lịch 3 bước\nGiá cả minh bạch'**
  String get ob3Title;

  /// No description provided for @ob3Desc.
  ///
  /// In vi, this message translates to:
  /// **'Chọn dịch vụ, chọn giờ và xác nhận. Báo giá trọn gói không phát sinh bất ngờ.'**
  String get ob3Desc;

  /// No description provided for @ob4Title.
  ///
  /// In vi, this message translates to:
  /// **'Trợ lý AI thông minh\nTư vấn tận tâm'**
  String get ob4Title;

  /// No description provided for @ob4Desc.
  ///
  /// In vi, this message translates to:
  /// **'AI chẩn đoán sự cố nhanh chóng, gợi ý giải pháp sửa chữa và đặt hẹn chính xác.'**
  String get ob4Desc;

  /// No description provided for @introTitle.
  ///
  /// In vi, this message translates to:
  /// **'Việc nhà nhẹ hơn\nCuộc sống tươi hơn'**
  String get introTitle;

  /// No description provided for @introSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Hệ sinh thái dịch vụ gia đình tận tâm, tin cậy hàng đầu Việt Nam'**
  String get introSubtitle;

  /// No description provided for @value1Title.
  ///
  /// In vi, this message translates to:
  /// **'Minh bạch 100%'**
  String get value1Title;

  /// No description provided for @value1Desc.
  ///
  /// In vi, this message translates to:
  /// **'Báo giá rõ ràng từng hạng mục trước khi thợ đến, cam kết không vẽ giá.'**
  String get value1Desc;

  /// No description provided for @value2Title.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành tự động'**
  String get value2Title;

  /// No description provided for @value2Desc.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành 0đ sau dịch vụ, cam kết đồng hành dài lâu cùng gia đình bạn.'**
  String get value2Desc;

  /// No description provided for @value3Title.
  ///
  /// In vi, this message translates to:
  /// **'Phục vụ siêu tốc'**
  String get value3Title;

  /// No description provided for @value3Desc.
  ///
  /// In vi, this message translates to:
  /// **'Thợ có mặt đúng giờ hẹn, phục vụ nhanh chóng và chu đáo.'**
  String get value3Desc;

  /// No description provided for @introCta.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu ngay'**
  String get introCta;

  /// No description provided for @roleGatewayTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng bạn đến với\nHomeService'**
  String get roleGatewayTitle;

  /// No description provided for @roleGatewaySubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn vai trò để tiếp tục trải nghiệm'**
  String get roleGatewaySubtitle;

  /// No description provided for @roleCustomerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tôi là Khách hàng'**
  String get roleCustomerTitle;

  /// No description provided for @roleCustomerDesc.
  ///
  /// In vi, this message translates to:
  /// **'Đặt dịch vụ sửa chữa, bảo trì và chăm sóc ngôi nhà thân yêu của bạn.'**
  String get roleCustomerDesc;

  /// No description provided for @roleCustomerAction.
  ///
  /// In vi, this message translates to:
  /// **'Tìm dịch vụ ngay'**
  String get roleCustomerAction;

  /// No description provided for @roleWorkerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tôi là Thợ đối tác'**
  String get roleWorkerTitle;

  /// No description provided for @roleWorkerDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nhận việc nhanh chóng, gia tăng thu nhập và chủ động thời gian làm việc.'**
  String get roleWorkerDesc;

  /// No description provided for @roleWorkerAction.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu nhận việc'**
  String get roleWorkerAction;

  /// No description provided for @switchRoleNotice.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có thể dễ dàng chuyển đổi vai trò bất cứ lúc nào trong ứng dụng.'**
  String get switchRoleNotice;

  /// No description provided for @authRoleCustomer.
  ///
  /// In vi, this message translates to:
  /// **'Khách hàng'**
  String get authRoleCustomer;

  /// No description provided for @authRoleWorker.
  ///
  /// In vi, this message translates to:
  /// **'Thợ đối tác'**
  String get authRoleWorker;

  /// No description provided for @authSwitchRole.
  ///
  /// In vi, this message translates to:
  /// **'Đổi vai trò'**
  String get authSwitchRole;

  /// No description provided for @loginTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get loginTitle;

  /// No description provided for @loginWelcome.
  ///
  /// In vi, this message translates to:
  /// **'Chào mừng bạn quay lại!'**
  String get loginWelcome;

  /// No description provided for @loginPhoneOrEmailLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại hoặc Email'**
  String get loginPhoneOrEmailLabel;

  /// No description provided for @loginPhoneOrEmailHint.
  ///
  /// In vi, this message translates to:
  /// **'0901 234 567 hoặc name@email.com'**
  String get loginPhoneOrEmailHint;

  /// No description provided for @loginPhoneWorkerLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại đăng ký'**
  String get loginPhoneWorkerLabel;

  /// No description provided for @loginPhoneWorkerHint.
  ///
  /// In vi, this message translates to:
  /// **'0912 345 678'**
  String get loginPhoneWorkerHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu của bạn'**
  String get loginPasswordHint;

  /// No description provided for @loginForgotPassword.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get loginForgotPassword;

  /// No description provided for @loginCta.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get loginCta;

  /// No description provided for @loginOrSocialDivider.
  ///
  /// In vi, this message translates to:
  /// **'Hoặc tiếp tục với'**
  String get loginOrSocialDivider;

  /// No description provided for @loginGoogle.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục với Google'**
  String get loginGoogle;

  /// No description provided for @loginApple.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục với Apple'**
  String get loginApple;

  /// No description provided for @loginFacebook.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục với Facebook'**
  String get loginFacebook;

  /// No description provided for @loginNoAccount.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản?'**
  String get loginNoAccount;

  /// No description provided for @loginRegisterNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký ngay'**
  String get loginRegisterNow;

  /// No description provided for @registerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản mới'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký nhanh chóng để trải nghiệm dịch vụ'**
  String get registerSubtitle;

  /// No description provided for @registerFullNameLabel.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get registerFullNameLabel;

  /// No description provided for @registerFullNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Văn A'**
  String get registerFullNameHint;

  /// No description provided for @registerPhoneLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get registerPhoneLabel;

  /// No description provided for @registerPhoneHint.
  ///
  /// In vi, this message translates to:
  /// **'0901 234 567'**
  String get registerPhoneHint;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu 6 ký tự'**
  String get registerPasswordHint;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerConfirmPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu'**
  String get registerConfirmPasswordHint;

  /// No description provided for @registerTermsAgreement.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đồng ý với'**
  String get registerTermsAgreement;

  /// No description provided for @registerTermsLink.
  ///
  /// In vi, this message translates to:
  /// **'Điều khoản dịch vụ'**
  String get registerTermsLink;

  /// No description provided for @registerAndText.
  ///
  /// In vi, this message translates to:
  /// **'và'**
  String get registerAndText;

  /// No description provided for @registerPrivacyLink.
  ///
  /// In vi, this message translates to:
  /// **'Chính sách bảo mật'**
  String get registerPrivacyLink;

  /// No description provided for @registerCta.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get registerCta;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản?'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerLoginNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập ngay'**
  String get registerLoginNow;

  /// No description provided for @otpTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực mã OTP'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Mã xác thực gồm 6 chữ số đã được gửi tới số điện thoại'**
  String get otpSubtitle;

  /// No description provided for @otpQuickFillLabel.
  ///
  /// In vi, this message translates to:
  /// **'Từ Tin nhắn: 123456'**
  String get otpQuickFillLabel;

  /// No description provided for @otpResendCountdown.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã sau {seconds}s'**
  String otpResendCountdown(int seconds);

  /// No description provided for @otpResendAction.
  ///
  /// In vi, this message translates to:
  /// **'Gửi lại mã OTP'**
  String get otpResendAction;

  /// No description provided for @otpCta.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực ngay'**
  String get otpCta;

  /// No description provided for @otpInvalidCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã OTP không chính xác. Vui lòng thử lại!'**
  String get otpInvalidCode;

  /// No description provided for @otpVerifySuccess.
  ///
  /// In vi, this message translates to:
  /// **'Xác thực thành công!'**
  String get otpVerifySuccess;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khôi phục mật khẩu'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số điện thoại đã đăng ký để nhận mã OTP thiết lập lại mật khẩu của bạn'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordPhoneLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get forgotPasswordPhoneLabel;

  /// No description provided for @forgotPasswordPhoneHint.
  ///
  /// In vi, this message translates to:
  /// **'0901 234 567'**
  String get forgotPasswordPhoneHint;

  /// No description provided for @forgotPasswordCta.
  ///
  /// In vi, this message translates to:
  /// **'Gửi mã xác thực'**
  String get forgotPasswordCta;

  /// No description provided for @forgotPasswordBackToLogin.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại Đăng nhập'**
  String get forgotPasswordBackToLogin;

  /// No description provided for @errorFieldRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập trường này'**
  String get errorFieldRequired;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không hợp lệ'**
  String get errorInvalidPhone;

  /// No description provided for @errorPasswordTooShort.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải có ít nhất 6 ký tự'**
  String get errorPasswordTooShort;

  /// No description provided for @errorPasswordNotMatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu xác nhận không khớp'**
  String get errorPasswordNotMatch;

  /// No description provided for @errorMustAgreeTerms.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng đồng ý với điều khoản dịch vụ'**
  String get errorMustAgreeTerms;

  /// No description provided for @homeGreeting.
  ///
  /// In vi, this message translates to:
  /// **'Chào bạn,'**
  String get homeGreeting;

  /// No description provided for @homeGreetingSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay nhà bạn cần hỗ trợ gì?'**
  String get homeGreetingSubtitle;

  /// No description provided for @homeDefaultAddress.
  ///
  /// In vi, this message translates to:
  /// **'Chung cư Sunrise City, Q.7'**
  String get homeDefaultAddress;

  /// No description provided for @homeSearchPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm dịch vụ: máy lạnh, dọn dẹp...'**
  String get homeSearchPlaceholder;

  /// No description provided for @svcCleanTitle.
  ///
  /// In vi, this message translates to:
  /// **'Dọn dẹp\nvệ sinh'**
  String get svcCleanTitle;

  /// No description provided for @svcPlumbTitle.
  ///
  /// In vi, this message translates to:
  /// **'Sửa điện\nnước'**
  String get svcPlumbTitle;

  /// No description provided for @svcAcTitle.
  ///
  /// In vi, this message translates to:
  /// **'Điện lạnh &\nmáy giặt'**
  String get svcAcTitle;

  /// No description provided for @svcLaundryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giặt ủi &\nrèm cửa'**
  String get svcLaundryTitle;

  /// No description provided for @svcMaidTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giúp việc\ntheo giờ'**
  String get svcMaidTitle;

  /// No description provided for @svcPestTitle.
  ///
  /// In vi, this message translates to:
  /// **'Diệt\ncôn trùng'**
  String get svcPestTitle;

  /// No description provided for @svcInstallTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lắp đặt &\nkhoan mộc'**
  String get svcInstallTitle;

  /// No description provided for @svcApplianceTitle.
  ///
  /// In vi, this message translates to:
  /// **'Sửa đồ\ngia dụng'**
  String get svcApplianceTitle;

  /// No description provided for @homeSectionCategories.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ thiết yếu'**
  String get homeSectionCategories;

  /// No description provided for @homeSectionSeeAll.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả'**
  String get homeSectionSeeAll;

  /// No description provided for @homeSectionOffers.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi đặc quyền'**
  String get homeSectionOffers;

  /// No description provided for @homeSectionDevices.
  ///
  /// In vi, this message translates to:
  /// **'Ngôi nhà & Thiết bị'**
  String get homeSectionDevices;

  /// No description provided for @homeDeviceSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Theo dõi tình trạng & lịch bảo dưỡng'**
  String get homeDeviceSubtitle;

  /// No description provided for @homeViewSchedule.
  ///
  /// In vi, this message translates to:
  /// **'Xem lịch bảo dưỡng'**
  String get homeViewSchedule;

  /// No description provided for @offerTag15.
  ///
  /// In vi, this message translates to:
  /// **'Giảm 15%'**
  String get offerTag15;

  /// No description provided for @offerTagFast.
  ///
  /// In vi, this message translates to:
  /// **'Có mặt 20p'**
  String get offerTagFast;

  /// No description provided for @startingFrom.
  ///
  /// In vi, this message translates to:
  /// **'Từ {price}'**
  String startingFrom(String price);

  /// No description provided for @cleanServiceDesc.
  ///
  /// In vi, this message translates to:
  /// **'Vệ sinh toàn diện căn hộ, phòng khách, phòng ngủ và bếp sạch bong.'**
  String get cleanServiceDesc;

  /// No description provided for @acServiceDesc.
  ///
  /// In vi, this message translates to:
  /// **'Bảo dưỡng xịt rửa máy lạnh, nạp gas và kiểm tra an toàn điện.'**
  String get acServiceDesc;

  /// No description provided for @plumbServiceDesc.
  ///
  /// In vi, this message translates to:
  /// **'Xử lý rò rỉ nước, thông tắc chậu rửa và thay phụ kiện chính hãng.'**
  String get plumbServiceDesc;

  /// No description provided for @deviceDaikinAc.
  ///
  /// In vi, this message translates to:
  /// **'Máy lạnh Daikin Inverter 1.5 HP'**
  String get deviceDaikinAc;

  /// No description provided for @deviceSamsungFridge.
  ///
  /// In vi, this message translates to:
  /// **'Tủ lạnh Samsung Twin Cooling'**
  String get deviceSamsungFridge;

  /// No description provided for @deviceStatusGood.
  ///
  /// In vi, this message translates to:
  /// **'Hoạt động tốt'**
  String get deviceStatusGood;

  /// No description provided for @deviceStatusMaintenance.
  ///
  /// In vi, this message translates to:
  /// **'Cần bảo dưỡng'**
  String get deviceStatusMaintenance;

  /// No description provided for @deviceLastService.
  ///
  /// In vi, this message translates to:
  /// **'Bảo dưỡng lần cuối: {date}'**
  String deviceLastService(String date);

  /// No description provided for @navHome.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get navHome;

  /// No description provided for @navOrders.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng'**
  String get navOrders;

  /// No description provided for @navAi.
  ///
  /// In vi, this message translates to:
  /// **'AI hỗ trợ'**
  String get navAi;

  /// No description provided for @navNotifications.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get navNotifications;

  /// No description provided for @navAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản'**
  String get navAccount;

  /// No description provided for @categoriesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả dịch vụ'**
  String get categoriesTitle;

  /// No description provided for @categoriesFilterAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get categoriesFilterAll;

  /// No description provided for @categoriesFilterClean.
  ///
  /// In vi, this message translates to:
  /// **'Vệ sinh'**
  String get categoriesFilterClean;

  /// No description provided for @categoriesFilterElectric.
  ///
  /// In vi, this message translates to:
  /// **'Điện lạnh'**
  String get categoriesFilterElectric;

  /// No description provided for @categoriesFilterPlumb.
  ///
  /// In vi, this message translates to:
  /// **'Điện nước'**
  String get categoriesFilterPlumb;

  /// No description provided for @categoriesFilterRepair.
  ///
  /// In vi, this message translates to:
  /// **'Sửa chữa'**
  String get categoriesFilterRepair;

  /// No description provided for @serviceDetailBookCta.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lịch ngay'**
  String get serviceDetailBookCta;

  /// No description provided for @serviceIncluded.
  ///
  /// In vi, this message translates to:
  /// **'Gói dịch vụ bao gồm'**
  String get serviceIncluded;

  /// No description provided for @serviceWarrantyNotice.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành 0đ trong 30 ngày'**
  String get serviceWarrantyNotice;

  /// No description provided for @serviceDuration.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian ước tính: 60 - 90 phút'**
  String get serviceDuration;

  /// No description provided for @ratingReviews.
  ///
  /// In vi, this message translates to:
  /// **'{rating} ({count} đánh giá)'**
  String ratingReviews(String rating, int count);

  /// No description provided for @workerGreeting.
  ///
  /// In vi, this message translates to:
  /// **'Chào anh {name},'**
  String workerGreeting(String name);

  /// No description provided for @workerGreetingSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay sẵn sàng nhận việc chứ?'**
  String get workerGreetingSubtitle;

  /// No description provided for @workerOnline.
  ///
  /// In vi, this message translates to:
  /// **'Đang online'**
  String get workerOnline;

  /// No description provided for @workerOffline.
  ///
  /// In vi, this message translates to:
  /// **'Nghỉ ngơi'**
  String get workerOffline;

  /// No description provided for @workerTodayEarnings.
  ///
  /// In vi, this message translates to:
  /// **'Thu nhập hôm nay'**
  String get workerTodayEarnings;

  /// No description provided for @workerCompletedJobs.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hoàn tất'**
  String get workerCompletedJobs;

  /// No description provided for @workerRating.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá sao'**
  String get workerRating;

  /// No description provided for @workerAcceptRate.
  ///
  /// In vi, this message translates to:
  /// **'Tỷ lệ nhận'**
  String get workerAcceptRate;

  /// No description provided for @workerNetEarnings.
  ///
  /// In vi, this message translates to:
  /// **'Thực nhận về ví'**
  String get workerNetEarnings;

  /// No description provided for @workerNewJobRequest.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu việc mới'**
  String get workerNewJobRequest;

  /// No description provided for @workerArriveIn20Min.
  ///
  /// In vi, this message translates to:
  /// **'Đến sau 20 phút'**
  String get workerArriveIn20Min;

  /// No description provided for @workerViewAndAccept.
  ///
  /// In vi, this message translates to:
  /// **'Xem & Nhận việc'**
  String get workerViewAndAccept;

  /// No description provided for @workerDeclineJob.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối'**
  String get workerDeclineJob;

  /// No description provided for @workerTodaySchedule.
  ///
  /// In vi, this message translates to:
  /// **'Lịch việc hôm nay'**
  String get workerTodaySchedule;

  /// No description provided for @workerUpcoming.
  ///
  /// In vi, this message translates to:
  /// **'Sắp tới'**
  String get workerUpcoming;

  /// No description provided for @workerDone.
  ///
  /// In vi, this message translates to:
  /// **'Đã xong'**
  String get workerDone;

  /// No description provided for @workerNavJobs.
  ///
  /// In vi, this message translates to:
  /// **'Việc'**
  String get workerNavJobs;

  /// No description provided for @workerNavSchedule.
  ///
  /// In vi, this message translates to:
  /// **'Lịch'**
  String get workerNavSchedule;

  /// No description provided for @workerNavWallet.
  ///
  /// In vi, this message translates to:
  /// **'Ví'**
  String get workerNavWallet;

  /// No description provided for @workerNavProfile.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ'**
  String get workerNavProfile;

  /// No description provided for @jobDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết yêu cầu việc'**
  String get jobDetailTitle;

  /// No description provided for @jobCustomerName.
  ///
  /// In vi, this message translates to:
  /// **'Khách hàng'**
  String get jobCustomerName;

  /// No description provided for @jobCustomerAddress.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ làm việc'**
  String get jobCustomerAddress;

  /// No description provided for @jobDistance.
  ///
  /// In vi, this message translates to:
  /// **'Khoảng cách: {dist}'**
  String jobDistance(String dist);

  /// No description provided for @jobEstimatedTime.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian dự kiến: {time}'**
  String jobEstimatedTime(String time);

  /// No description provided for @jobPriceBreakdown.
  ///
  /// In vi, this message translates to:
  /// **'Bảng kê thu nhập minh bạch'**
  String get jobPriceBreakdown;

  /// No description provided for @jobLabourFee.
  ///
  /// In vi, this message translates to:
  /// **'Công thợ trọn gói'**
  String get jobLabourFee;

  /// No description provided for @jobSiteSurcharge.
  ///
  /// In vi, this message translates to:
  /// **'Phụ phí mặt bằng'**
  String get jobSiteSurcharge;

  /// No description provided for @jobPlatformFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí nền tảng (15%)'**
  String get jobPlatformFee;

  /// No description provided for @jobAcceptCta.
  ///
  /// In vi, this message translates to:
  /// **'Nhận việc ngay'**
  String get jobAcceptCta;

  /// No description provided for @jobAcceptedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã nhận việc thành công! Vui lòng chuẩn bị di chuyển'**
  String get jobAcceptedSuccess;

  /// No description provided for @kycTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký Thợ đối tác'**
  String get kycTitle;

  /// No description provided for @kycStepProgress.
  ///
  /// In vi, this message translates to:
  /// **'Bước {step}/6'**
  String kycStepProgress(int step);

  /// No description provided for @kycStep2Title.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cá nhân & Khu vực'**
  String get kycStep2Title;

  /// No description provided for @kycStep2Desc.
  ///
  /// In vi, this message translates to:
  /// **'Điền thông tin cơ bản và chọn các quận/huyện bạn sẵn sàng nhận việc.'**
  String get kycStep2Desc;

  /// No description provided for @kycDistrictSelect.
  ///
  /// In vi, this message translates to:
  /// **'Khu vực nhận việc (chọn nhiều)'**
  String get kycDistrictSelect;

  /// No description provided for @kycDistrictQ1.
  ///
  /// In vi, this message translates to:
  /// **'Quận 1'**
  String get kycDistrictQ1;

  /// No description provided for @kycDistrictQ2.
  ///
  /// In vi, this message translates to:
  /// **'Quận 2 (TP. Thủ Đức)'**
  String get kycDistrictQ2;

  /// No description provided for @kycDistrictQ7.
  ///
  /// In vi, this message translates to:
  /// **'Quận 7'**
  String get kycDistrictQ7;

  /// No description provided for @kycDistrictBinhThanh.
  ///
  /// In vi, this message translates to:
  /// **'Bình Thạnh'**
  String get kycDistrictBinhThanh;

  /// No description provided for @kycDistrictPhuNhuan.
  ///
  /// In vi, this message translates to:
  /// **'Phú Nhuận'**
  String get kycDistrictPhuNhuan;

  /// No description provided for @kycStep3Title.
  ///
  /// In vi, this message translates to:
  /// **'Xác minh Căn cước công dân'**
  String get kycStep3Title;

  /// No description provided for @kycStep3Desc.
  ///
  /// In vi, this message translates to:
  /// **'Chụp rõ 2 mặt CCCD gắn chip chính chủ, không lóa sáng hoặc mất góc.'**
  String get kycStep3Desc;

  /// No description provided for @kycIdFront.
  ///
  /// In vi, this message translates to:
  /// **'Mặt trước CCCD'**
  String get kycIdFront;

  /// No description provided for @kycIdBack.
  ///
  /// In vi, this message translates to:
  /// **'Mặt sau CCCD'**
  String get kycIdBack;

  /// No description provided for @kycCaptured.
  ///
  /// In vi, this message translates to:
  /// **'Đã chụp'**
  String get kycCaptured;

  /// No description provided for @kycTapToCapture.
  ///
  /// In vi, this message translates to:
  /// **'Chạm để chụp'**
  String get kycTapToCapture;

  /// No description provided for @kycStep4Title.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh selfie chân dung'**
  String get kycStep4Title;

  /// No description provided for @kycStep4Desc.
  ///
  /// In vi, this message translates to:
  /// **'Nhìn thẳng vào camera, đảm bảo đủ sáng, không đeo kính râm hoặc khẩu trang.'**
  String get kycStep4Desc;

  /// No description provided for @kycTakeSelfie.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh khuôn mặt'**
  String get kycTakeSelfie;

  /// No description provided for @kycStep5Title.
  ///
  /// In vi, this message translates to:
  /// **'Chuyên môn & Chứng chỉ'**
  String get kycStep5Title;

  /// No description provided for @kycStep5Desc.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ Điện lạnh và Lắp đặt trên cao bắt buộc tải lên Chứng chỉ an toàn.'**
  String get kycStep5Desc;

  /// No description provided for @kycCertUpload.
  ///
  /// In vi, this message translates to:
  /// **'Chứng chỉ an toàn lao động'**
  String get kycCertUpload;

  /// No description provided for @kycCertUploaded.
  ///
  /// In vi, this message translates to:
  /// **'Đã tải lên chứng chỉ'**
  String get kycCertUploaded;

  /// No description provided for @kycStep6Title.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản ngân hàng nhận tiền'**
  String get kycStep6Title;

  /// No description provided for @kycStep6Desc.
  ///
  /// In vi, this message translates to:
  /// **'Tên chủ tài khoản phải trùng khớp 100% với tên trên CCCD của bạn.'**
  String get kycStep6Desc;

  /// No description provided for @kycBankName.
  ///
  /// In vi, this message translates to:
  /// **'Ngân hàng'**
  String get kycBankName;

  /// No description provided for @kycBankHint.
  ///
  /// In vi, this message translates to:
  /// **'Vietcombank, MB Bank, Techcombank...'**
  String get kycBankHint;

  /// No description provided for @kycAccountNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số tài khoản'**
  String get kycAccountNumber;

  /// No description provided for @kycAccountNumberHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số tài khoản ngân hàng'**
  String get kycAccountNumberHint;

  /// No description provided for @kycAccountHolder.
  ///
  /// In vi, this message translates to:
  /// **'Tên chủ tài khoản'**
  String get kycAccountHolder;

  /// No description provided for @kycAccountHolderHint.
  ///
  /// In vi, this message translates to:
  /// **'TRAN VAN HUNG'**
  String get kycAccountHolderHint;

  /// No description provided for @kycSubmitCta.
  ///
  /// In vi, this message translates to:
  /// **'Gửi hồ sơ xét duyệt'**
  String get kycSubmitCta;

  /// No description provided for @kycStatusTitle.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái hồ sơ'**
  String get kycStatusTitle;

  /// No description provided for @kycPendingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ đang được xét duyệt'**
  String get kycPendingTitle;

  /// No description provided for @kycPendingDesc.
  ///
  /// In vi, this message translates to:
  /// **'Đội ngũ VSTech đang kiểm tra chứng từ của bạn. Kết quả sẽ có trong vòng 24 giờ làm việc.'**
  String get kycPendingDesc;

  /// No description provided for @kycNeedsInfoTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cần bổ sung thông tin'**
  String get kycNeedsInfoTitle;

  /// No description provided for @kycNeedsInfoDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh mặt sau CCCD bị lóa sáng mờ số. Vui lòng chụp lại ảnh rõ nét.'**
  String get kycNeedsInfoDesc;

  /// No description provided for @kycReuploadId.
  ///
  /// In vi, this message translates to:
  /// **'Bổ sung ảnh CCCD'**
  String get kycReuploadId;

  /// No description provided for @kycApprovedTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ đã được phê duyệt! 🎉'**
  String get kycApprovedTitle;

  /// No description provided for @kycApprovedDesc.
  ///
  /// In vi, this message translates to:
  /// **'Chúc mừng anh Hùng đã chính thức trở thành Thợ đối tác của VSTech.'**
  String get kycApprovedDesc;

  /// No description provided for @kycStartJobsCta.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu nhận việc'**
  String get kycStartJobsCta;

  /// No description provided for @jobNetEarningsDesc.
  ///
  /// In vi, this message translates to:
  /// **'Cộng thẳng vào ví sau khi hoàn tất'**
  String get jobNetEarningsDesc;

  /// No description provided for @jobSampleCleaningTitle.
  ///
  /// In vi, this message translates to:
  /// **'Dọn dẹp căn hộ 70m²'**
  String get jobSampleCleaningTitle;

  /// No description provided for @jobSampleCustomerName.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thị Thu Thảo'**
  String get jobSampleCustomerName;

  /// No description provided for @jobSampleCustomerAddress.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ B12.04, Masteri Thảo Điền, 159 Xa Lộ Hà Nội, P. Thảo Điền, TP. Thủ Đức'**
  String get jobSampleCustomerAddress;

  /// No description provided for @jobSampleSchedule1Service.
  ///
  /// In vi, this message translates to:
  /// **'Vệ sinh máy lạnh Inverter'**
  String get jobSampleSchedule1Service;

  /// No description provided for @jobSampleSchedule1Customer.
  ///
  /// In vi, this message translates to:
  /// **'Chị Lan • Thảo Điền, Q. 2'**
  String get jobSampleSchedule1Customer;

  /// No description provided for @jobSampleSchedule2Service.
  ///
  /// In vi, this message translates to:
  /// **'Sửa chữa rò rỉ ống nước'**
  String get jobSampleSchedule2Service;

  /// No description provided for @jobSampleSchedule2Customer.
  ///
  /// In vi, this message translates to:
  /// **'Anh Minh • Bình An, Q. 2'**
  String get jobSampleSchedule2Customer;

  /// No description provided for @workerJobsCompletedRatio.
  ///
  /// In vi, this message translates to:
  /// **'2/3 việc'**
  String get workerJobsCompletedRatio;

  /// No description provided for @kycStatusPendingChip.
  ///
  /// In vi, this message translates to:
  /// **'Đang duyệt'**
  String get kycStatusPendingChip;

  /// No description provided for @kycStatusNeedsChip.
  ///
  /// In vi, this message translates to:
  /// **'Cần bổ sung'**
  String get kycStatusNeedsChip;

  /// No description provided for @kycStatusApprovedChip.
  ///
  /// In vi, this message translates to:
  /// **'Đã duyệt'**
  String get kycStatusApprovedChip;

  /// No description provided for @bookingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lịch dịch vụ'**
  String get bookingTitle;

  /// No description provided for @bookingStepProgress.
  ///
  /// In vi, this message translates to:
  /// **'Bước {step}/3: {name}'**
  String bookingStepProgress(int step, String name);

  /// No description provided for @bookingStep1Title.
  ///
  /// In vi, this message translates to:
  /// **'Chọn gói & Dịch vụ kèm'**
  String get bookingStep1Title;

  /// No description provided for @bookingStep2Title.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian & Địa điểm'**
  String get bookingStep2Title;

  /// No description provided for @bookingStep3Title.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận & Chốt đơn'**
  String get bookingStep3Title;

  /// No description provided for @bookingSelectScope.
  ///
  /// In vi, this message translates to:
  /// **'Quy mô căn hộ / diện tích'**
  String get bookingSelectScope;

  /// No description provided for @bookingScopeSmall.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ dưới 70m²'**
  String get bookingScopeSmall;

  /// No description provided for @bookingScopeSmallDesc.
  ///
  /// In vi, this message translates to:
  /// **'1 - 2 phòng ngủ, 1 phòng tắm • Thời gian ~60 - 90 phút'**
  String get bookingScopeSmallDesc;

  /// No description provided for @bookingScopeMedium.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ 70 - 100m²'**
  String get bookingScopeMedium;

  /// No description provided for @bookingScopeMediumDesc.
  ///
  /// In vi, this message translates to:
  /// **'2 - 3 phòng ngủ, 2 phòng tắm • Thời gian ~120 phút'**
  String get bookingScopeMediumDesc;

  /// No description provided for @bookingScopeLarge.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ trên 100m²'**
  String get bookingScopeLarge;

  /// No description provided for @bookingScopeLargeDesc.
  ///
  /// In vi, this message translates to:
  /// **'3+ phòng ngủ, penthouse • Thời gian ~180 phút'**
  String get bookingScopeLargeDesc;

  /// No description provided for @bookingAddonsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ kèm theo (Tùy chọn)'**
  String get bookingAddonsTitle;

  /// No description provided for @bookingAddonTrash.
  ///
  /// In vi, this message translates to:
  /// **'Thu gom rác thải mang xuống'**
  String get bookingAddonTrash;

  /// No description provided for @bookingAddonTrashDesc.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại và mang xuống khu rác tòa nhà'**
  String get bookingAddonTrashDesc;

  /// No description provided for @bookingAddonDisinfect.
  ///
  /// In vi, this message translates to:
  /// **'Khử khuẩn bề mặt Nano Bạc'**
  String get bookingAddonDisinfect;

  /// No description provided for @bookingAddonDisinfectDesc.
  ///
  /// In vi, this message translates to:
  /// **'Diệt 99.9% vi khuẩn bàn ghế, tay nắm cửa, bếp'**
  String get bookingAddonDisinfectDesc;

  /// No description provided for @bookingAddonGlass.
  ///
  /// In vi, this message translates to:
  /// **'Lau kính ngoài ban công'**
  String get bookingAddonGlass;

  /// No description provided for @bookingAddonGlassDesc.
  ///
  /// In vi, this message translates to:
  /// **'Sử dụng gạt kính chuyên dụng & dung dịch chống bám bụi'**
  String get bookingAddonGlassDesc;

  /// No description provided for @bookingEstimatedPreview.
  ///
  /// In vi, this message translates to:
  /// **'Dự toán tạm tính'**
  String get bookingEstimatedPreview;

  /// No description provided for @bookingContinueToSchedule.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục: Chọn ngày giờ'**
  String get bookingContinueToSchedule;

  /// No description provided for @bookingScheduleDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày làm việc'**
  String get bookingScheduleDate;

  /// No description provided for @bookingScheduleToday.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get bookingScheduleToday;

  /// No description provided for @bookingScheduleTomorrow.
  ///
  /// In vi, this message translates to:
  /// **'Ngày mai'**
  String get bookingScheduleTomorrow;

  /// No description provided for @bookingScheduleTimeSlot.
  ///
  /// In vi, this message translates to:
  /// **'Khung giờ thợ đến'**
  String get bookingScheduleTimeSlot;

  /// No description provided for @bookingWorkAddress.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ làm việc'**
  String get bookingWorkAddress;

  /// No description provided for @bookingChangeAddress.
  ///
  /// In vi, this message translates to:
  /// **'Đổi địa chỉ'**
  String get bookingChangeAddress;

  /// No description provided for @bookingPremisesType.
  ///
  /// In vi, this message translates to:
  /// **'Ngữ cảnh mặt bằng (Phụ phí minh bạch)'**
  String get bookingPremisesType;

  /// No description provided for @bookingPremisesGround.
  ///
  /// In vi, this message translates to:
  /// **'Nhà đất / Nhà phố'**
  String get bookingPremisesGround;

  /// No description provided for @bookingPremisesGroundSurcharge.
  ///
  /// In vi, this message translates to:
  /// **'+0đ'**
  String get bookingPremisesGroundSurcharge;

  /// No description provided for @bookingPremisesElevator.
  ///
  /// In vi, this message translates to:
  /// **'Chung cư có thang máy'**
  String get bookingPremisesElevator;

  /// No description provided for @bookingPremisesElevatorSurcharge.
  ///
  /// In vi, this message translates to:
  /// **'+20.000đ'**
  String get bookingPremisesElevatorSurcharge;

  /// No description provided for @bookingPremisesStairs.
  ///
  /// In vi, this message translates to:
  /// **'Chung cư thang bộ (tầng cao)'**
  String get bookingPremisesStairs;

  /// No description provided for @bookingPremisesStairsSurcharge.
  ///
  /// In vi, this message translates to:
  /// **'+50.000đ'**
  String get bookingPremisesStairsSurcharge;

  /// No description provided for @bookingNotesLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú cho thợ'**
  String get bookingNotesLabel;

  /// No description provided for @bookingNotesHint.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Gọi trước khi đến, gửi xe tại hầm B2...'**
  String get bookingNotesHint;

  /// No description provided for @bookingAttachPhotos.
  ///
  /// In vi, this message translates to:
  /// **'Hình ảnh hiện trường (Tùy chọn, tối đa 5 ảnh)'**
  String get bookingAttachPhotos;

  /// No description provided for @bookingPhotoAdded.
  ///
  /// In vi, this message translates to:
  /// **'{count}/5 ảnh'**
  String bookingPhotoAdded(int count);

  /// No description provided for @bookingContinueToConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục: Xác nhận đơn'**
  String get bookingContinueToConfirm;

  /// No description provided for @bookingOrderSummary.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết bảng kê dự toán'**
  String get bookingOrderSummary;

  /// No description provided for @bookingBaseLabourFee.
  ///
  /// In vi, this message translates to:
  /// **'Công thợ gói cơ bản'**
  String get bookingBaseLabourFee;

  /// No description provided for @bookingAddonsFee.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ kèm theo (Add-on)'**
  String get bookingAddonsFee;

  /// No description provided for @bookingPremisesFee.
  ///
  /// In vi, this message translates to:
  /// **'Phụ phí mặt bằng'**
  String get bookingPremisesFee;

  /// No description provided for @bookingDiscountFee.
  ///
  /// In vi, this message translates to:
  /// **'Ưu đãi voucher'**
  String get bookingDiscountFee;

  /// No description provided for @bookingTotalEstimated.
  ///
  /// In vi, this message translates to:
  /// **'Tổng thanh toán dự kiến'**
  String get bookingTotalEstimated;

  /// No description provided for @bookingVoucherLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mã ưu đãi (Voucher)'**
  String get bookingVoucherLabel;

  /// No description provided for @bookingVoucherHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã voucher (ví dụ: NHAMOICHI15)'**
  String get bookingVoucherHint;

  /// No description provided for @bookingVoucherApply.
  ///
  /// In vi, this message translates to:
  /// **'Áp dụng'**
  String get bookingVoucherApply;

  /// No description provided for @bookingVoucherApplied.
  ///
  /// In vi, this message translates to:
  /// **'Đã áp dụng mã giảm 15%'**
  String get bookingVoucherApplied;

  /// No description provided for @bookingPaymentMethod.
  ///
  /// In vi, this message translates to:
  /// **'Phương thức thanh toán'**
  String get bookingPaymentMethod;

  /// No description provided for @bookingPaymentVietQR.
  ///
  /// In vi, this message translates to:
  /// **'Chuyển khoản VietQR'**
  String get bookingPaymentVietQR;

  /// No description provided for @bookingPaymentVietQRDesc.
  ///
  /// In vi, this message translates to:
  /// **'Quét mã QR ngân hàng 24/7 tức thì'**
  String get bookingPaymentVietQRDesc;

  /// No description provided for @bookingPaymentVnPay.
  ///
  /// In vi, this message translates to:
  /// **'Thẻ ATM / Ví điện tử (VNPay)'**
  String get bookingPaymentVnPay;

  /// No description provided for @bookingPaymentVnPayDesc.
  ///
  /// In vi, this message translates to:
  /// **'Thẻ nội địa & quốc tế Visa/Mastercard'**
  String get bookingPaymentVnPayDesc;

  /// No description provided for @bookingPaymentCash.
  ///
  /// In vi, this message translates to:
  /// **'Tiền mặt sau khi hoàn tất'**
  String get bookingPaymentCash;

  /// No description provided for @bookingPaymentCashDesc.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán trực tiếp cho thợ sau khi nghiệm thu'**
  String get bookingPaymentCashDesc;

  /// No description provided for @bookingPayAfterInspectNotice.
  ///
  /// In vi, this message translates to:
  /// **'Cam kết Eco-Clean: Bạn chỉ thanh toán sau khi trực tiếp kiểm tra và nghiệm thu công việc hoàn tất.'**
  String get bookingPayAfterInspectNotice;

  /// No description provided for @bookingWarranty30DaysBadge.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành tự động 0đ trong 30 ngày'**
  String get bookingWarranty30DaysBadge;

  /// No description provided for @bookingConfirmCta.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận đặt lịch · {price}'**
  String bookingConfirmCta(String price);

  /// No description provided for @dispatchRadarTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tìm Thợ đối tác'**
  String get dispatchRadarTitle;

  /// No description provided for @dispatchRadarScanning.
  ///
  /// In vi, this message translates to:
  /// **'Đang quét các Thợ đối tác trong bán kính 2.5 km...'**
  String get dispatchRadarScanning;

  /// No description provided for @dispatchRadarSentToWorkers.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi yêu cầu đến 3 thợ đối tác gần bạn nhất...'**
  String get dispatchRadarSentToWorkers;

  /// No description provided for @dispatchRadarFoundWorker.
  ///
  /// In vi, this message translates to:
  /// **'Đã tìm thấy Thợ đối tác phù hợp!'**
  String get dispatchRadarFoundWorker;

  /// No description provided for @dispatchRadarWorkerAssigned.
  ///
  /// In vi, this message translates to:
  /// **'Anh Nguyễn Văn Hùng đã nhận việc và đang chuẩn bị di chuyển'**
  String get dispatchRadarWorkerAssigned;

  /// No description provided for @dispatchRadarWorkerRating.
  ///
  /// In vi, this message translates to:
  /// **'4.9 ★ • 120+ đơn hoàn tất'**
  String get dispatchRadarWorkerRating;

  /// No description provided for @dispatchRadarCancelSearch.
  ///
  /// In vi, this message translates to:
  /// **'Hủy tìm kiếm'**
  String get dispatchRadarCancelSearch;

  /// No description provided for @dispatchRadarCancelConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn hủy tìm kiếm không?'**
  String get dispatchRadarCancelConfirm;

  /// No description provided for @dispatchRadarViewTracking.
  ///
  /// In vi, this message translates to:
  /// **'Xem vị trí thợ đang di chuyển'**
  String get dispatchRadarViewTracking;

  /// No description provided for @trackingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tiến độ công việc'**
  String get trackingTitle;

  /// No description provided for @trackingOrderCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã đơn: #{code}'**
  String trackingOrderCode(String code);

  /// No description provided for @trackingStageAccepted.
  ///
  /// In vi, this message translates to:
  /// **'Đã nhận việc'**
  String get trackingStageAccepted;

  /// No description provided for @trackingStageEnRoute.
  ///
  /// In vi, this message translates to:
  /// **'Thợ đang đến'**
  String get trackingStageEnRoute;

  /// No description provided for @trackingStageArrived.
  ///
  /// In vi, this message translates to:
  /// **'Thợ đã đến'**
  String get trackingStageArrived;

  /// No description provided for @trackingStageExecuting.
  ///
  /// In vi, this message translates to:
  /// **'Đang thực hiện'**
  String get trackingStageExecuting;

  /// No description provided for @trackingStageSignoff.
  ///
  /// In vi, this message translates to:
  /// **'Chờ nghiệm thu'**
  String get trackingStageSignoff;

  /// No description provided for @trackingEtaNotice.
  ///
  /// In vi, this message translates to:
  /// **'Dự kiến đến sau {minutes} phút · {distance} km'**
  String trackingEtaNotice(int minutes, String distance);

  /// No description provided for @trackingCheckInAt.
  ///
  /// In vi, this message translates to:
  /// **'Thợ đã có mặt lúc {time}'**
  String trackingCheckInAt(String time);

  /// No description provided for @trackingWorkerName.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Văn Hùng'**
  String get trackingWorkerName;

  /// No description provided for @trackingWorkerRating.
  ///
  /// In vi, this message translates to:
  /// **'4.9 ★ (128 việc)'**
  String get trackingWorkerRating;

  /// No description provided for @trackingMaskedCall.
  ///
  /// In vi, this message translates to:
  /// **'Gọi ẩn danh'**
  String get trackingMaskedCall;

  /// No description provided for @trackingChat.
  ///
  /// In vi, this message translates to:
  /// **'Nhắn tin'**
  String get trackingChat;

  /// No description provided for @trackingWorkingTimer.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian làm việc'**
  String get trackingWorkingTimer;

  /// No description provided for @trackingServiceChecklist.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục quy chuẩn an toàn (5 bước)'**
  String get trackingServiceChecklist;

  /// No description provided for @trackingStep1.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm tra hiện trường & chuẩn bị dụng cụ'**
  String get trackingStep1;

  /// No description provided for @trackingStep2.
  ///
  /// In vi, this message translates to:
  /// **'Tháo mặt nạ & vệ sinh lưới lọc bụi'**
  String get trackingStep2;

  /// No description provided for @trackingStep3.
  ///
  /// In vi, this message translates to:
  /// **'Xịt rửa dàn lạnh bằng dung dịch nano diệt khuẩn'**
  String get trackingStep3;

  /// No description provided for @trackingStep4.
  ///
  /// In vi, this message translates to:
  /// **'Vệ sinh dàn nóng & thông tắc ống thoát nước'**
  String get trackingStep4;

  /// No description provided for @trackingStep5.
  ///
  /// In vi, this message translates to:
  /// **'Lắp ráp & kiểm tra đo dòng vận hành'**
  String get trackingStep5;

  /// No description provided for @trackingStatusCompleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã xong'**
  String get trackingStatusCompleted;

  /// No description provided for @trackingStatusDoing.
  ///
  /// In vi, this message translates to:
  /// **'Đang làm'**
  String get trackingStatusDoing;

  /// No description provided for @trackingStatusPending.
  ///
  /// In vi, this message translates to:
  /// **'Chờ tới lượt'**
  String get trackingStatusPending;

  /// No description provided for @trackingProceedToInspection.
  ///
  /// In vi, this message translates to:
  /// **'Tiến hành nghiệm thu'**
  String get trackingProceedToInspection;

  /// No description provided for @trackingHelpSupport.
  ///
  /// In vi, this message translates to:
  /// **'Trợ giúp'**
  String get trackingHelpSupport;

  /// No description provided for @workerEnRouteTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đang di chuyển đến khách'**
  String get workerEnRouteTitle;

  /// No description provided for @workerOpenNavigation.
  ///
  /// In vi, this message translates to:
  /// **'Mở Google Maps dẫn đường'**
  String get workerOpenNavigation;

  /// No description provided for @workerArrivedConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đã đến nơi'**
  String get workerArrivedConfirm;

  /// No description provided for @workerCancelJobPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Huỷ việc'**
  String get workerCancelJobPrompt;

  /// No description provided for @workerDestinationLabel.
  ///
  /// In vi, this message translates to:
  /// **'Điểm đến'**
  String get workerDestinationLabel;

  /// No description provided for @workerCustomerNote.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú: Gọi trước khi đến, gửi xe hầm B2'**
  String get workerCustomerNote;

  /// No description provided for @workerArrivedTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận có mặt'**
  String get workerArrivedTitle;

  /// No description provided for @workerArrivedDesc.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng bấm \'Bắt đầu làm\' sau khi đã gặp khách và chuẩn bị đầy đủ đồ nghề.'**
  String get workerArrivedDesc;

  /// No description provided for @workerStartJobCta.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu làm việc'**
  String get workerStartJobCta;

  /// No description provided for @workerCustomerNoShow.
  ///
  /// In vi, this message translates to:
  /// **'Khách không có mặt?'**
  String get workerCustomerNoShow;

  /// No description provided for @workerExecutingTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đang thực hiện công việc'**
  String get workerExecutingTitle;

  /// No description provided for @workerExtraCostButton.
  ///
  /// In vi, this message translates to:
  /// **'+ Đề xuất chi phí phát sinh'**
  String get workerExtraCostButton;

  /// No description provided for @workerCompleteJobCta.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất công việc -> Chờ nghiệm thu'**
  String get workerCompleteJobCta;

  /// No description provided for @workerExtraCostDialogTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đề xuất chi phí phát sinh'**
  String get workerExtraCostDialogTitle;

  /// No description provided for @workerExtraCostDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nhập linh kiện/vật tư thay thế cần khách hàng duyệt trước khi thi công.'**
  String get workerExtraCostDesc;

  /// No description provided for @workerItemName.
  ///
  /// In vi, this message translates to:
  /// **'Tên linh kiện/vật tư'**
  String get workerItemName;

  /// No description provided for @workerItemPrice.
  ///
  /// In vi, this message translates to:
  /// **'Chi phí (VNĐ)'**
  String get workerItemPrice;

  /// No description provided for @workerSendProposal.
  ///
  /// In vi, this message translates to:
  /// **'Gửi đề xuất đến khách'**
  String get workerSendProposal;

  /// No description provided for @workerProposalSent.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi đề xuất thành công!'**
  String get workerProposalSent;

  /// No description provided for @inspectTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nghiệm thu dịch vụ'**
  String get inspectTitle;

  /// No description provided for @inspectSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng đối chiếu chất lượng công việc thực tế trước khi xác nhận hoàn tất'**
  String get inspectSubtitle;

  /// No description provided for @inspectItem1.
  ///
  /// In vi, this message translates to:
  /// **'Căn hộ đã được quét dọn và hút bụi sạch sẽ'**
  String get inspectItem1;

  /// No description provided for @inspectItem2.
  ///
  /// In vi, this message translates to:
  /// **'Kính cửa sổ và bề mặt kính sáng bóng, không còn vệt nước'**
  String get inspectItem2;

  /// No description provided for @inspectItem3.
  ///
  /// In vi, this message translates to:
  /// **'Rác cồng kềnh đã được thu gom và di chuyển đúng nơi quy định'**
  String get inspectItem3;

  /// No description provided for @inspectItem4.
  ///
  /// In vi, this message translates to:
  /// **'Thiết bị điện tử và đồ đạc trở về vị trí ban đầu'**
  String get inspectItem4;

  /// No description provided for @inspectItem5.
  ///
  /// In vi, this message translates to:
  /// **'Không có hư hại hoặc xê dịch bất thường về tài sản'**
  String get inspectItem5;

  /// No description provided for @inspectSatisfiedCta.
  ///
  /// In vi, this message translates to:
  /// **'Nghiệm thu hài lòng'**
  String get inspectSatisfiedCta;

  /// No description provided for @inspectUnsatisfiedCta.
  ///
  /// In vi, this message translates to:
  /// **'Chưa đạt yêu cầu'**
  String get inspectUnsatisfiedCta;

  /// No description provided for @inspectWarrantyNotice.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành tự động 0đ trong 30 ngày nếu có bất kỳ vấn đề phát sinh.'**
  String get inspectWarrantyNotice;

  /// No description provided for @paymentSummaryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bảng kê thanh toán'**
  String get paymentSummaryTitle;

  /// No description provided for @paymentSummaryDesc.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán minh bạch sau khi trực tiếp nghiệm thu hài lòng'**
  String get paymentSummaryDesc;

  /// No description provided for @paymentExtraCost.
  ///
  /// In vi, this message translates to:
  /// **'Chi phí linh kiện phát sinh (Đã duyệt)'**
  String get paymentExtraCost;

  /// No description provided for @paymentTotalToPay.
  ///
  /// In vi, this message translates to:
  /// **'Tổng số tiền thanh toán'**
  String get paymentTotalToPay;

  /// No description provided for @paymentPayNowCta.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán {amount}'**
  String paymentPayNowCta(String amount);

  /// No description provided for @gatewayTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cổng thanh toán VietQR'**
  String get gatewayTitle;

  /// No description provided for @gatewayScanQrPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Mở ứng dụng Ngân hàng bất kỳ để quét mã VietQR'**
  String get gatewayScanQrPrompt;

  /// No description provided for @gatewayAccountOwner.
  ///
  /// In vi, this message translates to:
  /// **'Chủ thụ hưởng'**
  String get gatewayAccountOwner;

  /// No description provided for @gatewayBankName.
  ///
  /// In vi, this message translates to:
  /// **'Ngân hàng'**
  String get gatewayBankName;

  /// No description provided for @gatewayTransferContent.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung chuyển khoản'**
  String get gatewayTransferContent;

  /// No description provided for @gatewayConfirmTransferred.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đã chuyển khoản thành công'**
  String get gatewayConfirmTransferred;

  /// No description provided for @gatewayCountdown.
  ///
  /// In vi, this message translates to:
  /// **'Mã QR có hiệu lực trong {minutes}:{seconds}'**
  String gatewayCountdown(String minutes, String seconds);

  /// No description provided for @paidSuccessTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán thành công!'**
  String get paidSuccessTitle;

  /// No description provided for @paidSuccessDesc.
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn đã tin tưởng dịch vụ Eco-Clean của VSTech.'**
  String get paidSuccessDesc;

  /// No description provided for @paidPointsEarned.
  ///
  /// In vi, this message translates to:
  /// **'+{points} điểm tích lũy Eco-Clean'**
  String paidPointsEarned(int points);

  /// No description provided for @paidViewReceipt.
  ///
  /// In vi, this message translates to:
  /// **'Xem hóa đơn điện tử'**
  String get paidViewReceipt;

  /// No description provided for @paidReviewWorkerCta.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá Thợ đối tác'**
  String get paidReviewWorkerCta;

  /// No description provided for @receiptTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hóa đơn điện tử'**
  String get receiptTitle;

  /// No description provided for @receiptInvoiceNo.
  ///
  /// In vi, this message translates to:
  /// **'Số hóa đơn: #{no}'**
  String receiptInvoiceNo(String no);

  /// No description provided for @receiptDate.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian xuất hóa đơn'**
  String get receiptDate;

  /// No description provided for @receiptWorkerPayout.
  ///
  /// In vi, this message translates to:
  /// **'Tiền công thợ trực tiếp'**
  String get receiptWorkerPayout;

  /// No description provided for @receiptPlatformFeeShare.
  ///
  /// In vi, this message translates to:
  /// **'Phí nền tảng & Bảo hiểm dịch vụ'**
  String get receiptPlatformFeeShare;

  /// No description provided for @receiptDownloadPdf.
  ///
  /// In vi, this message translates to:
  /// **'Tải hóa đơn PDF'**
  String get receiptDownloadPdf;

  /// No description provided for @receiptDownloading.
  ///
  /// In vi, this message translates to:
  /// **'Đang tải hóa đơn #{orderCode}.pdf...'**
  String receiptDownloading(String orderCode);

  /// No description provided for @receiptShare.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ biên lai'**
  String get receiptShare;

  /// No description provided for @copiedToClipboard.
  ///
  /// In vi, this message translates to:
  /// **'Đã sao chép: {text}'**
  String copiedToClipboard(String text);

  /// No description provided for @reviewTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá dịch vụ'**
  String get reviewTitle;

  /// No description provided for @reviewPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Bạn cảm thấy chất lượng dịch vụ hôm nay thế nào?'**
  String get reviewPrompt;

  /// No description provided for @reviewTagPunctual.
  ///
  /// In vi, this message translates to:
  /// **'Đúng giờ'**
  String get reviewTagPunctual;

  /// No description provided for @reviewTagAttentive.
  ///
  /// In vi, this message translates to:
  /// **'Tận tâm, chu đáo'**
  String get reviewTagAttentive;

  /// No description provided for @reviewTagClean.
  ///
  /// In vi, this message translates to:
  /// **'Sạch sẽ, gọn gàng'**
  String get reviewTagClean;

  /// No description provided for @reviewTagPolite.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sự, trung thực'**
  String get reviewTagPolite;

  /// No description provided for @reviewTipTitle.
  ///
  /// In vi, this message translates to:
  /// **'Gửi tiền tip động viên Thợ'**
  String get reviewTipTitle;

  /// No description provided for @reviewTipSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'100% tiền tip được chuyển trực tiếp vào ví của thợ'**
  String get reviewTipSubtitle;

  /// No description provided for @reviewTipNo.
  ///
  /// In vi, this message translates to:
  /// **'Không tip'**
  String get reviewTipNo;

  /// No description provided for @reviewSubmitWithTip.
  ///
  /// In vi, this message translates to:
  /// **'Gửi đánh giá & Tip {amount}'**
  String reviewSubmitWithTip(String amount);

  /// No description provided for @reviewSubmitOnly.
  ///
  /// In vi, this message translates to:
  /// **'Gửi đánh giá'**
  String get reviewSubmitOnly;

  /// No description provided for @reviewCommentHint.
  ///
  /// In vi, this message translates to:
  /// **'Viết thêm nhận xét giúp thợ cải thiện tay nghề (tùy chọn)...'**
  String get reviewCommentHint;

  /// No description provided for @thanksTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn bạn rất nhiều! 🌿'**
  String get thanksTitle;

  /// No description provided for @thanksSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Ý kiến đánh giá và sự ủng hộ của bạn là động lực to lớn cho đối tác của chúng tôi.'**
  String get thanksSubtitle;

  /// No description provided for @thanksBackHome.
  ///
  /// In vi, this message translates to:
  /// **'Về trang chủ'**
  String get thanksBackHome;

  /// No description provided for @workerWaitTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất đơn công việc'**
  String get workerWaitTitle;

  /// No description provided for @workerWaitInspectionTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chờ khách hàng nghiệm thu'**
  String get workerWaitInspectionTitle;

  /// No description provided for @workerWaitInspectionDesc.
  ///
  /// In vi, this message translates to:
  /// **'Khách hàng đang kiểm tra các hạng mục thực tế.'**
  String get workerWaitInspectionDesc;

  /// No description provided for @workerWaitPaymentTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chờ khách thanh toán'**
  String get workerWaitPaymentTitle;

  /// No description provided for @workerWaitPaymentDesc.
  ///
  /// In vi, this message translates to:
  /// **'Khách đang thực hiện thanh toán {amount} qua VietQR.'**
  String workerWaitPaymentDesc(String amount);

  /// No description provided for @workerPaidCelebrationTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khách đã thanh toán thành công!'**
  String get workerPaidCelebrationTitle;

  /// No description provided for @workerPaidWalletCredit.
  ///
  /// In vi, this message translates to:
  /// **'+{amount} đã được cộng vào ví của bạn'**
  String workerPaidWalletCredit(String amount);

  /// No description provided for @workerViewWalletCta.
  ///
  /// In vi, this message translates to:
  /// **'Xem ví thu nhập'**
  String get workerViewWalletCta;

  /// No description provided for @ordersTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng của tôi'**
  String get ordersTitle;

  /// No description provided for @ordersTabActive.
  ///
  /// In vi, this message translates to:
  /// **'Đang làm'**
  String get ordersTabActive;

  /// No description provided for @ordersTabScheduled.
  ///
  /// In vi, this message translates to:
  /// **'Đang chờ'**
  String get ordersTabScheduled;

  /// No description provided for @ordersTabCompleted.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get ordersTabCompleted;

  /// No description provided for @ordersEmptyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có đơn đặt lịch nào'**
  String get ordersEmptyTitle;

  /// No description provided for @ordersEmptyDesc.
  ///
  /// In vi, this message translates to:
  /// **'Khám phá các dịch vụ gia đình tiện ích và đặt lịch ngay hôm nay.'**
  String get ordersEmptyDesc;

  /// No description provided for @ordersEmptyCta.
  ///
  /// In vi, this message translates to:
  /// **'Khám phá dịch vụ ngay'**
  String get ordersEmptyCta;

  /// No description provided for @ordersTrackWorkerCta.
  ///
  /// In vi, this message translates to:
  /// **'Theo dõi thợ'**
  String get ordersTrackWorkerCta;

  /// No description provided for @ordersRebookCta.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại'**
  String get ordersRebookCta;

  /// No description provided for @ordersWarrantyCta.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành 0đ'**
  String get ordersWarrantyCta;

  /// No description provided for @ordersViewDetailCta.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết đơn'**
  String get ordersViewDetailCta;

  /// No description provided for @orderDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết đơn hàng'**
  String get orderDetailTitle;

  /// No description provided for @orderDetailWorkerCard.
  ///
  /// In vi, this message translates to:
  /// **'Thợ phụ trách'**
  String get orderDetailWorkerCard;

  /// No description provided for @orderDetailScheduleCard.
  ///
  /// In vi, this message translates to:
  /// **'Lịch hẹn & Địa điểm'**
  String get orderDetailScheduleCard;

  /// No description provided for @orderDetailPriceCard.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết thanh toán'**
  String get orderDetailPriceCard;

  /// No description provided for @orderDetailPaidStatus.
  ///
  /// In vi, this message translates to:
  /// **'Đã thanh toán'**
  String get orderDetailPaidStatus;

  /// No description provided for @orderDetailUnpaidStatus.
  ///
  /// In vi, this message translates to:
  /// **'Chờ thanh toán'**
  String get orderDetailUnpaidStatus;

  /// No description provided for @orderDetailWarrantyBadge.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành tự động 0đ trong 30 ngày'**
  String get orderDetailWarrantyBadge;

  /// No description provided for @orderDetailCancelCta.
  ///
  /// In vi, this message translates to:
  /// **'Hủy đơn'**
  String get orderDetailCancelCta;

  /// No description provided for @orderDetailContactSupport.
  ///
  /// In vi, this message translates to:
  /// **'Hỗ trợ khách hàng'**
  String get orderDetailContactSupport;

  /// No description provided for @workerJobsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý công việc'**
  String get workerJobsTitle;

  /// No description provided for @workerJobsTabAssigned.
  ///
  /// In vi, this message translates to:
  /// **'Mới phân công'**
  String get workerJobsTabAssigned;

  /// No description provided for @workerJobsTabActive.
  ///
  /// In vi, this message translates to:
  /// **'Đang làm'**
  String get workerJobsTabActive;

  /// No description provided for @workerJobsTabCompleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã hoàn tất'**
  String get workerJobsTabCompleted;

  /// No description provided for @workerJobsDistance.
  ///
  /// In vi, this message translates to:
  /// **'{km} km'**
  String workerJobsDistance(String km);

  /// No description provided for @workerJobsEarningsEst.
  ///
  /// In vi, this message translates to:
  /// **'Thu nhập ước tính: +{amount}'**
  String workerJobsEarningsEst(String amount);

  /// No description provided for @workerJobsAcceptJob.
  ///
  /// In vi, this message translates to:
  /// **'Nhận việc ngay'**
  String get workerJobsAcceptJob;

  /// No description provided for @workerJobsGoToWork.
  ///
  /// In vi, this message translates to:
  /// **'Vào ca làm việc'**
  String get workerJobsGoToWork;

  /// No description provided for @workerJobsCompletedBadge.
  ///
  /// In vi, this message translates to:
  /// **'Đã quyết toán'**
  String get workerJobsCompletedBadge;

  /// No description provided for @workerJobsEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Hiện không có công việc nào trong danh mục này'**
  String get workerJobsEmpty;

  /// No description provided for @notificationsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo'**
  String get notificationsTitle;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In vi, this message translates to:
  /// **'Đã đọc tất cả'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsSectionToday.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get notificationsSectionToday;

  /// No description provided for @notificationsSectionEarlier.
  ///
  /// In vi, this message translates to:
  /// **'Trước đó'**
  String get notificationsSectionEarlier;

  /// No description provided for @notificationsTabAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get notificationsTabAll;

  /// No description provided for @notificationsTabOrders.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng'**
  String get notificationsTabOrders;

  /// No description provided for @notificationsTabPromo.
  ///
  /// In vi, this message translates to:
  /// **'Khuyến mãi'**
  String get notificationsTabPromo;

  /// No description provided for @notificationsTabSystem.
  ///
  /// In vi, this message translates to:
  /// **'Hệ thống'**
  String get notificationsTabSystem;

  /// No description provided for @notificationsEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Không có thông báo mới'**
  String get notificationsEmpty;

  /// No description provided for @notifSettingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt thông báo'**
  String get notifSettingsTitle;

  /// No description provided for @notifSettingsPush.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo đẩy (Push)'**
  String get notifSettingsPush;

  /// No description provided for @notifSettingsPushDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo tiến độ thợ và trạng thái đơn hàng tức thì'**
  String get notifSettingsPushDesc;

  /// No description provided for @notifSettingsSms.
  ///
  /// In vi, this message translates to:
  /// **'Tin nhắn SMS'**
  String get notifSettingsSms;

  /// No description provided for @notifSettingsSmsDesc.
  ///
  /// In vi, this message translates to:
  /// **'Gửi mã OTP và biên lai xác nhận qua SMS'**
  String get notifSettingsSmsDesc;

  /// No description provided for @notifSettingsZalo.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo Zalo (ZNS)'**
  String get notifSettingsZalo;

  /// No description provided for @notifSettingsZaloDesc.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật qua Zalo Official Account chính thức của VSTech'**
  String get notifSettingsZaloDesc;

  /// No description provided for @notifSettingsPromo.
  ///
  /// In vi, this message translates to:
  /// **'Tin khuyến mãi & Ưu đãi'**
  String get notifSettingsPromo;

  /// No description provided for @notifSettingsPromoDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nhận voucher giảm giá định kỳ và chương trình tri ân'**
  String get notifSettingsPromoDesc;

  /// No description provided for @notifSettingsSave.
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get notifSettingsSave;

  /// No description provided for @notifSettingsSaved.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu cài đặt thông báo'**
  String get notifSettingsSaved;

  /// No description provided for @cancelTitle.
  ///
  /// In vi, this message translates to:
  /// **'Huỷ đặt lịch'**
  String get cancelTitle;

  /// No description provided for @cancelFreeSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Huỷ miễn phí trước khi thợ nhận việc'**
  String get cancelFreeSubtitle;

  /// No description provided for @cancelFeeSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Phí huỷ đơn {fee} sau khi thợ đã nhận việc'**
  String cancelFeeSubtitle(String fee);

  /// No description provided for @cancelReasonPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng chọn lý do huỷ:'**
  String get cancelReasonPrompt;

  /// No description provided for @cancelReasonChangeSchedule.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi lịch bận đột xuất'**
  String get cancelReasonChangeSchedule;

  /// No description provided for @cancelReasonFoundOther.
  ///
  /// In vi, this message translates to:
  /// **'Tìm được giải pháp khác'**
  String get cancelReasonFoundOther;

  /// No description provided for @cancelReasonWrongInfo.
  ///
  /// In vi, this message translates to:
  /// **'Đặt nhầm dịch vụ hoặc địa chỉ'**
  String get cancelReasonWrongInfo;

  /// No description provided for @cancelReasonLateWorker.
  ///
  /// In vi, this message translates to:
  /// **'Thợ đến quá muộn so với hẹn'**
  String get cancelReasonLateWorker;

  /// No description provided for @cancelReasonOther.
  ///
  /// In vi, this message translates to:
  /// **'Lý do khác'**
  String get cancelReasonOther;

  /// No description provided for @cancelReasonOtherHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lý do chi tiết của bạn...'**
  String get cancelReasonOtherHint;

  /// No description provided for @cancelPolicyNoteFree.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng sẽ được huỷ ngay lập tức mà không phát sinh bất kỳ khoản phí nào.'**
  String get cancelPolicyNoteFree;

  /// No description provided for @cancelPolicyNoteFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí huỷ 50.000đ sẽ được trừ vào tài khoản nhằm hỗ trợ chi phí di chuyển của Thợ đối tác.'**
  String get cancelPolicyNoteFee;

  /// No description provided for @cancelConfirmBtnFree.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận huỷ miễn phí'**
  String get cancelConfirmBtnFree;

  /// No description provided for @cancelConfirmBtnFee.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận huỷ & Trả 50.000đ'**
  String get cancelConfirmBtnFee;

  /// No description provided for @cancelKeepBookingBtn.
  ///
  /// In vi, this message translates to:
  /// **'Giữ lại đơn hàng'**
  String get cancelKeepBookingBtn;

  /// No description provided for @workerCancelTitle.
  ///
  /// In vi, this message translates to:
  /// **'Huỷ nhận việc'**
  String get workerCancelTitle;

  /// No description provided for @workerCancelWarning.
  ///
  /// In vi, this message translates to:
  /// **'Cảnh báo: Việc huỷ đơn sẽ giảm tỉ lệ hoàn thành của bạn từ 96% xuống 95% và có thể ảnh hưởng đến thứ hạng phân đơn.'**
  String get workerCancelWarning;

  /// No description provided for @workerCancelReasonPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Chọn lý do huỷ việc:'**
  String get workerCancelReasonPrompt;

  /// No description provided for @workerCancelReasonVehicle.
  ///
  /// In vi, this message translates to:
  /// **'Hỏng xe hoặc sự cố giao thông trên đường'**
  String get workerCancelReasonVehicle;

  /// No description provided for @workerCancelReasonEmergency.
  ///
  /// In vi, this message translates to:
  /// **'Việc gia đình khẩn cấp'**
  String get workerCancelReasonEmergency;

  /// No description provided for @workerCancelReasonNoContact.
  ///
  /// In vi, this message translates to:
  /// **'Không liên lạc được với khách hàng sau 3 cuộc gọi'**
  String get workerCancelReasonNoContact;

  /// No description provided for @workerCancelReasonUnsafe.
  ///
  /// In vi, this message translates to:
  /// **'Hiện trường thi công không đảm bảo an toàn'**
  String get workerCancelReasonUnsafe;

  /// No description provided for @workerCancelReasonOther.
  ///
  /// In vi, this message translates to:
  /// **'Lý do khác'**
  String get workerCancelReasonOther;

  /// No description provided for @workerCancelReasonOtherHint.
  ///
  /// In vi, this message translates to:
  /// **'Ghi rõ lý do đột xuất...'**
  String get workerCancelReasonOtherHint;

  /// No description provided for @workerCancelConfirmBtn.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận huỷ việc'**
  String get workerCancelConfirmBtn;

  /// No description provided for @workerCancelKeepJobBtn.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục công việc'**
  String get workerCancelKeepJobBtn;

  /// No description provided for @noShowTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chờ khách hàng'**
  String get noShowTitle;

  /// No description provided for @noShowSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Đã đến hiện trường — Đang chờ khách mở cửa'**
  String get noShowSubtitle;

  /// No description provided for @noShowTimerDesc.
  ///
  /// In vi, this message translates to:
  /// **'Quy định chờ tối đa 15 phút. Nếu khách không phản hồi, bạn sẽ được nhận phí hỗ trợ 50.000đ.'**
  String get noShowTimerDesc;

  /// No description provided for @noShowCallReminder.
  ///
  /// In vi, this message translates to:
  /// **'Gọi điện nhắc khách'**
  String get noShowCallReminder;

  /// No description provided for @noShowChatReminder.
  ///
  /// In vi, this message translates to:
  /// **'Nhắn tin nhắc khách'**
  String get noShowChatReminder;

  /// No description provided for @noShowReportBtn.
  ///
  /// In vi, this message translates to:
  /// **'Báo khách vắng mặt'**
  String get noShowReportBtn;

  /// No description provided for @noShowUploadEvidencePrompt.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh cửa nhà / hiện trường để xác thực:'**
  String get noShowUploadEvidencePrompt;

  /// No description provided for @noShowUploadBtn.
  ///
  /// In vi, this message translates to:
  /// **'Chụp ảnh hiện trường'**
  String get noShowUploadBtn;

  /// No description provided for @noShowConfirmReportBtn.
  ///
  /// In vi, this message translates to:
  /// **'Gửi biên bản vắng mặt'**
  String get noShowConfirmReportBtn;

  /// No description provided for @noShowSuccessTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đã ghi nhận vắng mặt'**
  String get noShowSuccessTitle;

  /// No description provided for @noShowSuccessDesc.
  ///
  /// In vi, this message translates to:
  /// **'Hệ thống đã tự động huỷ đơn và cộng 50.000đ phí hỗ trợ di chuyển vào ví của bạn.'**
  String get noShowSuccessDesc;

  /// No description provided for @noShowBackHomeBtn.
  ///
  /// In vi, this message translates to:
  /// **'Về danh sách việc'**
  String get noShowBackHomeBtn;

  /// No description provided for @disputeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Báo vấn đề & Khiếu nại'**
  String get disputeTitle;

  /// No description provided for @disputeTypePrompt.
  ///
  /// In vi, this message translates to:
  /// **'Chọn vấn đề bạn gặp phải:'**
  String get disputeTypePrompt;

  /// No description provided for @disputeTypeQuality.
  ///
  /// In vi, this message translates to:
  /// **'Chất lượng dịch vụ không đạt yêu cầu'**
  String get disputeTypeQuality;

  /// No description provided for @disputeTypeDamage.
  ///
  /// In vi, this message translates to:
  /// **'Gây hư hỏng / mất mát tài sản'**
  String get disputeTypeDamage;

  /// No description provided for @disputeTypeAttitude.
  ///
  /// In vi, this message translates to:
  /// **'Thái độ thợ không đúng mực'**
  String get disputeTypeAttitude;

  /// No description provided for @disputeTypeOvercharge.
  ///
  /// In vi, this message translates to:
  /// **'Thu tiền sai lệch so với báo giá'**
  String get disputeTypeOvercharge;

  /// No description provided for @disputeTypeOther.
  ///
  /// In vi, this message translates to:
  /// **'Vấn đề khác'**
  String get disputeTypeOther;

  /// No description provided for @disputeDescPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả chi tiết sự việc:'**
  String get disputeDescPrompt;

  /// No description provided for @disputeDescHint.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nêu rõ chi tiết sự việc để VSTech hỗ trợ phân xử nhanh nhất...'**
  String get disputeDescHint;

  /// No description provided for @disputePhotosPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Hình ảnh bằng chứng (tối đa 5 ảnh):'**
  String get disputePhotosPrompt;

  /// No description provided for @disputeAddPhoto.
  ///
  /// In vi, this message translates to:
  /// **'Thêm ảnh'**
  String get disputeAddPhoto;

  /// No description provided for @disputeEscrowNotice.
  ///
  /// In vi, this message translates to:
  /// **'Bảo vệ Escrow: Số tiền 400.000đ đang được đóng băng an toàn trong tài khoản trung gian. Thợ sẽ không thể rút tiền cho đến khi khiếu nại được giải quyết thỏa đáng.'**
  String get disputeEscrowNotice;

  /// No description provided for @disputeSubmitBtn.
  ///
  /// In vi, this message translates to:
  /// **'Gửi khiếu nại & Đóng băng tiền'**
  String get disputeSubmitBtn;

  /// No description provided for @disputedStatusTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đơn đang được xem xét'**
  String get disputedStatusTitle;

  /// No description provided for @disputedComplaintCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã khiếu nại: {code}'**
  String disputedComplaintCode(String code);

  /// No description provided for @disputedEscrowBadge.
  ///
  /// In vi, this message translates to:
  /// **'Được bảo vệ bởi VSTech Escrow'**
  String get disputedEscrowBadge;

  /// No description provided for @disputedTimelineTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quy trình giải quyết khiếu nại:'**
  String get disputedTimelineTitle;

  /// No description provided for @disputedStep1.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp nhận khiếu nại & đóng băng tiền công thợ (Đã xong)'**
  String get disputedStep1;

  /// No description provided for @disputedStep2.
  ///
  /// In vi, this message translates to:
  /// **'Chuyên viên liên hệ đối chất và kiểm tra hình ảnh hiện trường (Trong 2h)'**
  String get disputedStep2;

  /// No description provided for @disputedStep3.
  ///
  /// In vi, this message translates to:
  /// **'Đưa ra giải pháp: Bảo hành làm lại 0đ hoặc hoàn tiền về ví (Tối đa 24h)'**
  String get disputedStep3;

  /// No description provided for @disputedViewComplaintsBtn.
  ///
  /// In vi, this message translates to:
  /// **'Xem danh sách khiếu nại'**
  String get disputedViewComplaintsBtn;

  /// No description provided for @disputedBackOrderBtn.
  ///
  /// In vi, this message translates to:
  /// **'Về chi tiết đơn hàng'**
  String get disputedBackOrderBtn;

  /// No description provided for @complaintsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khiếu nại của tôi'**
  String get complaintsTitle;

  /// No description provided for @complaintsTabReviewing.
  ///
  /// In vi, this message translates to:
  /// **'Đang xem xét'**
  String get complaintsTabReviewing;

  /// No description provided for @complaintsTabNeedInfo.
  ///
  /// In vi, this message translates to:
  /// **'Cần bổ sung'**
  String get complaintsTabNeedInfo;

  /// No description provided for @complaintsTabResolved.
  ///
  /// In vi, this message translates to:
  /// **'Đã giải quyết'**
  String get complaintsTabResolved;

  /// No description provided for @complaintsTabClosed.
  ///
  /// In vi, this message translates to:
  /// **'Đã đóng'**
  String get complaintsTabClosed;

  /// No description provided for @complaintsEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Không có khiếu nại nào trong mục này'**
  String get complaintsEmpty;

  /// No description provided for @complaintDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết khiếu nại'**
  String get complaintDetailTitle;

  /// No description provided for @complaintDetailOrderCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã đơn hàng: {code}'**
  String complaintDetailOrderCode(String code);

  /// No description provided for @complaintDetailDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày tạo: {date}'**
  String complaintDetailDate(String date);

  /// No description provided for @complaintDetailResolution.
  ///
  /// In vi, this message translates to:
  /// **'Kết quả xử lý'**
  String get complaintDetailResolution;

  /// No description provided for @complaintDetailRefundNotice.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tiền {amount} vào ví điện tử trong 3-5 ngày làm việc'**
  String complaintDetailRefundNotice(String amount);

  /// No description provided for @complaintDetailAddInfoPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Chuyên viên cần bạn cung cấp thêm ảnh chụp toàn cảnh thiết bị:'**
  String get complaintDetailAddInfoPrompt;

  /// No description provided for @complaintDetailAddInfoBtn.
  ///
  /// In vi, this message translates to:
  /// **'Bổ sung thông tin'**
  String get complaintDetailAddInfoBtn;

  /// No description provided for @workerDisputeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khách hàng khiếu nại'**
  String get workerDisputeTitle;

  /// No description provided for @workerDisputeWarning.
  ///
  /// In vi, this message translates to:
  /// **'Khách hàng đã gửi khiếu nại cho đơn hàng {code}. Số tiền công {amount} đang được tạm giữ an toàn trong tài khoản bảo chứng Escrow.'**
  String workerDisputeWarning(String code, String amount);

  /// No description provided for @workerDisputeClaimSection.
  ///
  /// In vi, this message translates to:
  /// **'Nội dung khiếu nại:'**
  String get workerDisputeClaimSection;

  /// No description provided for @workerDisputeReplyPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Gửi phản hồi / giải trình của bạn:'**
  String get workerDisputeReplyPrompt;

  /// No description provided for @workerDisputeReplyHint.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả quá trình thực hiện công việc và bằng chứng nghiệm thu...'**
  String get workerDisputeReplyHint;

  /// No description provided for @workerDisputeSubmitReplyBtn.
  ///
  /// In vi, this message translates to:
  /// **'Gửi giải trình'**
  String get workerDisputeSubmitReplyBtn;

  /// No description provided for @warrantyCertTitle.
  ///
  /// In vi, this message translates to:
  /// **'Phiếu bảo hành'**
  String get warrantyCertTitle;

  /// No description provided for @warrantyCertNumber.
  ///
  /// In vi, this message translates to:
  /// **'Phiếu BH-{code}'**
  String warrantyCertNumber(String code);

  /// No description provided for @warrantyActiveStatus.
  ///
  /// In vi, this message translates to:
  /// **'CÒN HIỆU LỰC'**
  String get warrantyActiveStatus;

  /// No description provided for @warrantyExpiredStatus.
  ///
  /// In vi, this message translates to:
  /// **'HẾT HẠN'**
  String get warrantyExpiredStatus;

  /// No description provided for @warrantyTechnicianLabel.
  ///
  /// In vi, this message translates to:
  /// **'Kỹ thuật viên'**
  String get warrantyTechnicianLabel;

  /// No description provided for @warrantyCompletedLabel.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tất'**
  String get warrantyCompletedLabel;

  /// No description provided for @warrantyPeriodLabel.
  ///
  /// In vi, this message translates to:
  /// **'Thời hạn'**
  String get warrantyPeriodLabel;

  /// No description provided for @warrantyPeriodValue.
  ///
  /// In vi, this message translates to:
  /// **'60 ngày · đến 17/05/2026'**
  String get warrantyPeriodValue;

  /// No description provided for @warrantyRemainingLabel.
  ///
  /// In vi, this message translates to:
  /// **'Còn lại'**
  String get warrantyRemainingLabel;

  /// No description provided for @warrantyRemainingDays.
  ///
  /// In vi, this message translates to:
  /// **'22 ngày'**
  String get warrantyRemainingDays;

  /// No description provided for @warrantyExpiredText.
  ///
  /// In vi, this message translates to:
  /// **'Đã hết hạn'**
  String get warrantyExpiredText;

  /// No description provided for @warrantyQrNote.
  ///
  /// In vi, this message translates to:
  /// **'Thợ quét mã này khi đến bảo hành để mở đúng đơn gốc.'**
  String get warrantyQrNote;

  /// No description provided for @warrantyCoveredTitle.
  ///
  /// In vi, this message translates to:
  /// **'Được bảo hành'**
  String get warrantyCoveredTitle;

  /// No description provided for @warrantyNotCoveredTitle.
  ///
  /// In vi, this message translates to:
  /// **'Không bảo hành'**
  String get warrantyNotCoveredTitle;

  /// No description provided for @warrantyCoveredItem1.
  ///
  /// In vi, this message translates to:
  /// **'Máy lạnh bị chảy nước sau khi vệ sinh'**
  String get warrantyCoveredItem1;

  /// No description provided for @warrantyCoveredItem2.
  ///
  /// In vi, this message translates to:
  /// **'Lỗi rò rỉ gas do kỹ thuật tháo lắp dàn lạnh'**
  String get warrantyCoveredItem2;

  /// No description provided for @warrantyCoveredItem3.
  ///
  /// In vi, this message translates to:
  /// **'Vấn đề vệ sinh chưa sạch trong phạm vi cam kết'**
  String get warrantyCoveredItem3;

  /// No description provided for @warrantyNotCoveredItem1.
  ///
  /// In vi, this message translates to:
  /// **'Hư hỏng do nguồn điện gia đình chập chờn'**
  String get warrantyNotCoveredItem1;

  /// No description provided for @warrantyNotCoveredItem2.
  ///
  /// In vi, this message translates to:
  /// **'Thiết bị bị can thiệp bởi bên thứ ba'**
  String get warrantyNotCoveredItem2;

  /// No description provided for @warrantyNotCoveredItem3.
  ///
  /// In vi, this message translates to:
  /// **'Thiết bị quá cũ đã hết tuổi thọ khuyến nghị'**
  String get warrantyNotCoveredItem3;

  /// No description provided for @warrantyRequestCta.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu bảo hành'**
  String get warrantyRequestCta;

  /// No description provided for @warrantyViewRequestCta.
  ///
  /// In vi, this message translates to:
  /// **'Xem yêu cầu bảo hành'**
  String get warrantyViewRequestCta;

  /// No description provided for @warrantyRequestTitle.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu bảo hành'**
  String get warrantyRequestTitle;

  /// No description provided for @warrantyRequestSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành cho {code}'**
  String warrantyRequestSubtitle(String code);

  /// No description provided for @warrantyRequestFreePrice.
  ///
  /// In vi, this message translates to:
  /// **'0đ'**
  String get warrantyRequestFreePrice;

  /// No description provided for @warrantyDescribeIssueTitle.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả sự cố'**
  String get warrantyDescribeIssueTitle;

  /// No description provided for @warrantyDescribePlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Chạm để mô tả sự cố bạn đang gặp phải...'**
  String get warrantyDescribePlaceholder;

  /// No description provided for @warrantyDescribePreset.
  ///
  /// In vi, this message translates to:
  /// **'Máy lạnh chảy nước sau khi vệ sinh'**
  String get warrantyDescribePreset;

  /// No description provided for @warrantyMediaTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh / Video (tối đa 5 ảnh hoặc 1 video)'**
  String get warrantyMediaTitle;

  /// No description provided for @warrantyAddPhotoCta.
  ///
  /// In vi, this message translates to:
  /// **'+ Thêm ảnh'**
  String get warrantyAddPhotoCta;

  /// No description provided for @warrantySlotTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khung giờ mong muốn (chọn nhiều)'**
  String get warrantySlotTitle;

  /// No description provided for @warrantySlot1.
  ///
  /// In vi, this message translates to:
  /// **'Mai 26/04 · 08:00 - 10:00'**
  String get warrantySlot1;

  /// No description provided for @warrantySlot2.
  ///
  /// In vi, this message translates to:
  /// **'Mai 26/04 · 14:00 - 16:00'**
  String get warrantySlot2;

  /// No description provided for @warrantySlot3.
  ///
  /// In vi, this message translates to:
  /// **'CN 27/04 · 09:00 - 11:00'**
  String get warrantySlot3;

  /// No description provided for @warrantyFreePolicy.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành miễn phí · 0đ. Không cần thanh toán.'**
  String get warrantyFreePolicy;

  /// No description provided for @warrantySubmitCta.
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu bảo hành'**
  String get warrantySubmitCta;

  /// No description provided for @warrantySlotRequiredPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ít nhất một khung giờ'**
  String get warrantySlotRequiredPrompt;

  /// No description provided for @warrantyDescRequiredPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả sự cố để gửi'**
  String get warrantyDescRequiredPrompt;

  /// No description provided for @warrantyStatusTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tiến trình bảo hành'**
  String get warrantyStatusTitle;

  /// No description provided for @warrantyBadgeTag.
  ///
  /// In vi, this message translates to:
  /// **'BẢO HÀNH'**
  String get warrantyBadgeTag;

  /// No description provided for @warrantyStatusCode.
  ///
  /// In vi, this message translates to:
  /// **'#BH20250425-0087'**
  String get warrantyStatusCode;

  /// No description provided for @warrantyStepSubmitted.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi'**
  String get warrantyStepSubmitted;

  /// No description provided for @warrantyStepAccepted.
  ///
  /// In vi, this message translates to:
  /// **'Thợ đã nhận'**
  String get warrantyStepAccepted;

  /// No description provided for @warrantyStepProcessing.
  ///
  /// In vi, this message translates to:
  /// **'Đang xử lý'**
  String get warrantyStepProcessing;

  /// No description provided for @warrantyStepResolved.
  ///
  /// In vi, this message translates to:
  /// **'Đã khắc phục'**
  String get warrantyStepResolved;

  /// No description provided for @warrantyNoteSubmitted.
  ///
  /// In vi, this message translates to:
  /// **'Anh Hùng có 24 giờ để nhận. Nếu anh từ chối, VSTech Home Services chuyển cho thợ khác.'**
  String get warrantyNoteSubmitted;

  /// No description provided for @warrantyNoteProcessing.
  ///
  /// In vi, this message translates to:
  /// **'Anh Hùng sẽ đến trong khung giờ bạn chọn. Theo dõi và nhắn tin như một đơn thường.'**
  String get warrantyNoteProcessing;

  /// No description provided for @warrantyNoteResolved.
  ///
  /// In vi, this message translates to:
  /// **'Đã khắc phục và bạn đã xác nhận. Phiếu bảo hành vẫn còn hiệu lực đến 17/05.'**
  String get warrantyNoteResolved;

  /// No description provided for @warrantyBackToOrdersCta.
  ///
  /// In vi, this message translates to:
  /// **'Về Đơn của tôi'**
  String get warrantyBackToOrdersCta;

  /// No description provided for @workerWarrantyJobTitle.
  ///
  /// In vi, this message translates to:
  /// **'Việc bảo hành'**
  String get workerWarrantyJobTitle;

  /// No description provided for @workerWarrantyDeadline.
  ///
  /// In vi, this message translates to:
  /// **'Phản hồi trong 23:59:00'**
  String get workerWarrantyDeadline;

  /// No description provided for @workerWarrantyCustomerInfo.
  ///
  /// In vi, this message translates to:
  /// **'Nguyễn Thị Mai · Căn hộ Flora Novia, Thủ Đức'**
  String get workerWarrantyCustomerInfo;

  /// No description provided for @workerWarrantyNetIncome.
  ///
  /// In vi, this message translates to:
  /// **'Thu nhập thực nhận'**
  String get workerWarrantyNetIncome;

  /// No description provided for @workerWarrantyCustomerIssue.
  ///
  /// In vi, this message translates to:
  /// **'Máy lạnh chảy nước sau khi vệ sinh, cần kiểm tra lại đường ống thoát nước.'**
  String get workerWarrantyCustomerIssue;

  /// No description provided for @workerWarrantyCustomerIssueTitle.
  ///
  /// In vi, this message translates to:
  /// **'Sự cố khách hàng phản ánh'**
  String get workerWarrantyCustomerIssueTitle;

  /// No description provided for @workerWarrantyOriginalOrderTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin đơn gốc'**
  String get workerWarrantyOriginalOrderTitle;

  /// No description provided for @workerWarrantyOriginalCode.
  ///
  /// In vi, this message translates to:
  /// **'Đơn gốc: #HS20250318-0087'**
  String get workerWarrantyOriginalCode;

  /// No description provided for @workerWarrantyOriginalDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày làm: 18/03/2026'**
  String get workerWarrantyOriginalDate;

  /// No description provided for @workerWarrantyOriginalRating.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá: 5.0★ · \"Thợ làm rất nhiệt tình\"'**
  String get workerWarrantyOriginalRating;

  /// No description provided for @workerWarrantyBeforePhoto.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh trước khi làm'**
  String get workerWarrantyBeforePhoto;

  /// No description provided for @workerWarrantyAfterPhoto.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh sau khi làm'**
  String get workerWarrantyAfterPhoto;

  /// No description provided for @workerWarrantyDeclineCta.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối'**
  String get workerWarrantyDeclineCta;

  /// No description provided for @workerWarrantyAcceptCta.
  ///
  /// In vi, this message translates to:
  /// **'Nhận việc bảo hành'**
  String get workerWarrantyAcceptCta;

  /// No description provided for @workerWarrantyDeclineTitle.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối bảo hành'**
  String get workerWarrantyDeclineTitle;

  /// No description provided for @workerWarrantyPenaltyWarnTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cảnh báo trừ 120.000đ chi phí khắc phục'**
  String get workerWarrantyPenaltyWarnTitle;

  /// No description provided for @workerWarrantyPenaltyWarnBody.
  ///
  /// In vi, this message translates to:
  /// **'Đơn bảo hành sẽ được điều phối cho Thợ khác. Theo điều khoản đối tác, bạn sẽ bị khấu trừ 120.000đ chi phí làm lại trực tiếp từ ví.'**
  String get workerWarrantyPenaltyWarnBody;

  /// No description provided for @workerWarrantyReasonTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lý do từ chối bảo hành'**
  String get workerWarrantyReasonTitle;

  /// No description provided for @workerWarrantyReason1.
  ///
  /// In vi, this message translates to:
  /// **'Không đúng lỗi do mình'**
  String get workerWarrantyReason1;

  /// No description provided for @workerWarrantyReason2.
  ///
  /// In vi, this message translates to:
  /// **'Không sắp xếp được thời gian'**
  String get workerWarrantyReason2;

  /// No description provided for @workerWarrantyReason3.
  ///
  /// In vi, this message translates to:
  /// **'Cần linh kiện ngoài phạm vi'**
  String get workerWarrantyReason3;

  /// No description provided for @workerWarrantyReason4.
  ///
  /// In vi, this message translates to:
  /// **'Lý do khác'**
  String get workerWarrantyReason4;

  /// No description provided for @workerWarrantyPenaltyAck.
  ///
  /// In vi, this message translates to:
  /// **'Tôi hiểu 120.000đ sẽ bị trừ vào ví thu nhập.'**
  String get workerWarrantyPenaltyAck;

  /// No description provided for @workerWarrantyConfirmDeclineCta.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận từ chối'**
  String get workerWarrantyConfirmDeclineCta;

  /// No description provided for @workerWarrantyBackToJobCta.
  ///
  /// In vi, this message translates to:
  /// **'Quay lại xem việc'**
  String get workerWarrantyBackToJobCta;

  /// No description provided for @ordersWarrantyActiveChip.
  ///
  /// In vi, this message translates to:
  /// **'Còn bảo hành 22 ngày · đến 17/05'**
  String get ordersWarrantyActiveChip;

  /// No description provided for @ordersViewWarrantyCertCta.
  ///
  /// In vi, this message translates to:
  /// **'Xem phiếu bảo hành'**
  String get ordersViewWarrantyCertCta;

  /// No description provided for @ordersActiveWarrantyTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bảo hành: Vệ sinh máy lạnh'**
  String get ordersActiveWarrantyTitle;

  /// No description provided for @chatPrivacyBanner.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại của hai bên được ẩn'**
  String get chatPrivacyBanner;

  /// No description provided for @chatCallBack.
  ///
  /// In vi, this message translates to:
  /// **'Gọi lại'**
  String get chatCallBack;

  /// No description provided for @chatCurrentLocation.
  ///
  /// In vi, this message translates to:
  /// **'Vị trí hiện tại'**
  String get chatCurrentLocation;

  /// No description provided for @chatExtraCostBadge.
  ///
  /// In vi, this message translates to:
  /// **'ĐỀ XUẤT CHI PHÍ PHÁT SINH'**
  String get chatExtraCostBadge;

  /// No description provided for @chatExtraCostTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thay ron vòi sen'**
  String get chatExtraCostTitle;

  /// No description provided for @chatExtraCostDesc.
  ///
  /// In vi, this message translates to:
  /// **'Vật tư + công, ảnh đính kèm phía trên'**
  String get chatExtraCostDesc;

  /// No description provided for @chatExtraCostAmount.
  ///
  /// In vi, this message translates to:
  /// **'+45.000đ'**
  String get chatExtraCostAmount;

  /// No description provided for @chatApprove.
  ///
  /// In vi, this message translates to:
  /// **'Đồng ý'**
  String get chatApprove;

  /// No description provided for @chatDecline.
  ///
  /// In vi, this message translates to:
  /// **'Từ chối'**
  String get chatDecline;

  /// No description provided for @chatExtraCostApproved.
  ///
  /// In vi, this message translates to:
  /// **'Đã đồng ý · cộng vào hoá đơn khi nghiệm thu'**
  String get chatExtraCostApproved;

  /// No description provided for @chatExtraCostDeclined.
  ///
  /// In vi, this message translates to:
  /// **'Đã từ chối'**
  String get chatExtraCostDeclined;

  /// No description provided for @chatExtraCostPendingWorker.
  ///
  /// In vi, this message translates to:
  /// **'Đang chờ khách xác nhận'**
  String get chatExtraCostPendingWorker;

  /// No description provided for @chatMaskedPhoneNote.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại đã được ẩn để bảo vệ hai bên.'**
  String get chatMaskedPhoneNote;

  /// No description provided for @chatClosedNotice.
  ///
  /// In vi, this message translates to:
  /// **'Cuộc trò chuyện đã đóng 24 giờ sau khi hoàn tất đơn. Cần hỗ trợ, vui lòng liên hệ Trung tâm hỗ trợ.'**
  String get chatClosedNotice;

  /// No description provided for @chatInputHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tin nhắn…'**
  String get chatInputHint;

  /// No description provided for @chatSeen.
  ///
  /// In vi, this message translates to:
  /// **'Đã xem'**
  String get chatSeen;

  /// No description provided for @chatSent.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi'**
  String get chatSent;

  /// No description provided for @chatQuickWorker1.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đang đến'**
  String get chatQuickWorker1;

  /// No description provided for @chatQuickWorker2.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đã tới sảnh'**
  String get chatQuickWorker2;

  /// No description provided for @chatQuickWorker3.
  ///
  /// In vi, this message translates to:
  /// **'Tôi sắp xong'**
  String get chatQuickWorker3;

  /// No description provided for @chatQuickWorker4.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng mở cửa giúp tôi'**
  String get chatQuickWorker4;

  /// No description provided for @chatQuickCustomer1.
  ///
  /// In vi, this message translates to:
  /// **'Mình ở nhà rồi'**
  String get chatQuickCustomer1;

  /// No description provided for @chatQuickCustomer2.
  ///
  /// In vi, this message translates to:
  /// **'Gửi xe ở hầm B1'**
  String get chatQuickCustomer2;

  /// No description provided for @chatQuickCustomer3.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng gọi trước khi đến'**
  String get chatQuickCustomer3;

  /// No description provided for @chatQuickCustomer4.
  ///
  /// In vi, this message translates to:
  /// **'Cảm ơn anh'**
  String get chatQuickCustomer4;

  /// No description provided for @callRecordingNotice.
  ///
  /// In vi, this message translates to:
  /// **'Cuộc gọi được ghi âm để bảo vệ hai bên và hỗ trợ giải quyết khiếu nại'**
  String get callRecordingNotice;

  /// No description provided for @callConnecting.
  ///
  /// In vi, this message translates to:
  /// **'Đang kết nối…'**
  String get callConnecting;

  /// No description provided for @callIncoming.
  ///
  /// In vi, this message translates to:
  /// **'Cuộc gọi đến'**
  String get callIncoming;

  /// No description provided for @callMute.
  ///
  /// In vi, this message translates to:
  /// **'Tắt mic'**
  String get callMute;

  /// No description provided for @callSpeaker.
  ///
  /// In vi, this message translates to:
  /// **'Loa ngoài'**
  String get callSpeaker;

  /// No description provided for @callEnd.
  ///
  /// In vi, this message translates to:
  /// **'Kết thúc'**
  String get callEnd;

  /// No description provided for @callAccept.
  ///
  /// In vi, this message translates to:
  /// **'Nghe máy'**
  String get callAccept;

  /// No description provided for @callVoiceLog.
  ///
  /// In vi, this message translates to:
  /// **'Cuộc gọi thoại · {duration}'**
  String callVoiceLog(String duration);

  /// No description provided for @callMissedCustomer.
  ///
  /// In vi, this message translates to:
  /// **'Chị Mai đã không nghe máy'**
  String get callMissedCustomer;

  /// No description provided for @callMissedWorker.
  ///
  /// In vi, this message translates to:
  /// **'Cuộc gọi nhỡ từ anh Hùng'**
  String get callMissedWorker;

  /// No description provided for @devicesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ngôi nhà của bạn'**
  String get devicesTitle;

  /// No description provided for @devicesTabDevices.
  ///
  /// In vi, this message translates to:
  /// **'Thiết bị ({count})'**
  String devicesTabDevices(int count);

  /// No description provided for @devicesTabSchedule.
  ///
  /// In vi, this message translates to:
  /// **'Lịch bảo trì'**
  String get devicesTabSchedule;

  /// No description provided for @devicesAddDevice.
  ///
  /// In vi, this message translates to:
  /// **'Thêm thiết bị mới'**
  String get devicesAddDevice;

  /// No description provided for @devicesOverdueReminder.
  ///
  /// In vi, this message translates to:
  /// **'Nhắc bảo trì máy nước nóng'**
  String get devicesOverdueReminder;

  /// No description provided for @devicesOverdueDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ariston quá hạn từ 10/01. Nên súc rửa bình và thay thanh magie định kỳ để tránh rò rỉ điện.'**
  String get devicesOverdueDesc;

  /// No description provided for @devicesStatusGood.
  ///
  /// In vi, this message translates to:
  /// **'Hoạt động tốt'**
  String get devicesStatusGood;

  /// No description provided for @devicesStatusNeedsService.
  ///
  /// In vi, this message translates to:
  /// **'Cần bảo trì'**
  String get devicesStatusNeedsService;

  /// No description provided for @devicesLastService.
  ///
  /// In vi, this message translates to:
  /// **'Bảo trì lần cuối: {date}'**
  String devicesLastService(String date);

  /// No description provided for @devicesScheduleOverdueTag.
  ///
  /// In vi, this message translates to:
  /// **'CẦN ĐẶT LỊCH'**
  String get devicesScheduleOverdueTag;

  /// No description provided for @devicesScheduleUpcomingTag.
  ///
  /// In vi, this message translates to:
  /// **'SẮP ĐẾN HẠN'**
  String get devicesScheduleUpcomingTag;

  /// No description provided for @devicesScheduleFutureTag.
  ///
  /// In vi, this message translates to:
  /// **'CÒN {months} THÁNG'**
  String devicesScheduleFutureTag(int months);

  /// No description provided for @devicesScheduleOverdueMonths.
  ///
  /// In vi, this message translates to:
  /// **'Đã quá hạn {count} tháng · {brand}'**
  String devicesScheduleOverdueMonths(int count, String brand);

  /// No description provided for @devicesScheduleFrequency.
  ///
  /// In vi, this message translates to:
  /// **'{count} tháng/lần · {brand}'**
  String devicesScheduleFrequency(int count, String brand);

  /// No description provided for @devicesChangeAddress.
  ///
  /// In vi, this message translates to:
  /// **'Đổi địa chỉ'**
  String get devicesChangeAddress;

  /// No description provided for @devicesDefaultAddressLabel.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ mặc định'**
  String get devicesDefaultAddressLabel;

  /// No description provided for @aiAssistantTitle.
  ///
  /// In vi, this message translates to:
  /// **'Trợ lý AI HomeService'**
  String get aiAssistantTitle;

  /// No description provided for @aiAssistantOnlineStatus.
  ///
  /// In vi, this message translates to:
  /// **'Sẵn sàng hỗ trợ 24/7'**
  String get aiAssistantOnlineStatus;

  /// No description provided for @aiAssistantWelcome.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào Mai! Mình là trợ lý AI của HomeService. Mình có thể hỗ trợ bạn tìm kiếm dịch vụ, tư vấn báo giá hoặc hướng dẫn chăm sóc thiết bị tại nhà.'**
  String get aiAssistantWelcome;

  /// No description provided for @aiChipSuggestService.
  ///
  /// In vi, this message translates to:
  /// **'Gợi ý cho tôi dịch vụ phù hợp'**
  String get aiChipSuggestService;

  /// No description provided for @aiChipHouseCleaningCost.
  ///
  /// In vi, this message translates to:
  /// **'Chi phí dọn nhà là bao nhiêu?'**
  String get aiChipHouseCleaningCost;

  /// No description provided for @aiChipCleanAcAtHome.
  ///
  /// In vi, this message translates to:
  /// **'Cách vệ sinh máy lạnh tại nhà?'**
  String get aiChipCleanAcAtHome;

  /// No description provided for @aiChipBookElectrician.
  ///
  /// In vi, this message translates to:
  /// **'Tôi muốn đặt lịch sửa điện'**
  String get aiChipBookElectrician;

  /// No description provided for @aiChipWarrantyPolicy.
  ///
  /// In vi, this message translates to:
  /// **'Chính sách bảo hành thế nào?'**
  String get aiChipWarrantyPolicy;

  /// No description provided for @aiAssistantInputPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Hỏi trợ lý AI bất kỳ điều gì…'**
  String get aiAssistantInputPlaceholder;

  /// No description provided for @aiResponseHouseCleaningCost.
  ///
  /// In vi, this message translates to:
  /// **'Giá dọn dẹp nhà tiêu chuẩn từ 80.000đ/giờ (tối thiểu 2 giờ). Gói bao gồm lau dọn phòng khách, phòng ngủ, bếp và vệ sinh toilet.'**
  String get aiResponseHouseCleaningCost;

  /// No description provided for @aiResponseAcClean.
  ///
  /// In vi, this message translates to:
  /// **'Bạn nên rửa lưới lọc bụi 2 tuần/lần bằng nước ấm. Với dàn lạnh và cục nóng, nên đặt thợ chuyên nghiệp 3-6 tháng/lần để xịt rửa áp lực cao.'**
  String get aiResponseAcClean;

  /// No description provided for @aiResponseBookElectrician.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có thể đặt dịch vụ Sửa chữa điện nước ngay. Thợ được chứng chỉ và kiểm tra lý lịch sẽ có mặt sau 30 phút!'**
  String get aiResponseBookElectrician;

  /// No description provided for @aiResponseWarranty.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả dịch vụ đều có bảo hành từ 7 đến 30 ngày. Nếu không hài lòng hoặc lỗi tái phát, thợ sẽ quay lại xử lý miễn phí 100%.'**
  String get aiResponseWarranty;

  /// No description provided for @aiSuggestionsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Gợi ý thông minh cho bạn'**
  String get aiSuggestionsTitle;

  /// No description provided for @aiSuggestionsUrgentSection.
  ///
  /// In vi, this message translates to:
  /// **'Đề xuất ưu tiên cho ngôi nhà của bạn'**
  String get aiSuggestionsUrgentSection;

  /// No description provided for @aiSuggestionsHeaterTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bảo trì máy nước nóng Ariston'**
  String get aiSuggestionsHeaterTitle;

  /// No description provided for @aiSuggestionsHeaterDesc.
  ///
  /// In vi, this message translates to:
  /// **'Máy đã sử dụng 14 tháng chưa súc rửa bình. Đặt lịch vệ sinh và thay thanh magie để đảm bảo an toàn điện và tiết kiệm điện năng.'**
  String get aiSuggestionsHeaterDesc;

  /// No description provided for @aiSuggestionsBookNow.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lịch ngay · 250.000đ'**
  String get aiSuggestionsBookNow;

  /// No description provided for @aiSuggestionsOtherSection.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ định kỳ gợi ý'**
  String get aiSuggestionsOtherSection;

  /// No description provided for @aiSuggestionsAcTitle.
  ///
  /// In vi, this message translates to:
  /// **'Vệ sinh máy lạnh'**
  String get aiSuggestionsAcTitle;

  /// No description provided for @aiSuggestionsAcDesc.
  ///
  /// In vi, this message translates to:
  /// **'Nên vệ sinh định kỳ 3-6 tháng/lần để bảo vệ sức khỏe hệ hô hấp và tiết kiệm điện.'**
  String get aiSuggestionsAcDesc;

  /// No description provided for @aiSuggestionsLaundryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giặt sấy · Giặt rèm - Sofa'**
  String get aiSuggestionsLaundryTitle;

  /// No description provided for @aiSuggestionsLaundryDesc.
  ///
  /// In vi, this message translates to:
  /// **'Khử khuẩn và loại bỏ bụi mịn không gian sống, tạo cảm giác thư giãn.'**
  String get aiSuggestionsLaundryDesc;

  /// No description provided for @aiSuggestionsPestTitle.
  ///
  /// In vi, this message translates to:
  /// **'Diệt côn trùng định kỳ'**
  String get aiSuggestionsPestTitle;

  /// No description provided for @aiSuggestionsPestDesc.
  ///
  /// In vi, this message translates to:
  /// **'Bảo vệ sức khỏe cả gia đình khỏi muỗi, gián và côn trùng gây hại.'**
  String get aiSuggestionsPestDesc;

  /// No description provided for @profileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ cá nhân'**
  String get profileTitle;

  /// No description provided for @profileEditLink.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa'**
  String get profileEditLink;

  /// No description provided for @profileMenuPersonalInfo.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cá nhân'**
  String get profileMenuPersonalInfo;

  /// No description provided for @profileMenuAddresses.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ của tôi'**
  String get profileMenuAddresses;

  /// No description provided for @profileMenuFavourites.
  ///
  /// In vi, this message translates to:
  /// **'Thợ yêu thích'**
  String get profileMenuFavourites;

  /// No description provided for @profileMenuPayment.
  ///
  /// In vi, this message translates to:
  /// **'Phương thức thanh toán'**
  String get profileMenuPayment;

  /// No description provided for @profileMenuNotifications.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt thông báo'**
  String get profileMenuNotifications;

  /// No description provided for @profileMenuSettings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt & bảo mật'**
  String get profileMenuSettings;

  /// No description provided for @profileMenuComplaints.
  ///
  /// In vi, this message translates to:
  /// **'Khiếu nại của tôi'**
  String get profileMenuComplaints;

  /// No description provided for @editProfileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin cá nhân'**
  String get editProfileTitle;

  /// No description provided for @editProfileChangeAvatar.
  ///
  /// In vi, this message translates to:
  /// **'Đổi ảnh đại diện'**
  String get editProfileChangeAvatar;

  /// No description provided for @editProfileFullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get editProfileFullName;

  /// No description provided for @editProfilePhone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get editProfilePhone;

  /// No description provided for @editProfileEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get editProfileEmail;

  /// No description provided for @editProfileDob.
  ///
  /// In vi, this message translates to:
  /// **'Ngày sinh'**
  String get editProfileDob;

  /// No description provided for @editProfileOtpNotice.
  ///
  /// In vi, this message translates to:
  /// **'Cần xác thực OTP khi đổi số điện thoại'**
  String get editProfileOtpNotice;

  /// No description provided for @editProfileSavedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu thay đổi thông tin thành công'**
  String get editProfileSavedSuccess;

  /// No description provided for @editProfileSaveCta.
  ///
  /// In vi, this message translates to:
  /// **'Lưu thay đổi'**
  String get editProfileSaveCta;

  /// No description provided for @addressesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ của tôi'**
  String get addressesTitle;

  /// No description provided for @addressesAddNew.
  ///
  /// In vi, this message translates to:
  /// **'Thêm địa chỉ mới'**
  String get addressesAddNew;

  /// No description provided for @addressesDefaultBadge.
  ///
  /// In vi, this message translates to:
  /// **'MẶC ĐỊNH'**
  String get addressesDefaultBadge;

  /// No description provided for @addressesTagHome.
  ///
  /// In vi, this message translates to:
  /// **'NHÀ'**
  String get addressesTagHome;

  /// No description provided for @addressesTagWork.
  ///
  /// In vi, this message translates to:
  /// **'CÔNG TY'**
  String get addressesTagWork;

  /// No description provided for @addressesTagOther.
  ///
  /// In vi, this message translates to:
  /// **'KHÁC'**
  String get addressesTagOther;

  /// No description provided for @addressesEditAction.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get addressesEditAction;

  /// No description provided for @addressesSetDefaultAction.
  ///
  /// In vi, this message translates to:
  /// **'Đặt mặc định'**
  String get addressesSetDefaultAction;

  /// No description provided for @addressesDeleteAction.
  ///
  /// In vi, this message translates to:
  /// **'Xoá'**
  String get addressesDeleteAction;

  /// No description provided for @addressesDefaultCannotDelete.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ mặc định không xoá được'**
  String get addressesDefaultCannotDelete;

  /// No description provided for @addressesDeleteConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xoá địa chỉ này?'**
  String get addressesDeleteConfirm;

  /// No description provided for @addressEditTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm / Sửa địa chỉ'**
  String get addressEditTitle;

  /// No description provided for @addressEditLabelSection.
  ///
  /// In vi, this message translates to:
  /// **'Nhãn địa chỉ'**
  String get addressEditLabelSection;

  /// No description provided for @addressEditSearchPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm địa chỉ nhà bạn…'**
  String get addressEditSearchPlaceholder;

  /// No description provided for @addressEditPinNote.
  ///
  /// In vi, this message translates to:
  /// **'Ghim vị trí chính xác trên bản đồ'**
  String get addressEditPinNote;

  /// No description provided for @addressEditHouseType.
  ///
  /// In vi, this message translates to:
  /// **'Loại nhà ở'**
  String get addressEditHouseType;

  /// No description provided for @addressEditTownhouse.
  ///
  /// In vi, this message translates to:
  /// **'Nhà phố'**
  String get addressEditTownhouse;

  /// No description provided for @addressEditApartment.
  ///
  /// In vi, this message translates to:
  /// **'Chung cư'**
  String get addressEditApartment;

  /// No description provided for @addressEditFloor.
  ///
  /// In vi, this message translates to:
  /// **'Tầng số'**
  String get addressEditFloor;

  /// No description provided for @addressEditElevator.
  ///
  /// In vi, this message translates to:
  /// **'Thang máy'**
  String get addressEditElevator;

  /// No description provided for @addressEditHasElevator.
  ///
  /// In vi, this message translates to:
  /// **'Có thang máy'**
  String get addressEditHasElevator;

  /// No description provided for @addressEditNoElevator.
  ///
  /// In vi, this message translates to:
  /// **'Không thang máy'**
  String get addressEditNoElevator;

  /// No description provided for @addressEditAccessNote.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú vị trí (gửi xe, chuông cổng…)'**
  String get addressEditAccessNote;

  /// No description provided for @addressEditSetDefaultSwitch.
  ///
  /// In vi, this message translates to:
  /// **'Đặt làm địa chỉ mặc định'**
  String get addressEditSetDefaultSwitch;

  /// No description provided for @addressEditSaveCta.
  ///
  /// In vi, this message translates to:
  /// **'Lưu địa chỉ'**
  String get addressEditSaveCta;

  /// No description provided for @pmsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Phương thức thanh toán'**
  String get pmsTitle;

  /// No description provided for @pmsLinkWalletCta.
  ///
  /// In vi, this message translates to:
  /// **'Liên kết ví mới'**
  String get pmsLinkWalletCta;

  /// No description provided for @pmsDefaultLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ví mặc định khi thanh toán'**
  String get pmsDefaultLabel;

  /// No description provided for @pmsSetDefault.
  ///
  /// In vi, this message translates to:
  /// **'Đặt mặc định'**
  String get pmsSetDefault;

  /// No description provided for @pmsUnlink.
  ///
  /// In vi, this message translates to:
  /// **'Huỷ liên kết'**
  String get pmsUnlink;

  /// No description provided for @pmsUnlinkConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Huỷ liên kết ví này? Bạn có thể liên kết lại bất cứ lúc nào.'**
  String get pmsUnlinkConfirm;

  /// No description provided for @pmsSecurityNote.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin thanh toán được mã hoá và bảo vệ theo tiêu chuẩn bảo mật quốc tế PCI-DSS.'**
  String get pmsSecurityNote;

  /// No description provided for @linkWalletTitle.
  ///
  /// In vi, this message translates to:
  /// **'Liên kết ví điện tử'**
  String get linkWalletTitle;

  /// No description provided for @linkWalletSelectPrompt.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ví điện tử bạn muốn liên kết:'**
  String get linkWalletSelectPrompt;

  /// No description provided for @linkWalletStepConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận trên ứng dụng ví'**
  String get linkWalletStepConfirmTitle;

  /// No description provided for @linkWalletStepConfirmDesc.
  ///
  /// In vi, this message translates to:
  /// **'Ứng dụng ví đã mở. Vui lòng đăng nhập và cho phép HomeService trừ tiền tự động khi bạn đặt lịch.'**
  String get linkWalletStepConfirmDesc;

  /// No description provided for @linkWalletStepSuccessTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đã liên kết ví thành công!'**
  String get linkWalletStepSuccessTitle;

  /// No description provided for @linkWalletStepSuccessDesc.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại: 0901 ••• 567'**
  String get linkWalletStepSuccessDesc;

  /// No description provided for @linkWalletContinueCta.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get linkWalletContinueCta;

  /// No description provided for @linkWalletIHaveConfirmedCta.
  ///
  /// In vi, this message translates to:
  /// **'Tôi đã xác nhận'**
  String get linkWalletIHaveConfirmedCta;

  /// No description provided for @linkWalletBackToPmsCta.
  ///
  /// In vi, this message translates to:
  /// **'Về danh sách ví'**
  String get linkWalletBackToPmsCta;

  /// No description provided for @favsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thợ yêu thích'**
  String get favsTitle;

  /// No description provided for @favsEmpty.
  ///
  /// In vi, this message translates to:
  /// **'Bạn chưa lưu thợ yêu thích nào. Đánh giá 5 sao sau khi hoàn thành đơn để thêm thợ vào danh sách nhé!'**
  String get favsEmpty;

  /// No description provided for @favsRebookCta.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lại thợ này'**
  String get favsRebookCta;

  /// No description provided for @favsLastJob.
  ///
  /// In vi, this message translates to:
  /// **'Lần gần nhất: {job}'**
  String favsLastJob(String job);

  /// No description provided for @workerPreviewTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ thợ'**
  String get workerPreviewTitle;

  /// No description provided for @workerPreviewVerifiedPro.
  ///
  /// In vi, this message translates to:
  /// **'Kỹ thuật viên đã xác minh'**
  String get workerPreviewVerifiedPro;

  /// No description provided for @workerPreviewServices.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ chuyên môn'**
  String get workerPreviewServices;

  /// No description provided for @workerPreviewRecentReview.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá gần đây từ khách hàng'**
  String get workerPreviewRecentReview;

  /// No description provided for @workerPreviewBookCta.
  ///
  /// In vi, this message translates to:
  /// **'Đặt lịch với thợ này'**
  String get workerPreviewBookCta;

  /// No description provided for @settingsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt & Lịch sử'**
  String get settingsTitle;

  /// No description provided for @settingsTabSettings.
  ///
  /// In vi, this message translates to:
  /// **'Cài đặt'**
  String get settingsTabSettings;

  /// No description provided for @settingsTabHistory.
  ///
  /// In vi, this message translates to:
  /// **'Lịch sử đơn hàng'**
  String get settingsTabHistory;

  /// No description provided for @settingsLanguage.
  ///
  /// In vi, this message translates to:
  /// **'Ngôn ngữ'**
  String get settingsLanguage;

  /// No description provided for @settingsChangePassword.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu'**
  String get settingsChangePassword;

  /// No description provided for @settingsPaymentMethods.
  ///
  /// In vi, this message translates to:
  /// **'Phương thức thanh toán'**
  String get settingsPaymentMethods;

  /// No description provided for @settingsPaymentMethodsSub.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý thẻ, ví của bạn'**
  String get settingsPaymentMethodsSub;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In vi, this message translates to:
  /// **'Trung tâm trợ giúp'**
  String get settingsHelpCenter;

  /// No description provided for @settingsHelpCenterSub.
  ///
  /// In vi, this message translates to:
  /// **'Khiếu nại và hỗ trợ đơn hàng'**
  String get settingsHelpCenterSub;

  /// No description provided for @settingsAbout.
  ///
  /// In vi, this message translates to:
  /// **'Về ứng dụng'**
  String get settingsAbout;

  /// No description provided for @settingsAboutSub.
  ///
  /// In vi, this message translates to:
  /// **'Phiên bản 1.0.0'**
  String get settingsAboutSub;

  /// No description provided for @settingsAboutDialogTitle.
  ///
  /// In vi, this message translates to:
  /// **'VSTech Home Services v1.0.0'**
  String get settingsAboutDialogTitle;

  /// No description provided for @settingsAboutDialogBody.
  ///
  /// In vi, this message translates to:
  /// **'Bản phát hành chính thức Phase 1 MVP · V-STech. Toàn bộ quyền sở hữu thuộc về VSTech Home Services.'**
  String get settingsAboutDialogBody;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In vi, this message translates to:
  /// **'Xoá tài khoản'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsLogout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get settingsLogout;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất khỏi tài khoản?'**
  String get logoutDialogTitle;

  /// No description provided for @logoutDialogBody.
  ///
  /// In vi, this message translates to:
  /// **'Bạn sẽ cần đăng nhập lại bằng số điện thoại để tiếp tục đặt lịch và theo dõi dịch vụ.'**
  String get logoutDialogBody;

  /// No description provided for @logoutConfirmCta.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logoutConfirmCta;

  /// No description provided for @logoutCancelCta.
  ///
  /// In vi, this message translates to:
  /// **'Ở lại'**
  String get logoutCancelCta;

  /// No description provided for @changePasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordCurrent.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu hiện tại'**
  String get changePasswordCurrent;

  /// No description provided for @changePasswordNew.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu mới'**
  String get changePasswordNew;

  /// No description provided for @changePasswordConfirm.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu mới'**
  String get changePasswordConfirm;

  /// No description provided for @changePasswordRule.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải dài tối thiểu 8 ký tự, bao gồm cả chữ cái và chữ số.'**
  String get changePasswordRule;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã đổi mật khẩu thành công!'**
  String get changePasswordSuccess;

  /// No description provided for @changePasswordCta.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận đổi mật khẩu'**
  String get changePasswordCta;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xoá tài khoản'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountWarningTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hành động này không thể hoàn tác'**
  String get deleteAccountWarningTitle;

  /// No description provided for @deleteAccountWarningBody.
  ///
  /// In vi, this message translates to:
  /// **'Toàn bộ thông tin tài khoản và dữ liệu liên quan sẽ bị xoá vĩnh viễn khỏi hệ thống.'**
  String get deleteAccountWarningBody;

  /// No description provided for @deleteAccountItem1.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ cá nhân và số điện thoại'**
  String get deleteAccountItem1;

  /// No description provided for @deleteAccountItem2.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ đã lưu và ví điện tử liên kết'**
  String get deleteAccountItem2;

  /// No description provided for @deleteAccountItem3.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách thợ yêu thích và lịch sử trò chuyện'**
  String get deleteAccountItem3;

  /// No description provided for @deleteAccountItem4.
  ///
  /// In vi, this message translates to:
  /// **'Phiếu bảo hành còn hiệu lực'**
  String get deleteAccountItem4;

  /// No description provided for @deleteAccountReasonTitle.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng cho biết lý do bạn muốn xoá tài khoản:'**
  String get deleteAccountReasonTitle;

  /// No description provided for @deleteAccountReason1.
  ///
  /// In vi, this message translates to:
  /// **'Không còn nhu cầu sử dụng dịch vụ'**
  String get deleteAccountReason1;

  /// No description provided for @deleteAccountReason2.
  ///
  /// In vi, this message translates to:
  /// **'Lo ngại về quyền riêng tư và dữ liệu cá nhân'**
  String get deleteAccountReason2;

  /// No description provided for @deleteAccountReason3.
  ///
  /// In vi, this message translates to:
  /// **'Muốn tạo tài khoản mới'**
  String get deleteAccountReason3;

  /// No description provided for @deleteAccountReason4.
  ///
  /// In vi, this message translates to:
  /// **'Lý do khác'**
  String get deleteAccountReason4;

  /// No description provided for @deleteAccountConfirmCta.
  ///
  /// In vi, this message translates to:
  /// **'Xoá tài khoản · xác thực OTP'**
  String get deleteAccountConfirmCta;

  /// No description provided for @deleteAccountKeepCta.
  ///
  /// In vi, this message translates to:
  /// **'Giữ lại tài khoản'**
  String get deleteAccountKeepCta;

  /// No description provided for @wwalletTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ví thu nhập'**
  String get wwalletTitle;

  /// No description provided for @wwalletAvailableBalance.
  ///
  /// In vi, this message translates to:
  /// **'Số dư có thể rút'**
  String get wwalletAvailableBalance;

  /// No description provided for @wwalletTotalEarned.
  ///
  /// In vi, this message translates to:
  /// **'Tổng thu nhập đã về'**
  String get wwalletTotalEarned;

  /// No description provided for @wwalletWithdrawn.
  ///
  /// In vi, this message translates to:
  /// **'Đã rút / đang rút'**
  String get wwalletWithdrawn;

  /// No description provided for @wwalletDeductions.
  ///
  /// In vi, this message translates to:
  /// **'Khấu trừ'**
  String get wwalletDeductions;

  /// No description provided for @wwalletOnHold.
  ///
  /// In vi, this message translates to:
  /// **'Đang tạm giữ'**
  String get wwalletOnHold;

  /// No description provided for @wwalletOnHoldNotice.
  ///
  /// In vi, this message translates to:
  /// **'Đang tạm giữ (không tính vào số dư)'**
  String get wwalletOnHoldNotice;

  /// No description provided for @wwalletWithdrawCta.
  ///
  /// In vi, this message translates to:
  /// **'Rút về tài khoản'**
  String get wwalletWithdrawCta;

  /// No description provided for @wwalletTabAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get wwalletTabAll;

  /// No description provided for @wwalletTabIncome.
  ///
  /// In vi, this message translates to:
  /// **'Thu nhập'**
  String get wwalletTabIncome;

  /// No description provided for @wwalletTabWithdraw.
  ///
  /// In vi, this message translates to:
  /// **'Rút tiền'**
  String get wwalletTabWithdraw;

  /// No description provided for @wwalletTabHold.
  ///
  /// In vi, this message translates to:
  /// **'Tạm giữ'**
  String get wwalletTabHold;

  /// No description provided for @wwalletStatusCompleted.
  ///
  /// In vi, this message translates to:
  /// **'Thành công'**
  String get wwalletStatusCompleted;

  /// No description provided for @wwalletStatusProcessing.
  ///
  /// In vi, this message translates to:
  /// **'Đang xử lý'**
  String get wwalletStatusProcessing;

  /// No description provided for @wwalletStatusOnHold.
  ///
  /// In vi, this message translates to:
  /// **'Đang tạm giữ'**
  String get wwalletStatusOnHold;

  /// No description provided for @wtxTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết giao dịch'**
  String get wtxTitle;

  /// No description provided for @wtxBreakdownTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết số tiền'**
  String get wtxBreakdownTitle;

  /// No description provided for @wtxCustomerPaid.
  ///
  /// In vi, this message translates to:
  /// **'Khách trả'**
  String get wtxCustomerPaid;

  /// No description provided for @wtxExtraCost.
  ///
  /// In vi, this message translates to:
  /// **'Gồm chi phí phát sinh'**
  String get wtxExtraCost;

  /// No description provided for @wtxPlatformFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí nền tảng 15% trên giá dịch vụ'**
  String get wtxPlatformFee;

  /// No description provided for @wtxNetIncome.
  ///
  /// In vi, this message translates to:
  /// **'Thực nhận'**
  String get wtxNetIncome;

  /// No description provided for @wtxInfoTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thông tin giao dịch'**
  String get wtxInfoTitle;

  /// No description provided for @wtxTime.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get wtxTime;

  /// No description provided for @wtxTxId.
  ///
  /// In vi, this message translates to:
  /// **'Mã giao dịch'**
  String get wtxTxId;

  /// No description provided for @wtxRelatedOrder.
  ///
  /// In vi, this message translates to:
  /// **'Đơn liên quan'**
  String get wtxRelatedOrder;

  /// No description provided for @wtxTargetBank.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản nhận'**
  String get wtxTargetBank;

  /// No description provided for @wwdTitle.
  ///
  /// In vi, this message translates to:
  /// **'Rút về tài khoản'**
  String get wwdTitle;

  /// No description provided for @wwdAmountLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền rút'**
  String get wwdAmountLabel;

  /// No description provided for @wwdAmountHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập số tiền muốn rút'**
  String get wwdAmountHint;

  /// No description provided for @wwdQuickAll.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get wwdQuickAll;

  /// No description provided for @wwdCurrentBalance.
  ///
  /// In vi, this message translates to:
  /// **'Số dư hiện tại'**
  String get wwdCurrentBalance;

  /// No description provided for @wwdMinAmount.
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu mỗi lần'**
  String get wwdMinAmount;

  /// No description provided for @wwdFee.
  ///
  /// In vi, this message translates to:
  /// **'Phí rút'**
  String get wwdFee;

  /// No description provided for @wwdFeeFree.
  ///
  /// In vi, this message translates to:
  /// **'0đ (Miễn phí)'**
  String get wwdFeeFree;

  /// No description provided for @wwdBalanceAfter.
  ///
  /// In vi, this message translates to:
  /// **'Số dư sau khi rút'**
  String get wwdBalanceAfter;

  /// No description provided for @wwdBankCardTitle.
  ///
  /// In vi, this message translates to:
  /// **'Về tài khoản ngân hàng'**
  String get wwdBankCardTitle;

  /// No description provided for @wwdFromKyc.
  ///
  /// In vi, this message translates to:
  /// **'từ hồ sơ đối tác'**
  String get wwdFromKyc;

  /// No description provided for @wwdPhase1Notice.
  ///
  /// In vi, this message translates to:
  /// **'Giai đoạn 1: kế toán duyệt và chuyển khoản thủ công trong 24 giờ làm việc.'**
  String get wwdPhase1Notice;

  /// No description provided for @wwdContinueCta.
  ///
  /// In vi, this message translates to:
  /// **'Tiếp tục'**
  String get wwdContinueCta;

  /// No description provided for @wwdMinValidation.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền rút tối thiểu là 100.000đ'**
  String get wwdMinValidation;

  /// No description provided for @wwdMaxValidation.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền rút vượt quá số dư khả dụng'**
  String get wwdMaxValidation;

  /// No description provided for @wwdpinTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mã PIN ví'**
  String get wwdpinTitle;

  /// No description provided for @wwdpinSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận rút {amount} về ngân hàng'**
  String wwdpinSubtitle(String amount);

  /// No description provided for @wwdpinSecurityNote.
  ///
  /// In vi, this message translates to:
  /// **'Mã PIN gồm 6 chữ số bảo mật tài khoản của bạn.'**
  String get wwdpinSecurityNote;

  /// No description provided for @wwdstTitle.
  ///
  /// In vi, this message translates to:
  /// **'Yêu cầu rút tiền'**
  String get wwdstTitle;

  /// No description provided for @wwdstSuccessTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi yêu cầu rút tiền thành công!'**
  String get wwdstSuccessTitle;

  /// No description provided for @wwdstStep1.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi yêu cầu'**
  String get wwdstStep1;

  /// No description provided for @wwdstStep2.
  ///
  /// In vi, this message translates to:
  /// **'Chờ kế toán duyệt (trong 24 giờ)'**
  String get wwdstStep2;

  /// No description provided for @wwdstStep3.
  ///
  /// In vi, this message translates to:
  /// **'Đã chuyển khoản'**
  String get wwdstStep3;

  /// No description provided for @wwdstNote.
  ///
  /// In vi, this message translates to:
  /// **'Số tiền đã trừ khỏi số dư có thể rút. Nếu bị từ chối, tiền được hoàn lại ví.'**
  String get wwdstNote;

  /// No description provided for @wwdstBackWalletCta.
  ///
  /// In vi, this message translates to:
  /// **'Về ví thu nhập'**
  String get wwdstBackWalletCta;

  /// No description provided for @wcalTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lịch làm việc'**
  String get wcalTitle;

  /// No description provided for @wcalWeekRange.
  ///
  /// In vi, this message translates to:
  /// **'21/04 – 27/04'**
  String get wcalWeekRange;

  /// No description provided for @wcalSetAvailabilityCta.
  ///
  /// In vi, this message translates to:
  /// **'Giờ nhận việc & nghỉ đột xuất'**
  String get wcalSetAvailabilityCta;

  /// No description provided for @wcalJobsCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} việc'**
  String wcalJobsCount(int count);

  /// No description provided for @wcalDayOff.
  ///
  /// In vi, this message translates to:
  /// **'Nghỉ'**
  String get wcalDayOff;

  /// No description provided for @wcalToday.
  ///
  /// In vi, this message translates to:
  /// **'Hôm nay'**
  String get wcalToday;

  /// No description provided for @wcalNoJobs.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có việc. Anh đang nhận việc trong khung giờ đã cài đặt.'**
  String get wcalNoJobs;

  /// No description provided for @wcalDayOffRegular.
  ///
  /// In vi, this message translates to:
  /// **'Ngày nghỉ cố định.'**
  String get wcalDayOffRegular;

  /// No description provided for @wavailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giờ nhận việc & Nghỉ'**
  String get wavailTitle;

  /// No description provided for @wavailWeeklySchedule.
  ///
  /// In vi, this message translates to:
  /// **'Giờ nhận việc hàng tuần'**
  String get wavailWeeklySchedule;

  /// No description provided for @wavailTapToCycle.
  ///
  /// In vi, this message translates to:
  /// **'Chạm khung giờ để đổi (08:00–18:00 · 07:00–20:00 · 13:00–21:00)'**
  String get wavailTapToCycle;

  /// No description provided for @wavailTimeOffSection.
  ///
  /// In vi, this message translates to:
  /// **'Nghỉ đột xuất'**
  String get wavailTimeOffSection;

  /// No description provided for @wavailTimeOffDesc.
  ///
  /// In vi, this message translates to:
  /// **'Chọn các ngày bạn muốn tạm ngưng nhận việc mới.'**
  String get wavailTimeOffDesc;

  /// No description provided for @wavailTimeOffWarn.
  ///
  /// In vi, this message translates to:
  /// **'Ngày 26/04 có việc bảo hành lúc 08:00 đã nhận. Nghỉ đột xuất chỉ chặn việc mới; hãy nhắn khách hoặc hỗ trợ nếu cần đổi lịch.'**
  String get wavailTimeOffWarn;

  /// No description provided for @wavailSaveCta.
  ///
  /// In vi, this message translates to:
  /// **'Lưu lịch làm việc'**
  String get wavailSaveCta;

  /// No description provided for @wavailSavedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu cài đặt lịch làm việc thành công'**
  String get wavailSavedSuccess;

  /// No description provided for @wzoneTitle.
  ///
  /// In vi, this message translates to:
  /// **'Khu vực nhận việc'**
  String get wzoneTitle;

  /// No description provided for @wzoneDistrictsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quận / Huyện nhận việc'**
  String get wzoneDistrictsTitle;

  /// No description provided for @wzoneDistrictsNote.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ít nhất 1 quận/huyện bạn sẵn sàng nhận đơn.'**
  String get wzoneDistrictsNote;

  /// No description provided for @wzoneRadiusTitle.
  ///
  /// In vi, this message translates to:
  /// **'Bán kính từ vị trí hiện tại'**
  String get wzoneRadiusTitle;

  /// No description provided for @wzoneRadiusNote.
  ///
  /// In vi, this message translates to:
  /// **'Chỉ nhận việc trong các quận đã chọn và trong bán kính này. Mở rộng khu vực giúp nhận nhiều việc hơn.'**
  String get wzoneRadiusNote;

  /// No description provided for @wzoneSaveCta.
  ///
  /// In vi, this message translates to:
  /// **'Lưu khu vực nhận việc'**
  String get wzoneSaveCta;

  /// No description provided for @wzoneSavedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã lưu khu vực nhận việc thành công'**
  String get wzoneSavedSuccess;

  /// No description provided for @wskillTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kỹ năng & Chứng chỉ'**
  String get wskillTitle;

  /// No description provided for @wskillExpiredBannerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chứng chỉ làm việc trên cao đã hết hạn'**
  String get wskillExpiredBannerTitle;

  /// No description provided for @wskillExpiredBannerDesc.
  ///
  /// In vi, this message translates to:
  /// **'Đang ẩn các việc NGOÀI TRỜI và việc trên cao (dàn nóng máy lạnh, ban công, diệt côn trùng sân vườn). Tải bản mới để nhận lại.'**
  String get wskillExpiredBannerDesc;

  /// No description provided for @wskillPendingBannerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chứng chỉ mới đang chờ duyệt (trong 48 giờ)'**
  String get wskillPendingBannerTitle;

  /// No description provided for @wskillPendingBannerDesc.
  ///
  /// In vi, this message translates to:
  /// **'Việc NGOÀI TRỜI vẫn ẩn đến khi chứng chỉ được phê duyệt.'**
  String get wskillPendingBannerDesc;

  /// No description provided for @wskillServicesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Dịch vụ nhận làm'**
  String get wskillServicesTitle;

  /// No description provided for @wskillHiddenTag.
  ///
  /// In vi, this message translates to:
  /// **'ẨN'**
  String get wskillHiddenTag;

  /// No description provided for @wskillCertsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chứng chỉ hành nghề'**
  String get wskillCertsTitle;

  /// No description provided for @wskillCertExpired.
  ///
  /// In vi, this message translates to:
  /// **'HẾT HẠN'**
  String get wskillCertExpired;

  /// No description provided for @wskillCertApproved.
  ///
  /// In vi, this message translates to:
  /// **'ĐÃ DUYỆT'**
  String get wskillCertApproved;

  /// No description provided for @wskillCertPending.
  ///
  /// In vi, this message translates to:
  /// **'CHỜ DUYỆT'**
  String get wskillCertPending;

  /// No description provided for @wskillUploadCta.
  ///
  /// In vi, this message translates to:
  /// **'+ Tải chứng chỉ mới'**
  String get wskillUploadCta;

  /// No description provided for @wcertTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tải chứng chỉ mới'**
  String get wcertTitle;

  /// No description provided for @wcertTypeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Loại chứng chỉ'**
  String get wcertTypeTitle;

  /// No description provided for @wcertTypeHeight.
  ///
  /// In vi, this message translates to:
  /// **'An toàn làm việc trên cao'**
  String get wcertTypeHeight;

  /// No description provided for @wcertTypeAc.
  ///
  /// In vi, this message translates to:
  /// **'Kỹ thuật máy lạnh Daikin'**
  String get wcertTypeAc;

  /// No description provided for @wcertTypeOther.
  ///
  /// In vi, this message translates to:
  /// **'Chứng chỉ chuyên môn khác'**
  String get wcertTypeOther;

  /// No description provided for @wcertPhotoTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh chụp chứng chỉ'**
  String get wcertPhotoTitle;

  /// No description provided for @wcertPhotoTapToUpload.
  ///
  /// In vi, this message translates to:
  /// **'+ Chụp mặt trước chứng chỉ'**
  String get wcertPhotoTapToUpload;

  /// No description provided for @wcertPhotoAttached.
  ///
  /// In vi, this message translates to:
  /// **'Đã đính kèm ảnh · Chạm để đổi'**
  String get wcertPhotoAttached;

  /// No description provided for @wcertExpiryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Ngày hết hạn'**
  String get wcertExpiryTitle;

  /// No description provided for @wcertSubmitCta.
  ///
  /// In vi, this message translates to:
  /// **'Gửi duyệt chứng chỉ'**
  String get wcertSubmitCta;

  /// No description provided for @wcertSubmittedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã gửi chứng chỉ xét duyệt. Kết quả sẽ có trong vòng 48 giờ.'**
  String get wcertSubmittedSuccess;

  /// No description provided for @wperfTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hiệu suất hoạt động'**
  String get wperfTitle;

  /// No description provided for @wperfRatingSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'128 đánh giá · 30 ngày gần nhất'**
  String get wperfRatingSubtitle;

  /// No description provided for @wperfAcceptRate.
  ///
  /// In vi, this message translates to:
  /// **'Tỉ lệ nhận việc'**
  String get wperfAcceptRate;

  /// No description provided for @wperfAcceptDesc.
  ///
  /// In vi, this message translates to:
  /// **'Số việc anh nhận trên số việc được mời. Mục tiêu từ 90%.'**
  String get wperfAcceptDesc;

  /// No description provided for @wperfCompRate.
  ///
  /// In vi, this message translates to:
  /// **'Tỉ lệ hoàn thành'**
  String get wperfCompRate;

  /// No description provided for @wperfCompDesc.
  ///
  /// In vi, this message translates to:
  /// **'Việc đã nhận và làm xong, không huỷ giữa chừng. Mục tiêu từ 95%.'**
  String get wperfCompDesc;

  /// No description provided for @wperfOnTimeRate.
  ///
  /// In vi, this message translates to:
  /// **'Check-in đúng giờ'**
  String get wperfOnTimeRate;

  /// No description provided for @wperfOnTimeDesc.
  ///
  /// In vi, this message translates to:
  /// **'Check-in trước hoặc đúng giờ hẹn. Mục tiêu từ 90%.'**
  String get wperfOnTimeDesc;

  /// No description provided for @wperfWarrantyRate.
  ///
  /// In vi, this message translates to:
  /// **'Tỉ lệ bảo hành'**
  String get wperfWarrantyRate;

  /// No description provided for @wperfWarrantyDesc.
  ///
  /// In vi, this message translates to:
  /// **'Việc khách phải yêu cầu bảo hành. Càng thấp càng tốt, dưới 5%.'**
  String get wperfWarrantyDesc;

  /// No description provided for @wperfBadgesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Huy hiệu đạt được'**
  String get wperfBadgesTitle;

  /// No description provided for @wperfBadgePunctual.
  ///
  /// In vi, this message translates to:
  /// **'Đúng giờ'**
  String get wperfBadgePunctual;

  /// No description provided for @wperfBadgePunctualDesc.
  ///
  /// In vi, this message translates to:
  /// **'30 ngày check-in đúng giờ'**
  String get wperfBadgePunctualDesc;

  /// No description provided for @wperfBadge100.
  ///
  /// In vi, this message translates to:
  /// **'100 việc'**
  String get wperfBadge100;

  /// No description provided for @wperfBadge100Desc.
  ///
  /// In vi, this message translates to:
  /// **'Đã hoàn thành 128 việc'**
  String get wperfBadge100Desc;

  /// No description provided for @wperfBadgeFav.
  ///
  /// In vi, this message translates to:
  /// **'Khách yêu thích'**
  String get wperfBadgeFav;

  /// No description provided for @wperfBadgeFavDesc.
  ///
  /// In vi, this message translates to:
  /// **'Được lưu bởi 24 khách'**
  String get wperfBadgeFavDesc;

  /// No description provided for @wperfBadgeNoComplaint.
  ///
  /// In vi, this message translates to:
  /// **'Không khiếu nại'**
  String get wperfBadgeNoComplaint;

  /// No description provided for @wperfBadgeNoComplaintDesc.
  ///
  /// In vi, this message translates to:
  /// **'Cần 30 ngày không khiếu nại'**
  String get wperfBadgeNoComplaintDesc;

  /// No description provided for @wprofileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ sơ đối tác'**
  String get wprofileTitle;

  /// No description provided for @wprofileWorkerId.
  ///
  /// In vi, this message translates to:
  /// **'Mã đối tác: {id}'**
  String wprofileWorkerId(String id);

  /// No description provided for @wprofileMenuSkills.
  ///
  /// In vi, this message translates to:
  /// **'Kỹ năng & chứng chỉ'**
  String get wprofileMenuSkills;

  /// No description provided for @wprofileMenuZone.
  ///
  /// In vi, this message translates to:
  /// **'Khu vực nhận việc'**
  String get wprofileMenuZone;

  /// No description provided for @wprofileMenuSchedule.
  ///
  /// In vi, this message translates to:
  /// **'Lịch làm việc'**
  String get wprofileMenuSchedule;

  /// No description provided for @wprofileMenuPerf.
  ///
  /// In vi, this message translates to:
  /// **'Hiệu suất hoạt động'**
  String get wprofileMenuPerf;

  /// No description provided for @wprofileMenuPayout.
  ///
  /// In vi, this message translates to:
  /// **'Tài khoản nhận tiền'**
  String get wprofileMenuPayout;

  /// No description provided for @wprofileLogoutCta.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất tài khoản Thợ'**
  String get wprofileLogoutCta;

  /// No description provided for @wprofileLogoutDialogTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất khỏi tài khoản Thợ?'**
  String get wprofileLogoutDialogTitle;

  /// No description provided for @wprofileLogoutDialogBody.
  ///
  /// In vi, this message translates to:
  /// **'Bạn sẽ không nhận được thông báo cuốc việc mới cho đến khi đăng nhập lại.'**
  String get wprofileLogoutDialogBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
