namespace CouponTakeInfra.CouponGeneration.Models;

public class RedeemCouponReadRequest
{
    public string redeemProtocol { get; init; }
    public required CouponRead redeemCoupon { get; init; }
    public required UserRead redeemBy { get; init; }
}