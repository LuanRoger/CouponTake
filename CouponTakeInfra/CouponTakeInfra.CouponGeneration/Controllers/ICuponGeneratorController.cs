namespace CouponTakeInfra.CouponGeneration.Controllers;

public interface ICouponGeneratorController
{
    public Task<Guid> GenerateCoupon(int id);
}