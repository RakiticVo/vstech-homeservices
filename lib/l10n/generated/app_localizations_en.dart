// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'HomeService';

  @override
  String get appTagline => 'Better homes every day';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get startNow => 'Get Started';

  @override
  String get continueText => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get done => 'Done';

  @override
  String get close => 'Close';

  @override
  String get edit => 'Edit';

  @override
  String get langVi => 'Tiếng Việt';

  @override
  String get langEn => 'English';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get splashLoading => 'Starting...';

  @override
  String get ob1Title => 'Clean & Tidy Home\nHealthier Living';

  @override
  String get ob1Desc =>
      'Professional cleaning services keeping your living spaces fresh and comfortable.';

  @override
  String get ob2Title => 'Verified Experts\nAbsolute Peace of Mind';

  @override
  String get ob2Desc =>
      'Well-trained technicians with certified skills and clear background checks.';

  @override
  String get ob3Title => '3-Step Booking\nTransparent Pricing';

  @override
  String get ob3Desc =>
      'Select service, pick time, and confirm. All-inclusive quotes with no surprises.';

  @override
  String get ob4Title => 'Smart AI Assistant\nDedicated Advice';

  @override
  String get ob4Desc =>
      'Instant AI diagnosis, recommending tailored repairs and accurate appointments.';

  @override
  String get introTitle => 'Lighter Chores\nBrighter Living';

  @override
  String get introSubtitle =>
      'Vietnam\'s premier dedicated and trusted household service ecosystem';

  @override
  String get value1Title => '100% Transparent';

  @override
  String get value1Desc =>
      'Clear itemized pricing before technicians arrive, no hidden markups.';

  @override
  String get value2Title => 'Auto Warranty';

  @override
  String get value2Desc =>
      '0đ warranty after service, committed to lasting companionship with your family.';

  @override
  String get value3Title => 'Rapid Dispatch';

  @override
  String get value3Desc =>
      'Punctual arrival, fast execution, and thoughtful care.';

  @override
  String get introCta => 'Get Started Now';

  @override
  String get roleGatewayTitle => 'Welcome to\nHomeService';

  @override
  String get roleGatewaySubtitle => 'Please choose your role to continue';

  @override
  String get roleCustomerTitle => 'I am a Customer';

  @override
  String get roleCustomerDesc =>
      'Book repair, maintenance, and care services for your beloved home.';

  @override
  String get roleCustomerAction => 'Find Services';

  @override
  String get roleWorkerTitle => 'I am a Service Pro';

  @override
  String get roleWorkerDesc =>
      'Receive nearby jobs promptly, boost earnings, and control your work schedule.';

  @override
  String get roleWorkerAction => 'Start Taking Jobs';

  @override
  String get switchRoleNotice =>
      'You can easily switch roles anytime within the app.';

  @override
  String get authRoleCustomer => 'Customer';

  @override
  String get authRoleWorker => 'Service Pro';

  @override
  String get authSwitchRole => 'Switch role';

  @override
  String get loginTitle => 'Sign In';

  @override
  String get loginWelcome => 'Welcome back!';

  @override
  String get loginPhoneOrEmailLabel => 'Phone number or Email';

  @override
  String get loginPhoneOrEmailHint => '0901 234 567 or name@email.com';

  @override
  String get loginPhoneWorkerLabel => 'Registered Phone Number';

  @override
  String get loginPhoneWorkerHint => '0912 345 678';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginForgotPassword => 'Forgot password?';

  @override
  String get loginCta => 'Sign In';

  @override
  String get loginOrSocialDivider => 'Or continue with';

  @override
  String get loginGoogle => 'Continue with Google';

  @override
  String get loginApple => 'Continue with Apple';

  @override
  String get loginFacebook => 'Continue with Facebook';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegisterNow => 'Sign up now';

  @override
  String get registerTitle => 'Create New Account';

  @override
  String get registerSubtitle =>
      'Quick registration to experience our services';

  @override
  String get registerFullNameLabel => 'Full Name';

  @override
  String get registerFullNameHint => 'Nguyen Van A';

  @override
  String get registerPhoneLabel => 'Phone Number';

  @override
  String get registerPhoneHint => '0901 234 567';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerPasswordHint => 'At least 6 characters';

  @override
  String get registerConfirmPasswordLabel => 'Confirm Password';

  @override
  String get registerConfirmPasswordHint => 'Re-enter your password';

  @override
  String get registerTermsAgreement => 'I agree with the';

  @override
  String get registerTermsLink => 'Terms of Service';

  @override
  String get registerAndText => 'and';

  @override
  String get registerPrivacyLink => 'Privacy Policy';

  @override
  String get registerCta => 'Sign Up';

  @override
  String get registerAlreadyHaveAccount => 'Already have an account?';

  @override
  String get registerLoginNow => 'Sign in now';

  @override
  String get otpTitle => 'OTP Verification';

  @override
  String get otpSubtitle => 'A 6-digit verification code has been sent to';

  @override
  String get otpQuickFillLabel => 'From SMS: 123456';

  @override
  String otpResendCountdown(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get otpResendAction => 'Resend OTP Code';

  @override
  String get otpCta => 'Verify Now';

  @override
  String get otpInvalidCode => 'Invalid OTP code. Please try again!';

  @override
  String get otpVerifySuccess => 'Verification successful!';

  @override
  String get forgotPasswordTitle => 'Reset Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your registered phone number to receive an OTP code for resetting your password';

  @override
  String get forgotPasswordPhoneLabel => 'Phone Number';

  @override
  String get forgotPasswordPhoneHint => '0901 234 567';

  @override
  String get forgotPasswordCta => 'Send Verification Code';

  @override
  String get forgotPasswordBackToLogin => 'Back to Sign In';

  @override
  String get errorFieldRequired => 'This field is required';

  @override
  String get errorInvalidPhone => 'Invalid phone number';

  @override
  String get errorPasswordTooShort => 'Password must be at least 6 characters';

  @override
  String get errorPasswordNotMatch => 'Passwords do not match';

  @override
  String get errorMustAgreeTerms => 'Please agree to the Terms of Service';

  @override
  String get homeGreeting => 'Hello,';

  @override
  String get homeGreetingSubtitle => 'What does your home need today?';

  @override
  String get homeDefaultAddress => 'Sunrise City Apt, Dist. 7';

  @override
  String get homeSearchPlaceholder => 'Search services: air-con, cleaning...';

  @override
  String get svcCleanTitle => 'Home\nCleaning';

  @override
  String get svcPlumbTitle => 'Electrical &\nPlumbing';

  @override
  String get svcAcTitle => 'Air-con &\nWasher';

  @override
  String get svcLaundryTitle => 'Laundry &\nCurtains';

  @override
  String get svcMaidTitle => 'Hourly\nMaid';

  @override
  String get svcPestTitle => 'Pest\nControl';

  @override
  String get svcInstallTitle => 'Handyman &\nAssembly';

  @override
  String get svcApplianceTitle => 'Appliance\nRepair';

  @override
  String get homeSectionCategories => 'Essential Services';

  @override
  String get homeSectionSeeAll => 'See all';

  @override
  String get homeSectionOffers => 'Special Offers';

  @override
  String get homeSectionDevices => 'Your Home & Devices';

  @override
  String get homeDeviceSubtitle => 'Track status & maintenance schedule';

  @override
  String get homeViewSchedule => 'View Schedule';

  @override
  String get offerTag15 => '15% Off';

  @override
  String get offerTagFast => 'In 20 mins';

  @override
  String startingFrom(String price) {
    return 'From $price';
  }

  @override
  String get cleanServiceDesc =>
      'Comprehensive apartment, living room, bedroom, and kitchen deep cleaning.';

  @override
  String get acServiceDesc =>
      'Air conditioning cleaning, gas recharge, and electrical safety inspection.';

  @override
  String get plumbServiceDesc =>
      'Leak repairs, pipe unblocking, and genuine hardware replacements.';

  @override
  String get deviceDaikinAc => 'Daikin Inverter AC 1.5 HP';

  @override
  String get deviceSamsungFridge => 'Samsung Twin Cooling Refrigerator';

  @override
  String get deviceStatusGood => 'Running well';

  @override
  String get deviceStatusMaintenance => 'Needs service';

  @override
  String deviceLastService(String date) {
    return 'Last serviced: $date';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navOrders => 'Orders';

  @override
  String get navAi => 'AI Assist';

  @override
  String get navNotifications => 'Alerts';

  @override
  String get navAccount => 'Account';

  @override
  String get categoriesTitle => 'All Services';

  @override
  String get categoriesFilterAll => 'All';

  @override
  String get categoriesFilterClean => 'Cleaning';

  @override
  String get categoriesFilterElectric => 'Cooling';

  @override
  String get categoriesFilterPlumb => 'Plumbing';

  @override
  String get categoriesFilterRepair => 'Repair';

  @override
  String get serviceDetailBookCta => 'Book Now';

  @override
  String get serviceIncluded => 'Service package includes';

  @override
  String get serviceWarrantyNotice => '30-day 0đ warranty included';

  @override
  String get serviceDuration => 'Estimated time: 60 - 90 mins';

  @override
  String ratingReviews(String rating, int count) {
    return '$rating ($count reviews)';
  }

  @override
  String workerGreeting(String name) {
    return 'Hello $name,';
  }

  @override
  String get workerGreetingSubtitle => 'Ready to take jobs today?';

  @override
  String get workerOnline => 'Online';

  @override
  String get workerOffline => 'Offline';

  @override
  String get workerTodayEarnings => 'Today\'s Earnings';

  @override
  String get workerCompletedJobs => 'Completed';

  @override
  String get workerRating => 'Rating';

  @override
  String get workerAcceptRate => 'Accept Rate';

  @override
  String get workerNetEarnings => 'Net to Wallet';

  @override
  String get workerNewJobRequest => 'New Job Request';

  @override
  String get workerArriveIn20Min => 'Arrive in 20 mins';

  @override
  String get workerViewAndAccept => 'View & Accept';

  @override
  String get workerDeclineJob => 'Decline';

  @override
  String get workerTodaySchedule => 'Today\'s Schedule';

  @override
  String get workerUpcoming => 'Upcoming';

  @override
  String get workerDone => 'Done';

  @override
  String get workerNavJobs => 'Jobs';

  @override
  String get workerNavSchedule => 'Schedule';

  @override
  String get workerNavWallet => 'Wallet';

  @override
  String get workerNavProfile => 'Profile';

  @override
  String get jobDetailTitle => 'Job Request Details';

  @override
  String get jobCustomerName => 'Customer';

  @override
  String get jobCustomerAddress => 'Work Address';

  @override
  String jobDistance(String dist) {
    return 'Distance: $dist';
  }

  @override
  String jobEstimatedTime(String time) {
    return 'Est. Duration: $time';
  }

  @override
  String get jobPriceBreakdown => 'Transparent Earnings Breakdown';

  @override
  String get jobLabourFee => 'Flat Labour Fee';

  @override
  String get jobSiteSurcharge => 'Site Surcharge';

  @override
  String get jobPlatformFee => 'Platform Fee (15%)';

  @override
  String get jobAcceptCta => 'Accept Job Now';

  @override
  String get jobAcceptedSuccess =>
      'Job accepted successfully! Please prepare to travel';

  @override
  String get kycTitle => 'Partner Worker Registration';

  @override
  String kycStepProgress(int step) {
    return 'Step $step/6';
  }

  @override
  String get kycStep2Title => 'Personal Info & Work Area';

  @override
  String get kycStep2Desc =>
      'Provide basic info and select the districts you are ready to service.';

  @override
  String get kycDistrictSelect => 'Service Area (Select multiple)';

  @override
  String get kycDistrictQ1 => 'District 1';

  @override
  String get kycDistrictQ2 => 'District 2 (Thu Duc City)';

  @override
  String get kycDistrictQ7 => 'District 7';

  @override
  String get kycDistrictBinhThanh => 'Binh Thanh';

  @override
  String get kycDistrictPhuNhuan => 'Phu Nhuan';

  @override
  String get kycStep3Title => 'National ID Verification';

  @override
  String get kycStep3Desc =>
      'Capture clear front and back photos of your chip ID. Avoid glare or cropped edges.';

  @override
  String get kycIdFront => 'ID Card (Front)';

  @override
  String get kycIdBack => 'ID Card (Back)';

  @override
  String get kycCaptured => 'Captured';

  @override
  String get kycTapToCapture => 'Tap to capture';

  @override
  String get kycStep4Title => 'Portrait Selfie Photo';

  @override
  String get kycStep4Desc =>
      'Look directly at the camera, ensure good lighting, no sunglasses or face masks.';

  @override
  String get kycTakeSelfie => 'Take Facial Photo';

  @override
  String get kycStep5Title => 'Expertise & Certificates';

  @override
  String get kycStep5Desc =>
      'Air Conditioning and Height Installation require mandatory Safety Certificates.';

  @override
  String get kycCertUpload => 'Occupational Safety Certificate';

  @override
  String get kycCertUploaded => 'Certificate uploaded';

  @override
  String get kycStep6Title => 'Payout Bank Account';

  @override
  String get kycStep6Desc =>
      'Account holder name must match 100% with your National ID card.';

  @override
  String get kycBankName => 'Bank Name';

  @override
  String get kycBankHint => 'Vietcombank, MB Bank, Techcombank...';

  @override
  String get kycAccountNumber => 'Account Number';

  @override
  String get kycAccountNumberHint => 'Enter bank account number';

  @override
  String get kycAccountHolder => 'Account Holder Name';

  @override
  String get kycAccountHolderHint => 'TRAN VAN HUNG';

  @override
  String get kycSubmitCta => 'Submit Application';

  @override
  String get kycStatusTitle => 'Application Status';

  @override
  String get kycPendingTitle => 'Application Under Review';

  @override
  String get kycPendingDesc =>
      'VSTech team is reviewing your documents. Results will be ready within 24 working hours.';

  @override
  String get kycNeedsInfoTitle => 'Action Required';

  @override
  String get kycNeedsInfoDesc =>
      'The back photo of your ID card has glare obscuring numbers. Please re-upload a clear photo.';

  @override
  String get kycReuploadId => 'Re-upload ID Photo';

  @override
  String get kycApprovedTitle => 'Application Approved! 🎉';

  @override
  String get kycApprovedDesc =>
      'Congratulations Mr. Hung, you are officially a VSTech Partner Worker.';

  @override
  String get kycStartJobsCta => 'Start Taking Jobs';

  @override
  String get jobNetEarningsDesc =>
      'Credited directly to wallet upon completion';

  @override
  String get jobSampleCleaningTitle => '70m² Apartment Cleaning';

  @override
  String get jobSampleCustomerName => 'Nguyen Thi Thu Thao';

  @override
  String get jobSampleCustomerAddress =>
      'Apt B12.04, Masteri Thao Dien, 159 Ha Noi Highway, Thao Dien, Thu Duc City';

  @override
  String get jobSampleSchedule1Service => 'Inverter Air Conditioner Cleaning';

  @override
  String get jobSampleSchedule1Customer => 'Ms. Lan • Thao Dien, Dist. 2';

  @override
  String get jobSampleSchedule2Service => 'Water Pipe Leak Repair';

  @override
  String get jobSampleSchedule2Customer => 'Mr. Minh • Binh An, Dist. 2';

  @override
  String get workerJobsCompletedRatio => '2/3 jobs';

  @override
  String get kycStatusPendingChip => 'Pending';

  @override
  String get kycStatusNeedsChip => 'Needs Info';

  @override
  String get kycStatusApprovedChip => 'Approved';

  @override
  String get bookingTitle => 'Book Service';

  @override
  String bookingStepProgress(int step, String name) {
    return 'Step $step/3: $name';
  }

  @override
  String get bookingStep1Title => 'Select Package & Add-ons';

  @override
  String get bookingStep2Title => 'Schedule & Address';

  @override
  String get bookingStep3Title => 'Review & Confirm';

  @override
  String get bookingSelectScope => 'Apartment Scope / Area';

  @override
  String get bookingScopeSmall => 'Apartment under 70m²';

  @override
  String get bookingScopeSmallDesc =>
      '1 - 2 bedrooms, 1 bathroom • Est. ~60 - 90 mins';

  @override
  String get bookingScopeMedium => 'Apartment 70 - 100m²';

  @override
  String get bookingScopeMediumDesc =>
      '2 - 3 bedrooms, 2 bathrooms • Est. ~120 mins';

  @override
  String get bookingScopeLarge => 'Apartment over 100m²';

  @override
  String get bookingScopeLargeDesc => '3+ bedrooms, penthouse • Est. ~180 mins';

  @override
  String get bookingAddonsTitle => 'Additional Services (Optional)';

  @override
  String get bookingAddonTrash => 'Carry trash downstairs';

  @override
  String get bookingAddonTrashDesc =>
      'Sort and take trash down to building garbage area';

  @override
  String get bookingAddonDisinfect => 'Nano Silver Surface Disinfection';

  @override
  String get bookingAddonDisinfectDesc =>
      'Kills 99.9% of bacteria on tables, door knobs, kitchen';

  @override
  String get bookingAddonGlass => 'Balcony Exterior Glass Cleaning';

  @override
  String get bookingAddonGlassDesc =>
      'Specialized squeegee & anti-dust cleaning solution';

  @override
  String get bookingEstimatedPreview => 'Est. Total Preview';

  @override
  String get bookingContinueToSchedule => 'Continue: Select Date & Time';

  @override
  String get bookingScheduleDate => 'Service Date';

  @override
  String get bookingScheduleToday => 'Today';

  @override
  String get bookingScheduleTomorrow => 'Tomorrow';

  @override
  String get bookingScheduleTimeSlot => 'Arrival Time Slot';

  @override
  String get bookingWorkAddress => 'Service Address';

  @override
  String get bookingChangeAddress => 'Change Address';

  @override
  String get bookingPremisesType => 'Premises Context (Transparent Surcharge)';

  @override
  String get bookingPremisesGround => 'Landed House / Street Front';

  @override
  String get bookingPremisesGroundSurcharge => '+0đ';

  @override
  String get bookingPremisesElevator => 'Apartment with Elevator';

  @override
  String get bookingPremisesElevatorSurcharge => '+20,000đ';

  @override
  String get bookingPremisesStairs => 'Apartment via Stairs (High Floor)';

  @override
  String get bookingPremisesStairsSurcharge => '+50,000đ';

  @override
  String get bookingNotesLabel => 'Notes for Worker';

  @override
  String get bookingNotesHint =>
      'E.g. Call before arrival, park at basement B2...';

  @override
  String get bookingAttachPhotos => 'On-site Photos (Optional, max 5)';

  @override
  String bookingPhotoAdded(int count) {
    return '$count/5 photos';
  }

  @override
  String get bookingContinueToConfirm => 'Continue: Confirm Booking';

  @override
  String get bookingOrderSummary => 'Itemized Cost Breakdown';

  @override
  String get bookingBaseLabourFee => 'Basic Labour Package';

  @override
  String get bookingAddonsFee => 'Additional Services (Add-on)';

  @override
  String get bookingPremisesFee => 'Premises Surcharge';

  @override
  String get bookingDiscountFee => 'Voucher Discount';

  @override
  String get bookingTotalEstimated => 'Total Estimated Payment';

  @override
  String get bookingVoucherLabel => 'Promo Code (Voucher)';

  @override
  String get bookingVoucherHint => 'Enter promo code (e.g. NHAMOICHI15)';

  @override
  String get bookingVoucherApply => 'Apply';

  @override
  String get bookingVoucherApplied => 'Applied 15% discount voucher';

  @override
  String get bookingPaymentMethod => 'Payment Method';

  @override
  String get bookingPaymentVietQR => 'VietQR Bank Transfer';

  @override
  String get bookingPaymentVietQRDesc => 'Instant 24/7 bank QR code scan';

  @override
  String get bookingPaymentVnPay => 'ATM Card / E-Wallet (VNPay)';

  @override
  String get bookingPaymentVnPayDesc =>
      'Domestic & international Visa/Mastercard';

  @override
  String get bookingPaymentCash => 'Cash after Completion';

  @override
  String get bookingPaymentCashDesc =>
      'Pay directly to worker after final inspection';

  @override
  String get bookingPayAfterInspectNotice =>
      'Eco-Clean Guarantee: You only pay after directly inspecting and approving the completed work.';

  @override
  String get bookingWarranty30DaysBadge => 'Automatic 0đ warranty for 30 days';

  @override
  String bookingConfirmCta(String price) {
    return 'Confirm Booking · $price';
  }

  @override
  String get dispatchRadarTitle => 'Finding Partner Worker';

  @override
  String get dispatchRadarScanning =>
      'Scanning partner workers within 2.5 km...';

  @override
  String get dispatchRadarSentToWorkers =>
      'Dispatched request to 3 nearest partner workers...';

  @override
  String get dispatchRadarFoundWorker => 'Matched with Partner Worker!';

  @override
  String get dispatchRadarWorkerAssigned =>
      'Nguyen Van Hung has accepted and is preparing to travel';

  @override
  String get dispatchRadarWorkerRating => '4.9 ★ • 120+ completed jobs';

  @override
  String get dispatchRadarCancelSearch => 'Cancel Search';

  @override
  String get dispatchRadarCancelConfirm =>
      'Are you sure you want to cancel the search?';

  @override
  String get dispatchRadarViewTracking => 'Track Worker Location';

  @override
  String get trackingTitle => 'Job Tracking';

  @override
  String trackingOrderCode(String code) {
    return 'Order: #$code';
  }

  @override
  String get trackingStageAccepted => 'Job Accepted';

  @override
  String get trackingStageEnRoute => 'Worker En Route';

  @override
  String get trackingStageArrived => 'Worker Arrived';

  @override
  String get trackingStageExecuting => 'In Progress';

  @override
  String get trackingStageSignoff => 'Pending Sign-off';

  @override
  String trackingEtaNotice(int minutes, String distance) {
    return 'Estimated arrival in $minutes min · $distance km';
  }

  @override
  String trackingCheckInAt(String time) {
    return 'Worker arrived at $time';
  }

  @override
  String get trackingWorkerName => 'Nguyen Van Hung';

  @override
  String get trackingWorkerRating => '4.9 ★ (128 jobs)';

  @override
  String get trackingMaskedCall => 'Masked Call';

  @override
  String get trackingChat => 'Message';

  @override
  String get trackingWorkingTimer => 'Working Time';

  @override
  String get trackingServiceChecklist => 'Standard Safety Checklist (5 Steps)';

  @override
  String get trackingStep1 => 'Site inspection & tool preparation';

  @override
  String get trackingStep2 => 'Disassemble panel & clean air filters';

  @override
  String get trackingStep3 =>
      'Spray wash evaporator coil with nano-disinfectant';

  @override
  String get trackingStep4 => 'Wash condenser unit & flush drain pipe';

  @override
  String get trackingStep5 => 'Reassemble & conduct operating amp check';

  @override
  String get trackingStatusCompleted => 'Completed';

  @override
  String get trackingStatusDoing => 'In Progress';

  @override
  String get trackingStatusPending => 'Pending';

  @override
  String get trackingProceedToInspection => 'Proceed to Inspection';

  @override
  String get trackingHelpSupport => 'Help & Support';

  @override
  String get workerEnRouteTitle => 'En Route to Customer';

  @override
  String get workerOpenNavigation => 'Open Google Maps Navigation';

  @override
  String get workerArrivedConfirm => 'I Have Arrived';

  @override
  String get workerCancelJobPrompt => 'Cancel Job';

  @override
  String get workerDestinationLabel => 'Destination';

  @override
  String get workerCustomerNote =>
      'Note: Call before arriving, park at B2 basement';

  @override
  String get workerArrivedTitle => 'Confirm Arrival';

  @override
  String get workerArrivedDesc =>
      'Please tap \'Start Job\' once you have met the customer and prepared your tools.';

  @override
  String get workerStartJobCta => 'Start Working';

  @override
  String get workerCustomerNoShow => 'Customer Not Present?';

  @override
  String get workerExecutingTitle => 'Executing Service';

  @override
  String get workerExtraCostButton => '+ Request Extra Cost';

  @override
  String get workerCompleteJobCta => 'Complete Job -> Sign-off';

  @override
  String get workerExtraCostDialogTitle => 'Request Extra Material Cost';

  @override
  String get workerExtraCostDesc =>
      'Enter replacement parts/materials requiring customer approval before servicing.';

  @override
  String get workerItemName => 'Part/Material Name';

  @override
  String get workerItemPrice => 'Cost (VND)';

  @override
  String get workerSendProposal => 'Send Proposal to Customer';

  @override
  String get workerProposalSent => 'Proposal sent successfully!';

  @override
  String get inspectTitle => 'Service Inspection';

  @override
  String get inspectSubtitle =>
      'Please inspect actual work quality before signing off';

  @override
  String get inspectItem1 => 'Apartment swept and vacuumed clean';

  @override
  String get inspectItem2 => 'Windows & glass surfaces streak-free';

  @override
  String get inspectItem3 => 'Bulky waste collected and disposed of properly';

  @override
  String get inspectItem4 =>
      'Appliances & furniture returned to original positions';

  @override
  String get inspectItem5 =>
      'No damages or irregular movement of personal property';

  @override
  String get inspectSatisfiedCta => 'Approve & Sign-off';

  @override
  String get inspectUnsatisfiedCta => 'Not Satisfied';

  @override
  String get inspectWarrantyNotice =>
      'Automatic 30-day 0đ warranty if any issues arise.';

  @override
  String get paymentSummaryTitle => 'Payment Summary';

  @override
  String get paymentSummaryDesc =>
      'Transparent payment after direct inspection and sign-off';

  @override
  String get paymentExtraCost => 'Approved Extra Material Cost';

  @override
  String get paymentTotalToPay => 'Total Amount to Pay';

  @override
  String paymentPayNowCta(String amount) {
    return 'Pay $amount';
  }

  @override
  String get gatewayTitle => 'VietQR Payment Gateway';

  @override
  String get gatewayScanQrPrompt => 'Open any Banking App to scan VietQR';

  @override
  String get gatewayAccountOwner => 'Account Name';

  @override
  String get gatewayBankName => 'Bank';

  @override
  String get gatewayTransferContent => 'Transfer Note';

  @override
  String get gatewayConfirmTransferred => 'I Have Completed Transfer';

  @override
  String gatewayCountdown(String minutes, String seconds) {
    return 'QR Code expires in $minutes:$seconds';
  }

  @override
  String get paidSuccessTitle => 'Payment Successful!';

  @override
  String get paidSuccessDesc =>
      'Thank you for trusting VSTech Eco-Clean services.';

  @override
  String paidPointsEarned(int points) {
    return '+$points Eco-Clean reward points earned';
  }

  @override
  String get paidViewReceipt => 'View E-Receipt';

  @override
  String get paidReviewWorkerCta => 'Review Partner Worker';

  @override
  String get receiptTitle => 'Electronic Receipt';

  @override
  String receiptInvoiceNo(String no) {
    return 'Invoice No: #$no';
  }

  @override
  String get receiptDate => 'Issued At';

  @override
  String get receiptWorkerPayout => 'Direct Worker Labour';

  @override
  String get receiptPlatformFeeShare => 'Platform & Service Insurance Fee';

  @override
  String get receiptDownloadPdf => 'Download PDF Receipt';

  @override
  String receiptDownloading(String orderCode) {
    return 'Downloading invoice #$orderCode.pdf...';
  }

  @override
  String get receiptShare => 'Share Receipt';

  @override
  String copiedToClipboard(String text) {
    return 'Copied: $text';
  }

  @override
  String get reviewTitle => 'Service Review';

  @override
  String get reviewPrompt => 'How was the service quality today?';

  @override
  String get reviewTagPunctual => 'Punctual';

  @override
  String get reviewTagAttentive => 'Attentive';

  @override
  String get reviewTagClean => 'Clean & Tidy';

  @override
  String get reviewTagPolite => 'Polite & Honest';

  @override
  String get reviewTipTitle => 'Send a Tip to Support Worker';

  @override
  String get reviewTipSubtitle => '100% of tip goes directly to the worker';

  @override
  String get reviewTipNo => 'No Tip';

  @override
  String reviewSubmitWithTip(String amount) {
    return 'Submit Review & Tip $amount';
  }

  @override
  String get reviewSubmitOnly => 'Submit Review';

  @override
  String get reviewCommentHint =>
      'Add remarks to help worker improve (optional)...';

  @override
  String get thanksTitle => 'Thank You So Much! 🌿';

  @override
  String get thanksSubtitle =>
      'Your review and support empower our partner workers greatly.';

  @override
  String get thanksBackHome => 'Back to Home';

  @override
  String get workerWaitTitle => 'Job Completion';

  @override
  String get workerWaitInspectionTitle => 'Waiting for Customer Sign-off';

  @override
  String get workerWaitInspectionDesc =>
      'Customer is inspecting on-site items.';

  @override
  String get workerWaitPaymentTitle => 'Waiting for Payment';

  @override
  String workerWaitPaymentDesc(String amount) {
    return 'Customer is paying $amount via VietQR.';
  }

  @override
  String get workerPaidCelebrationTitle => 'Customer Paid Successfully!';

  @override
  String workerPaidWalletCredit(String amount) {
    return '+$amount has been credited to your wallet';
  }

  @override
  String get workerViewWalletCta => 'View Worker Wallet';

  @override
  String get ordersTitle => 'My Bookings';

  @override
  String get ordersTabActive => 'Active';

  @override
  String get ordersTabScheduled => 'Scheduled';

  @override
  String get ordersTabCompleted => 'Completed';

  @override
  String get ordersEmptyTitle => 'No bookings yet';

  @override
  String get ordersEmptyDesc =>
      'Explore our home services and make your first booking today.';

  @override
  String get ordersEmptyCta => 'Explore Services';

  @override
  String get ordersTrackWorkerCta => 'Track Worker';

  @override
  String get ordersRebookCta => 'Rebook';

  @override
  String get ordersWarrantyCta => 'Warranty 0đ';

  @override
  String get ordersViewDetailCta => 'Order Details';

  @override
  String get orderDetailTitle => 'Order Details';

  @override
  String get orderDetailWorkerCard => 'Assigned Worker';

  @override
  String get orderDetailScheduleCard => 'Schedule & Location';

  @override
  String get orderDetailPriceCard => 'Payment Breakdown';

  @override
  String get orderDetailPaidStatus => 'Paid';

  @override
  String get orderDetailUnpaidStatus => 'Pending Payment';

  @override
  String get orderDetailWarrantyBadge => 'Automatic 30-Day Free Warranty';

  @override
  String get orderDetailCancelCta => 'Cancel Order';

  @override
  String get orderDetailContactSupport => 'Customer Support';

  @override
  String get workerJobsTitle => 'Job Management';

  @override
  String get workerJobsTabAssigned => 'Assigned';

  @override
  String get workerJobsTabActive => 'Active';

  @override
  String get workerJobsTabCompleted => 'Completed';

  @override
  String workerJobsDistance(String km) {
    return '$km km';
  }

  @override
  String workerJobsEarningsEst(String amount) {
    return 'Est. Earnings: +$amount';
  }

  @override
  String get workerJobsAcceptJob => 'Accept Job';

  @override
  String get workerJobsGoToWork => 'Go to Job';

  @override
  String get workerJobsCompletedBadge => 'Settled';

  @override
  String get workerJobsEmpty => 'No jobs currently in this category';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMarkAllRead => 'Mark all as read';

  @override
  String get notificationsSectionToday => 'Today';

  @override
  String get notificationsSectionEarlier => 'Earlier';

  @override
  String get notificationsTabAll => 'All';

  @override
  String get notificationsTabOrders => 'Orders';

  @override
  String get notificationsTabPromo => 'Offers';

  @override
  String get notificationsTabSystem => 'System';

  @override
  String get notificationsEmpty => 'No new notifications';

  @override
  String get notifSettingsTitle => 'Notification Settings';

  @override
  String get notifSettingsPush => 'Push Notifications';

  @override
  String get notifSettingsPushDesc =>
      'Receive real-time worker updates and order progress alerts';

  @override
  String get notifSettingsSms => 'SMS Messages';

  @override
  String get notifSettingsSmsDesc =>
      'Receive OTP verification codes and receipts via SMS';

  @override
  String get notifSettingsZalo => 'Zalo Notifications (ZNS)';

  @override
  String get notifSettingsZaloDesc =>
      'Receive updates via official VSTech Zalo OA';

  @override
  String get notifSettingsPromo => 'Promotions & Offers';

  @override
  String get notifSettingsPromoDesc =>
      'Get periodic voucher discounts and loyalty gifts';

  @override
  String get notifSettingsSave => 'Save Changes';

  @override
  String get notifSettingsSaved => 'Notification preferences saved';

  @override
  String get cancelTitle => 'Cancel Booking';

  @override
  String get cancelFreeSubtitle => 'Free cancellation before worker acceptance';

  @override
  String cancelFeeSubtitle(String fee) {
    return 'Cancellation fee $fee after worker has accepted';
  }

  @override
  String get cancelReasonPrompt => 'Please select a cancellation reason:';

  @override
  String get cancelReasonChangeSchedule =>
      'Schedule conflict / Sudden plan change';

  @override
  String get cancelReasonFoundOther => 'Found another solution';

  @override
  String get cancelReasonWrongInfo => 'Wrong service or address';

  @override
  String get cancelReasonLateWorker => 'Worker is arriving too late';

  @override
  String get cancelReasonOther => 'Other reason';

  @override
  String get cancelReasonOtherHint => 'Enter detailed reason...';

  @override
  String get cancelPolicyNoteFree =>
      'The booking will be cancelled immediately with zero fee.';

  @override
  String get cancelPolicyNoteFee =>
      'A 50,000đ fee will be charged to support the worker\'s travel expenses.';

  @override
  String get cancelConfirmBtnFree => 'Confirm Free Cancellation';

  @override
  String get cancelConfirmBtnFee => 'Confirm & Pay 50,000đ Fee';

  @override
  String get cancelKeepBookingBtn => 'Keep Booking';

  @override
  String get workerCancelTitle => 'Cancel Job Acceptance';

  @override
  String get workerCancelWarning =>
      'Warning: Cancelling will reduce your completion rate from 96% to 95% and may affect dispatch priority.';

  @override
  String get workerCancelReasonPrompt => 'Select cancellation reason:';

  @override
  String get workerCancelReasonVehicle =>
      'Vehicle breakdown or traffic incident';

  @override
  String get workerCancelReasonEmergency => 'Family emergency';

  @override
  String get workerCancelReasonNoContact =>
      'Unable to reach customer after 3 calls';

  @override
  String get workerCancelReasonUnsafe => 'Worksite is unsafe to execute';

  @override
  String get workerCancelReasonOther => 'Other reason';

  @override
  String get workerCancelReasonOtherHint => 'Explain emergency reason...';

  @override
  String get workerCancelConfirmBtn => 'Confirm Cancellation';

  @override
  String get workerCancelKeepJobBtn => 'Continue Job';

  @override
  String get noShowTitle => 'Waiting for Customer';

  @override
  String get noShowSubtitle => 'Arrived at location — Waiting for customer';

  @override
  String get noShowTimerDesc =>
      'Maximum wait time is 15 minutes. If no response, you receive a 50,000đ compensation fee.';

  @override
  String get noShowCallReminder => 'Call Customer';

  @override
  String get noShowChatReminder => 'Message Customer';

  @override
  String get noShowReportBtn => 'Report Customer No-show';

  @override
  String get noShowUploadEvidencePrompt =>
      'Take a photo of front door/premises as proof:';

  @override
  String get noShowUploadBtn => 'Take Proof Photo';

  @override
  String get noShowConfirmReportBtn => 'Submit No-Show Report';

  @override
  String get noShowSuccessTitle => 'No-Show Recorded';

  @override
  String get noShowSuccessDesc =>
      'Order cancelled and 50,000đ travel compensation has been credited to your wallet.';

  @override
  String get noShowBackHomeBtn => 'Back to Jobs Hub';

  @override
  String get disputeTitle => 'Report Issue & Dispute';

  @override
  String get disputeTypePrompt => 'Select the issue encountered:';

  @override
  String get disputeTypeQuality => 'Poor service quality / Substandard';

  @override
  String get disputeTypeDamage => 'Property damage or loss';

  @override
  String get disputeTypeAttitude => 'Unprofessional / Rude worker attitude';

  @override
  String get disputeTypeOvercharge => 'Incorrect charging / Overcharging';

  @override
  String get disputeTypeOther => 'Other issue';

  @override
  String get disputeDescPrompt => 'Detailed description of the issue:';

  @override
  String get disputeDescHint =>
      'Please describe in detail for fastest resolution...';

  @override
  String get disputePhotosPrompt => 'Evidence photos (up to 5 photos):';

  @override
  String get disputeAddPhoto => 'Add Photo';

  @override
  String get disputeEscrowNotice =>
      'Escrow Protection: The 400,000đ payment is securely frozen in escrow. The worker cannot withdraw funds until this dispute is resolved.';

  @override
  String get disputeSubmitBtn => 'Submit Dispute & Freeze Payment';

  @override
  String get disputedStatusTitle => 'Order Under Review';

  @override
  String disputedComplaintCode(String code) {
    return 'Complaint Code: $code';
  }

  @override
  String get disputedEscrowBadge => 'Protected by VSTech Escrow';

  @override
  String get disputedTimelineTitle => 'Dispute Resolution Process:';

  @override
  String get disputedStep1 => 'Received complaint & froze worker payout (Done)';

  @override
  String get disputedStep2 =>
      'Specialist reviews proof and contacts both parties (Within 2 hrs)';

  @override
  String get disputedStep3 =>
      'Resolution: Free rework or wallet refund (Within 24 hrs)';

  @override
  String get disputedViewComplaintsBtn => 'View My Disputes';

  @override
  String get disputedBackOrderBtn => 'Back to Order Details';

  @override
  String get complaintsTitle => 'My Disputes';

  @override
  String get complaintsTabReviewing => 'Under Review';

  @override
  String get complaintsTabNeedInfo => 'Needs Info';

  @override
  String get complaintsTabResolved => 'Resolved';

  @override
  String get complaintsTabClosed => 'Closed';

  @override
  String get complaintsEmpty => 'No disputes in this tab';

  @override
  String get complaintDetailTitle => 'Dispute Details';

  @override
  String complaintDetailOrderCode(String code) {
    return 'Order Code: $code';
  }

  @override
  String complaintDetailDate(String date) {
    return 'Created: $date';
  }

  @override
  String get complaintDetailResolution => 'Resolution Outcome';

  @override
  String complaintDetailRefundNotice(String amount) {
    return 'Refund $amount to e-wallet within 3-5 business days';
  }

  @override
  String get complaintDetailAddInfoPrompt =>
      'Specialist requested additional full-view photos of the appliance:';

  @override
  String get complaintDetailAddInfoBtn => 'Provide Additional Info';

  @override
  String get workerDisputeTitle => 'Customer Dispute Filed';

  @override
  String workerDisputeWarning(String code, String amount) {
    return 'Customer filed a dispute for order $code. The labour payout $amount is temporarily held in Escrow.';
  }

  @override
  String get workerDisputeClaimSection => 'Dispute Claim Details:';

  @override
  String get workerDisputeReplyPrompt => 'Submit your response / explanation:';

  @override
  String get workerDisputeReplyHint =>
      'Describe your work process and completion proof...';

  @override
  String get workerDisputeSubmitReplyBtn => 'Submit Explanation';

  @override
  String get warrantyCertTitle => 'Warranty Certificate';

  @override
  String warrantyCertNumber(String code) {
    return 'Certificate BH-$code';
  }

  @override
  String get warrantyActiveStatus => 'ACTIVE';

  @override
  String get warrantyExpiredStatus => 'EXPIRED';

  @override
  String get warrantyTechnicianLabel => 'Technician';

  @override
  String get warrantyCompletedLabel => 'Completed';

  @override
  String get warrantyPeriodLabel => 'Period';

  @override
  String get warrantyPeriodValue => '60 days · until 17/05/2026';

  @override
  String get warrantyRemainingLabel => 'Remaining';

  @override
  String get warrantyRemainingDays => '22 days';

  @override
  String get warrantyExpiredText => 'Expired';

  @override
  String get warrantyQrNote =>
      'The technician scans this code upon arrival to open the original order.';

  @override
  String get warrantyCoveredTitle => 'Covered';

  @override
  String get warrantyNotCoveredTitle => 'Not covered';

  @override
  String get warrantyCoveredItem1 =>
      'Air conditioner leaking water after cleaning';

  @override
  String get warrantyCoveredItem2 => 'Gas leakage due to indoor unit assembly';

  @override
  String get warrantyCoveredItem3 => 'Cleaning issues within committed scope';

  @override
  String get warrantyNotCoveredItem1 => 'Damage caused by unstable home power';

  @override
  String get warrantyNotCoveredItem2 =>
      'Equipment tampered with by third parties';

  @override
  String get warrantyNotCoveredItem3 =>
      'Aging equipment past recommended lifespan';

  @override
  String get warrantyRequestCta => 'Request warranty';

  @override
  String get warrantyViewRequestCta => 'View warranty request';

  @override
  String get warrantyRequestTitle => 'Warranty Request';

  @override
  String warrantyRequestSubtitle(String code) {
    return 'Warranty for $code';
  }

  @override
  String get warrantyRequestFreePrice => '0đ';

  @override
  String get warrantyDescribeIssueTitle => 'Describe the issue';

  @override
  String get warrantyDescribePlaceholder =>
      'Tap to describe the issue you are facing...';

  @override
  String get warrantyDescribePreset =>
      'Air conditioner leaking water after cleaning';

  @override
  String get warrantyMediaTitle => 'Photos / Video (up to 5 photos or 1 video)';

  @override
  String get warrantyAddPhotoCta => '+ Add photo';

  @override
  String get warrantySlotTitle => 'Preferred time slots (pick any)';

  @override
  String get warrantySlot1 => 'Tomorrow 26/04 · 08:00 - 10:00';

  @override
  String get warrantySlot2 => 'Tomorrow 26/04 · 14:00 - 16:00';

  @override
  String get warrantySlot3 => 'Sun 27/04 · 09:00 - 11:00';

  @override
  String get warrantyFreePolicy => 'Free warranty · 0đ. No payment needed.';

  @override
  String get warrantySubmitCta => 'Send warranty request';

  @override
  String get warrantySlotRequiredPrompt => 'Pick at least one time slot';

  @override
  String get warrantyDescRequiredPrompt => 'Describe the issue to send';

  @override
  String get warrantyStatusTitle => 'Warranty Progress';

  @override
  String get warrantyBadgeTag => 'WARRANTY';

  @override
  String get warrantyStatusCode => '#BH20250425-0087';

  @override
  String get warrantyStepSubmitted => 'Submitted';

  @override
  String get warrantyStepAccepted => 'Accepted by Pro';

  @override
  String get warrantyStepProcessing => 'In progress';

  @override
  String get warrantyStepResolved => 'Resolved';

  @override
  String get warrantyNoteSubmitted =>
      'Hùng has 24 hours to accept. If declined, VSTech Home Services assigns another pro.';

  @override
  String get warrantyNoteProcessing =>
      'Hùng will arrive in your chosen slot. Track and message him like a regular order.';

  @override
  String get warrantyNoteResolved =>
      'Resolved and confirmed by you. The warranty certificate remains valid until 17/05.';

  @override
  String get warrantyBackToOrdersCta => 'Back to My orders';

  @override
  String get workerWarrantyJobTitle => 'Warranty Job';

  @override
  String get workerWarrantyDeadline => 'Respond within 23:59:00';

  @override
  String get workerWarrantyCustomerInfo =>
      'Nguyễn Thị Mai · Flora Novia Apartment, Thu Duc';

  @override
  String get workerWarrantyNetIncome => 'Net earnings';

  @override
  String get workerWarrantyCustomerIssue =>
      'Air conditioner leaking water after cleaning, drain pipe needs inspection.';

  @override
  String get workerWarrantyCustomerIssueTitle => 'Issue reported by customer';

  @override
  String get workerWarrantyOriginalOrderTitle => 'Original order details';

  @override
  String get workerWarrantyOriginalCode => 'Original order: #HS20250318-0087';

  @override
  String get workerWarrantyOriginalDate => 'Completed date: 18/03/2026';

  @override
  String get workerWarrantyOriginalRating =>
      'Rating: 5.0★ · \"Technician was very enthusiastic\"';

  @override
  String get workerWarrantyBeforePhoto => 'Before photo';

  @override
  String get workerWarrantyAfterPhoto => 'After photo';

  @override
  String get workerWarrantyDeclineCta => 'Decline';

  @override
  String get workerWarrantyAcceptCta => 'Accept warranty job';

  @override
  String get workerWarrantyDeclineTitle => 'Decline Warranty';

  @override
  String get workerWarrantyPenaltyWarnTitle =>
      'Warning: 120.000đ rework deduction';

  @override
  String get workerWarrantyPenaltyWarnBody =>
      'The warranty job will be reassigned. Per partner terms, 120.000đ rework cost will be deducted directly from your wallet.';

  @override
  String get workerWarrantyReasonTitle => 'Reason for declining warranty';

  @override
  String get workerWarrantyReason1 => 'Not caused by my work';

  @override
  String get workerWarrantyReason2 => 'Cannot fit the schedule';

  @override
  String get workerWarrantyReason3 => 'Requires parts outside scope';

  @override
  String get workerWarrantyReason4 => 'Other reason';

  @override
  String get workerWarrantyPenaltyAck =>
      'I understand that 120.000đ will be deducted from my earnings wallet.';

  @override
  String get workerWarrantyConfirmDeclineCta => 'Confirm decline';

  @override
  String get workerWarrantyBackToJobCta => 'Back to view job';

  @override
  String get ordersWarrantyActiveChip =>
      'Warranty active: 22 days left · until 17/05';

  @override
  String get ordersViewWarrantyCertCta => 'View warranty certificate';

  @override
  String get ordersActiveWarrantyTitle => 'Warranty: Air-con Cleaning';

  @override
  String get chatPrivacyBanner => 'Both phone numbers are hidden';

  @override
  String get chatCallBack => 'Call back';

  @override
  String get chatCurrentLocation => 'Current location';

  @override
  String get chatExtraCostBadge => 'EXTRA COST REQUEST';

  @override
  String get chatExtraCostTitle => 'Replace shower-head seal';

  @override
  String get chatExtraCostDesc => 'Parts + labour, photo above';

  @override
  String get chatExtraCostAmount => '+45.000đ';

  @override
  String get chatApprove => 'Approve';

  @override
  String get chatDecline => 'Decline';

  @override
  String get chatExtraCostApproved =>
      'Approved · added to the bill at sign-off';

  @override
  String get chatExtraCostDeclined => 'Declined';

  @override
  String get chatExtraCostPendingWorker => 'Waiting for the customer';

  @override
  String get chatMaskedPhoneNote =>
      'Phone number hidden to protect both sides.';

  @override
  String get chatClosedNotice =>
      'This chat closed 24 hours after the order was completed. For help, contact Support.';

  @override
  String get chatInputHint => 'Type a message…';

  @override
  String get chatSeen => 'Seen';

  @override
  String get chatSent => 'Sent';

  @override
  String get chatQuickWorker1 => 'I\'m on my way';

  @override
  String get chatQuickWorker2 => 'I\'m at the lobby';

  @override
  String get chatQuickWorker3 => 'Almost done';

  @override
  String get chatQuickWorker4 => 'Please open the door';

  @override
  String get chatQuickCustomer1 => 'I\'m home';

  @override
  String get chatQuickCustomer2 => 'Park in basement B1';

  @override
  String get chatQuickCustomer3 => 'Please call before you arrive';

  @override
  String get chatQuickCustomer4 => 'Thanks';

  @override
  String get callRecordingNotice =>
      'Calls are recorded to protect both sides and help resolve complaints';

  @override
  String get callConnecting => 'Connecting…';

  @override
  String get callIncoming => 'Incoming call';

  @override
  String get callMute => 'Mute';

  @override
  String get callSpeaker => 'Speaker';

  @override
  String get callEnd => 'End';

  @override
  String get callAccept => 'Accept';

  @override
  String callVoiceLog(String duration) {
    return 'Voice call · $duration';
  }

  @override
  String get callMissedCustomer => 'Mai missed your call';

  @override
  String get callMissedWorker => 'Missed call from Hùng';

  @override
  String get devicesTitle => 'Your Home & Devices';

  @override
  String devicesTabDevices(int count) {
    return 'Devices ($count)';
  }

  @override
  String get devicesTabSchedule => 'Maintenance Schedule';

  @override
  String get devicesAddDevice => 'Add New Device';

  @override
  String get devicesOverdueReminder => 'Water heater service reminder';

  @override
  String get devicesOverdueDesc =>
      'Ariston overdue since 10/01. Flush tank and replace anode rod periodically to avoid electrical leakage.';

  @override
  String get devicesStatusGood => 'Running well';

  @override
  String get devicesStatusNeedsService => 'Needs service';

  @override
  String devicesLastService(String date) {
    return 'Last serviced: $date';
  }

  @override
  String get devicesScheduleOverdueTag => 'NEEDS BOOKING';

  @override
  String get devicesScheduleUpcomingTag => 'UPCOMING';

  @override
  String devicesScheduleFutureTag(int months) {
    return '$months MONTHS LEFT';
  }

  @override
  String devicesScheduleOverdueMonths(int count, String brand) {
    return 'Overdue by $count months · $brand';
  }

  @override
  String devicesScheduleFrequency(int count, String brand) {
    return 'Every $count months · $brand';
  }

  @override
  String get devicesChangeAddress => 'Change address';

  @override
  String get devicesDefaultAddressLabel => 'Default address';

  @override
  String get aiAssistantTitle => 'HomeService AI Assistant';

  @override
  String get aiAssistantOnlineStatus => 'Always ready to help 24/7';

  @override
  String get aiAssistantWelcome =>
      'Hello Mai! I\'m your HomeService AI assistant. I can help you find services, estimate costs, or guide home appliance care.';

  @override
  String get aiChipSuggestService => 'Suggest suitable services for me';

  @override
  String get aiChipHouseCleaningCost => 'How much does home cleaning cost?';

  @override
  String get aiChipCleanAcAtHome => 'How to clean air-con at home?';

  @override
  String get aiChipBookElectrician => 'I want to book an electrician';

  @override
  String get aiChipWarrantyPolicy => 'How does warranty policy work?';

  @override
  String get aiAssistantInputPlaceholder => 'Ask AI assistant anything…';

  @override
  String get aiResponseHouseCleaningCost =>
      'Standard home cleaning starts at 80,000đ/hour (min 2 hours). Includes living room, bedroom, kitchen, and bathroom.';

  @override
  String get aiResponseAcClean =>
      'Wash dust mesh filters every 2 weeks with warm water. For indoor/outdoor coils, book professional pressure cleaning every 3-6 months.';

  @override
  String get aiResponseBookElectrician =>
      'You can book Electrical & Plumbing right away. Certified and verified pros arrive in 30 minutes!';

  @override
  String get aiResponseWarranty =>
      'All services include 7 to 30 days warranty. If unsatisfied or the issue recurs, pros return at 100% free of charge.';

  @override
  String get aiSuggestionsTitle => 'Smart Suggestions for You';

  @override
  String get aiSuggestionsUrgentSection =>
      'Priority recommendations for your home';

  @override
  String get aiSuggestionsHeaterTitle => 'Maintain Ariston Water Heater';

  @override
  String get aiSuggestionsHeaterDesc =>
      'Unit used for 14 months without tank flush. Book descaling and anode replacement to ensure electrical safety and energy savings.';

  @override
  String get aiSuggestionsBookNow => 'Book Now · 250.000đ';

  @override
  String get aiSuggestionsOtherSection => 'Suggested routine services';

  @override
  String get aiSuggestionsAcTitle => 'Air-con Cleaning';

  @override
  String get aiSuggestionsAcDesc =>
      'Clean every 3-6 months to protect respiratory health and save electricity.';

  @override
  String get aiSuggestionsLaundryTitle => 'Laundry · Curtain & Sofa Wash';

  @override
  String get aiSuggestionsLaundryDesc =>
      'Sanitize and eliminate fine dust in your living space for maximum comfort.';

  @override
  String get aiSuggestionsPestTitle => 'Routine Pest Control';

  @override
  String get aiSuggestionsPestDesc =>
      'Protect family health against mosquitoes, roaches, and pests.';

  @override
  String get profileTitle => 'Personal Profile';

  @override
  String get profileEditLink => 'Edit';

  @override
  String get profileMenuPersonalInfo => 'Personal Information';

  @override
  String get profileMenuAddresses => 'My Addresses';

  @override
  String get profileMenuFavourites => 'Favourite Pros';

  @override
  String get profileMenuPayment => 'Payment Methods';

  @override
  String get profileMenuNotifications => 'Notification Settings';

  @override
  String get profileMenuSettings => 'Settings & Security';

  @override
  String get profileMenuComplaints => 'My Complaints';

  @override
  String get editProfileTitle => 'Personal Information';

  @override
  String get editProfileChangeAvatar => 'Change photo';

  @override
  String get editProfileFullName => 'Full Name';

  @override
  String get editProfilePhone => 'Phone Number';

  @override
  String get editProfileEmail => 'Email';

  @override
  String get editProfileDob => 'Date of Birth';

  @override
  String get editProfileOtpNotice =>
      'OTP verification needed when changing phone number';

  @override
  String get editProfileSavedSuccess => 'Profile changes saved successfully';

  @override
  String get editProfileSaveCta => 'Save Changes';

  @override
  String get addressesTitle => 'My Addresses';

  @override
  String get addressesAddNew => 'Add New Address';

  @override
  String get addressesDefaultBadge => 'DEFAULT';

  @override
  String get addressesTagHome => 'HOME';

  @override
  String get addressesTagWork => 'WORK';

  @override
  String get addressesTagOther => 'OTHER';

  @override
  String get addressesEditAction => 'Edit';

  @override
  String get addressesSetDefaultAction => 'Set as default';

  @override
  String get addressesDeleteAction => 'Delete';

  @override
  String get addressesDefaultCannotDelete =>
      'Default address cannot be deleted';

  @override
  String get addressesDeleteConfirm =>
      'Are you sure you want to delete this address?';

  @override
  String get addressEditTitle => 'Add / Edit Address';

  @override
  String get addressEditLabelSection => 'Address Label';

  @override
  String get addressEditSearchPlaceholder => 'Search your home address…';

  @override
  String get addressEditPinNote => 'Pin exact location on map';

  @override
  String get addressEditHouseType => 'Property Type';

  @override
  String get addressEditTownhouse => 'Townhouse';

  @override
  String get addressEditApartment => 'Apartment';

  @override
  String get addressEditFloor => 'Floor Number';

  @override
  String get addressEditElevator => 'Elevator';

  @override
  String get addressEditHasElevator => 'Has elevator';

  @override
  String get addressEditNoElevator => 'No elevator';

  @override
  String get addressEditAccessNote => 'Location note (parking, gate bell…)';

  @override
  String get addressEditSetDefaultSwitch => 'Set as default address';

  @override
  String get addressEditSaveCta => 'Save Address';

  @override
  String get pmsTitle => 'Payment Methods';

  @override
  String get pmsLinkWalletCta => 'Link New Wallet';

  @override
  String get pmsDefaultLabel => 'Default payment method';

  @override
  String get pmsSetDefault => 'Set as default';

  @override
  String get pmsUnlink => 'Unlink';

  @override
  String get pmsUnlinkConfirm =>
      'Unlink this wallet? You can link it again anytime.';

  @override
  String get pmsSecurityNote =>
      'Payment info is encrypted and protected under international PCI-DSS security standards.';

  @override
  String get linkWalletTitle => 'Link Digital Wallet';

  @override
  String get linkWalletSelectPrompt =>
      'Select the digital wallet you want to link:';

  @override
  String get linkWalletStepConfirmTitle => 'Confirm in wallet app';

  @override
  String get linkWalletStepConfirmDesc =>
      'Wallet app is opened. Please sign in and authorize HomeService for automatic booking charges.';

  @override
  String get linkWalletStepSuccessTitle => 'Wallet Linked Successfully!';

  @override
  String get linkWalletStepSuccessDesc => 'Phone number: 0901 ••• 567';

  @override
  String get linkWalletContinueCta => 'Continue';

  @override
  String get linkWalletIHaveConfirmedCta => 'I have confirmed';

  @override
  String get linkWalletBackToPmsCta => 'Back to payment methods';

  @override
  String get favsTitle => 'Favourite Pros';

  @override
  String get favsEmpty =>
      'You have no favourite pros yet. Rate 5 stars upon order completion to add pros here!';

  @override
  String get favsRebookCta => 'Rebook This Pro';

  @override
  String favsLastJob(String job) {
    return 'Last job: $job';
  }

  @override
  String get workerPreviewTitle => 'Pro Profile';

  @override
  String get workerPreviewVerifiedPro => 'Verified Professional';

  @override
  String get workerPreviewServices => 'Specialized Services';

  @override
  String get workerPreviewRecentReview => 'Recent customer review';

  @override
  String get workerPreviewBookCta => 'Book with This Pro';

  @override
  String get settingsTitle => 'Settings & History';

  @override
  String get settingsTabSettings => 'Settings';

  @override
  String get settingsTabHistory => 'Order History';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsChangePassword => 'Change Password';

  @override
  String get settingsPaymentMethods => 'Payment Methods';

  @override
  String get settingsPaymentMethodsSub => 'Manage cards and wallets';

  @override
  String get settingsHelpCenter => 'Help Center';

  @override
  String get settingsHelpCenterSub => 'Complaints and order help';

  @override
  String get settingsAbout => 'About App';

  @override
  String get settingsAboutSub => 'Version 1.0.0';

  @override
  String get settingsAboutDialogTitle => 'VSTech Home Services v1.0.0';

  @override
  String get settingsAboutDialogBody =>
      'Official release Phase 1 MVP · V-STech. All rights reserved by VSTech Home Services.';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsLogout => 'Log Out';

  @override
  String get logoutDialogTitle => 'Log out of your account?';

  @override
  String get logoutDialogBody =>
      'You will need to sign in again with your phone number to continue booking and tracking services.';

  @override
  String get logoutConfirmCta => 'Log Out';

  @override
  String get logoutCancelCta => 'Stay';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get changePasswordCurrent => 'Current password';

  @override
  String get changePasswordNew => 'New password';

  @override
  String get changePasswordConfirm => 'Confirm new password';

  @override
  String get changePasswordRule =>
      'Password must be at least 8 characters long, including letters and numbers.';

  @override
  String get changePasswordSuccess => 'Password changed successfully!';

  @override
  String get changePasswordCta => 'Confirm Change Password';

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get deleteAccountWarningTitle => 'This action cannot be undone';

  @override
  String get deleteAccountWarningBody =>
      'All account information and associated data will be permanently deleted from the system.';

  @override
  String get deleteAccountItem1 => 'Personal profile and phone number';

  @override
  String get deleteAccountItem2 => 'Saved addresses and linked digital wallets';

  @override
  String get deleteAccountItem3 => 'Favourite pros and chat history';

  @override
  String get deleteAccountItem4 => 'Active warranty certificates';

  @override
  String get deleteAccountReasonTitle =>
      'Please tell us why you want to delete your account:';

  @override
  String get deleteAccountReason1 => 'No longer need the service';

  @override
  String get deleteAccountReason2 => 'Privacy and personal data concerns';

  @override
  String get deleteAccountReason3 => 'Want to create a new account';

  @override
  String get deleteAccountReason4 => 'Other reason';

  @override
  String get deleteAccountConfirmCta => 'Delete Account · Verify OTP';

  @override
  String get deleteAccountKeepCta => 'Keep My Account';

  @override
  String get wwalletTitle => 'Earnings Wallet';

  @override
  String get wwalletAvailableBalance => 'Available to withdraw';

  @override
  String get wwalletTotalEarned => 'Total earned';

  @override
  String get wwalletWithdrawn => 'Withdrawn / pending';

  @override
  String get wwalletDeductions => 'Deductions';

  @override
  String get wwalletOnHold => 'On hold';

  @override
  String get wwalletOnHoldNotice => 'On hold (not in balance)';

  @override
  String get wwalletWithdrawCta => 'Withdraw';

  @override
  String get wwalletTabAll => 'All';

  @override
  String get wwalletTabIncome => 'Income';

  @override
  String get wwalletTabWithdraw => 'Withdrawal';

  @override
  String get wwalletTabHold => 'On hold';

  @override
  String get wwalletStatusCompleted => 'Completed';

  @override
  String get wwalletStatusProcessing => 'Processing';

  @override
  String get wwalletStatusOnHold => 'On hold';

  @override
  String get wtxTitle => 'Transaction Details';

  @override
  String get wtxBreakdownTitle => 'Breakdown';

  @override
  String get wtxCustomerPaid => 'Customer paid';

  @override
  String get wtxExtraCost => 'Incl. extra cost';

  @override
  String get wtxPlatformFee => 'Platform fee 15% of service price';

  @override
  String get wtxNetIncome => 'Net';

  @override
  String get wtxInfoTitle => 'Transaction Info';

  @override
  String get wtxTime => 'Time';

  @override
  String get wtxTxId => 'Transaction ID';

  @override
  String get wtxRelatedOrder => 'Related order';

  @override
  String get wtxTargetBank => 'To account';

  @override
  String get wwdTitle => 'Withdraw to Bank';

  @override
  String get wwdAmountLabel => 'Amount';

  @override
  String get wwdAmountHint => 'Enter withdrawal amount';

  @override
  String get wwdQuickAll => 'All';

  @override
  String get wwdCurrentBalance => 'Current balance';

  @override
  String get wwdMinAmount => 'Minimum per withdrawal';

  @override
  String get wwdFee => 'Fee';

  @override
  String get wwdFeeFree => '0đ (Free)';

  @override
  String get wwdBalanceAfter => 'Balance after';

  @override
  String get wwdBankCardTitle => 'To bank account';

  @override
  String get wwdFromKyc => 'from partner profile';

  @override
  String get wwdPhase1Notice =>
      'Phase 1: accounting approves and transfers manually within 24 working hours.';

  @override
  String get wwdContinueCta => 'Continue';

  @override
  String get wwdMinValidation => 'Minimum withdrawal is 100.000đ';

  @override
  String get wwdMaxValidation => 'Amount exceeds available balance';

  @override
  String get wwdpinTitle => 'Enter Wallet PIN';

  @override
  String wwdpinSubtitle(String amount) {
    return 'Confirm withdrawal of $amount to bank';
  }

  @override
  String get wwdpinSecurityNote => '6-digit PIN securing your account.';

  @override
  String get wwdstTitle => 'Withdrawal Request';

  @override
  String get wwdstSuccessTitle => 'Withdrawal request submitted!';

  @override
  String get wwdstStep1 => 'Request sent';

  @override
  String get wwdstStep2 => 'Awaiting accounting (within 24 h)';

  @override
  String get wwdstStep3 => 'Transferred';

  @override
  String get wwdstNote =>
      'The amount is deducted from your available balance. If rejected, it returns to your wallet.';

  @override
  String get wwdstBackWalletCta => 'Back to wallet';

  @override
  String get wcalTitle => 'Schedule';

  @override
  String get wcalWeekRange => '21/04 – 27/04';

  @override
  String get wcalSetAvailabilityCta => 'Availability & time off';

  @override
  String wcalJobsCount(int count) {
    return '$count jobs';
  }

  @override
  String get wcalDayOff => 'Off';

  @override
  String get wcalToday => 'Today';

  @override
  String get wcalNoJobs => 'No jobs yet. You are available in your set hours.';

  @override
  String get wcalDayOffRegular => 'Regular day off.';

  @override
  String get wavailTitle => 'Availability & Time Off';

  @override
  String get wavailWeeklySchedule => 'Weekly Availability';

  @override
  String get wavailTapToCycle =>
      'Tap a time range to cycle (08:00–18:00 · 07:00–20:00 · 13:00–21:00)';

  @override
  String get wavailTimeOffSection => 'Time Off';

  @override
  String get wavailTimeOffDesc =>
      'Select days you wish to pause receiving new jobs.';

  @override
  String get wavailTimeOffWarn =>
      'You have an accepted warranty job at 08:00 on 26/04. Time off only blocks new jobs; message the customer or support to reschedule.';

  @override
  String get wavailSaveCta => 'Save Schedule';

  @override
  String get wavailSavedSuccess => 'Work schedule settings saved successfully';

  @override
  String get wzoneTitle => 'Work Zone';

  @override
  String get wzoneDistrictsTitle => 'Service Districts';

  @override
  String get wzoneDistrictsNote =>
      'Select at least 1 district you are ready to serve.';

  @override
  String get wzoneRadiusTitle => 'Radius from your location';

  @override
  String get wzoneRadiusNote =>
      'You only get jobs inside selected districts and this radius. A wider zone means more jobs.';

  @override
  String get wzoneSaveCta => 'Save Work Zone';

  @override
  String get wzoneSavedSuccess => 'Work zone saved successfully';

  @override
  String get wskillTitle => 'Skills & Certificates';

  @override
  String get wskillExpiredBannerTitle => 'Work-at-height certificate expired';

  @override
  String get wskillExpiredBannerDesc =>
      'Outdoor and high-floor jobs are hidden (outdoor AC units, balconies, garden pest control). Upload a new copy to see them again.';

  @override
  String get wskillPendingBannerTitle =>
      'New certificate pending (within 48 hours)';

  @override
  String get wskillPendingBannerDesc =>
      'Outdoor jobs stay hidden until the certificate is approved.';

  @override
  String get wskillServicesTitle => 'Services Offered';

  @override
  String get wskillHiddenTag => 'HIDDEN';

  @override
  String get wskillCertsTitle => 'Professional Certificates';

  @override
  String get wskillCertExpired => 'EXPIRED';

  @override
  String get wskillCertApproved => 'APPROVED';

  @override
  String get wskillCertPending => 'PENDING';

  @override
  String get wskillUploadCta => '+ Upload Certificate';

  @override
  String get wcertTitle => 'Upload Certificate';

  @override
  String get wcertTypeTitle => 'Certificate Type';

  @override
  String get wcertTypeHeight => 'Work-at-height safety';

  @override
  String get wcertTypeAc => 'Daikin AC technician';

  @override
  String get wcertTypeOther => 'Other professional certificate';

  @override
  String get wcertPhotoTitle => 'Certificate Photo';

  @override
  String get wcertPhotoTapToUpload => '+ Photo of the front';

  @override
  String get wcertPhotoAttached => 'Photo attached · Tap to change';

  @override
  String get wcertExpiryTitle => 'Expiry Date';

  @override
  String get wcertSubmitCta => 'Submit for Review';

  @override
  String get wcertSubmittedSuccess =>
      'Certificate submitted for review. Results within 48 hours.';

  @override
  String get wperfTitle => 'Performance';

  @override
  String get wperfRatingSubtitle => '128 reviews · last 30 days';

  @override
  String get wperfAcceptRate => 'Acceptance rate';

  @override
  String get wperfAcceptDesc =>
      'Jobs you accepted out of jobs offered. Target 90%+.';

  @override
  String get wperfCompRate => 'Completion rate';

  @override
  String get wperfCompDesc =>
      'Accepted jobs finished without cancelling. Target 95%+.';

  @override
  String get wperfOnTimeRate => 'On-time check-in';

  @override
  String get wperfOnTimeDesc =>
      'Checked in at or before the booked time. Target 90%+.';

  @override
  String get wperfWarrantyRate => 'Warranty rate';

  @override
  String get wperfWarrantyDesc =>
      'Jobs that needed a warranty visit. Lower is better; keep under 5%.';

  @override
  String get wperfBadgesTitle => 'Earned Badges';

  @override
  String get wperfBadgePunctual => 'Punctual';

  @override
  String get wperfBadgePunctualDesc => '30 days on time';

  @override
  String get wperfBadge100 => '100 jobs';

  @override
  String get wperfBadge100Desc => '128 jobs completed';

  @override
  String get wperfBadgeFav => 'Customer favourite';

  @override
  String get wperfBadgeFavDesc => 'Saved by 24 customers';

  @override
  String get wperfBadgeNoComplaint => 'Complaint-free';

  @override
  String get wperfBadgeNoComplaintDesc => 'Needs 30 days without complaints';

  @override
  String get wprofileTitle => 'Partner Profile';

  @override
  String wprofileWorkerId(String id) {
    return 'Partner ID: $id';
  }

  @override
  String get wprofileMenuSkills => 'Skills & certificates';

  @override
  String get wprofileMenuZone => 'Work zone';

  @override
  String get wprofileMenuSchedule => 'Work schedule';

  @override
  String get wprofileMenuPerf => 'Performance';

  @override
  String get wprofileMenuPayout => 'Payout account';

  @override
  String get wprofileLogoutCta => 'Log out Worker Account';

  @override
  String get wprofileLogoutDialogTitle => 'Log out of Worker Account?';

  @override
  String get wprofileLogoutDialogBody =>
      'You will not receive new job alerts until you log back in.';
}
