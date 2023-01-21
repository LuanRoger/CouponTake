namespace CouponTakeInfra.CouponGeneration.Exceptions;

public class NotEnughPointsException : Exception
{
    private const string MESSAGE = "The user does't has enugh points to request a coupon.";

    public NotEnughPointsException() : base(MESSAGE) { }
}