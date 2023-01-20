namespace CouponTakeInfra.CouponGeneration.Controllers;

public interface IPointsController
{
    public Task AlterPoints(int userId, int quantity);
}