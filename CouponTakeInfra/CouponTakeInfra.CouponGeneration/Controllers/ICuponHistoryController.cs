using CouponTakeInfra.CouponGeneration.Models;
using CouponTakeInfra.Db.Models;

namespace CouponTakeInfra.CouponGeneration.Controllers;

public interface ICouponHistoryController
{
    public Task RegisterCouponRedeem(CouponDbModel coupon, UserDbModel user);
    public Task<List<RedeemCouponReadRequest>> GetHistoryFromUserId(int id, int page, int limitPerPage);
}