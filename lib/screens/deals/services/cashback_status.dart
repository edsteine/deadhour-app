enum CashbackStatus {
  pending, // Transaction completed, cashback processing
  confirmed, // Cashback confirmed, will be available after waiting period
  available, // Ready for withdrawal/use
  used, // Cashback has been used
  expired, // Cashback expired (unused after 1 year)
}