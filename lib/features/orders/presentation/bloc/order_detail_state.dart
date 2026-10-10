part of 'order_detail_cubit.dart';

@immutable
sealed class OrderDetailState {
  const OrderDetailState();
}

final class OrderDetailInitialState extends OrderDetailState {
  const OrderDetailInitialState();
}

final class OrderDetailLoadingState extends OrderDetailState {
  const OrderDetailLoadingState();
}

final class OrderDetailLoadedState extends OrderDetailState {
  const OrderDetailLoadedState(this.booking, {this.serviceName});

  final Booking booking;
  final String? serviceName;

  @override
  bool operator ==(Object other) =>
      other is OrderDetailLoadedState && other.booking == booking && other.serviceName == serviceName;

  @override
  int get hashCode => Object.hash(booking, serviceName);
}

final class OrderDetailErrorState extends OrderDetailState {
  const OrderDetailErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is OrderDetailErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
