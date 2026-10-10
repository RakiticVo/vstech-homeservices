import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';

const acCategory = ServiceCategory(
  id: '1',
  name: 'Sửa máy lạnh',
  description: 'Sửa chữa máy lạnh các loại',
  basePrice: 200000,
);

const cleanCategory = ServiceCategory(id: '2', name: 'Vệ sinh nhà', basePrice: 150000);

const estimate = PriceEstimate(
  estimatedPrice: 500000,
  commissionFee: 50000,
  totalEstimated: 550000,
  categoryName: 'Sửa máy lạnh',
);

const hcmc = GeoPoint(10.7626, 106.6601);

final Booking pendingBooking = Booking(
  id: '501',
  status: BookingStatus.pending,
  categoryId: '1',
  estimatedPrice: 500000,
  description: 'Máy lạnh không mát',
  addressDetail: '123 Đường ABC, Quận 1',
  scheduledTime: DateTime.utc(2030, 1, 2, 7),
);

final Booking acceptedBooking = pendingBooking.copyWith(id: '502', status: BookingStatus.accepted);

final Booking completedBooking = Booking(
  id: '503',
  status: BookingStatus.completed,
  categoryId: '2',
  estimatedPrice: 300000,
  finalPrice: 320000,
  description: 'Vệ sinh tổng quát',
  addressDetail: '45 Lê Lợi',
  scheduledTime: DateTime.utc(2030, 1, 1, 2),
);

BookingPage pageOf(List<Booking> items, {int page = 0, bool hasMore = false}) =>
    BookingPage(items: items, page: page, hasMore: hasMore);

/// Draft as it looks on step 3, right before confirming.
final BookingDraft readyDraft = BookingDraft(
  categoryId: '1',
  category: acCategory,
  description: 'Máy lạnh không mát',
  estimate: estimate,
  address: '123 Đường ABC, Quận 1',
  location: hcmc,
  scheduledTime: DateTime.utc(2030, 1, 2, 7),
);
