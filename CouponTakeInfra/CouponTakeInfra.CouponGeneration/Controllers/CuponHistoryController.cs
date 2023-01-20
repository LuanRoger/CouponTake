using CouponTakeInfra.CouponGeneration.Models;
using CouponTakeInfra.Db.Models;
using CouponTakeInfra.Db.Repositories;
using Microsoft.EntityFrameworkCore;

namespace CouponTakeInfra.CouponGeneration.Controllers;

public class CouponHistoryController : ICouponHistoryController
{
    private MainClusterDb _mainClusterDb { get; }
    
    public CouponHistoryController(MainClusterDb mainClusterDb)
    {
        _mainClusterDb = mainClusterDb;
    }

    public async Task RegisterCouponRedeem(CouponDbModel coupon, UserDbModel user)
    {
        RedeemCouponHistory redeemCouponHistory = new()
        {
            redeemProtocol = Guid.NewGuid().ToString(),
            redeemCoupon = coupon,
            redeemBy = user
        };
        
        await _mainClusterDb.redeemCouponHistory.AddAsync(redeemCouponHistory);
        await _mainClusterDb.SaveChangesAsync();
    }

    public async Task<List<RedeemCouponReadRequest>> GetHistoryFromUserId(int id, int page, int limitPerPage = 10)
    {
        if(page < 1)
            throw new("The page number can't be less than 1");
        
        List<RedeemCouponReadRequest> userCoupons = await _mainClusterDb.redeemCouponHistory
            .Where(couponRecord => couponRecord.redeemBy.id == id)
            .Skip(limitPerPage * page - limitPerPage)
            .Take(limitPerPage)
            .Select(couponHistoryDbRecord => new RedeemCouponReadRequest
            {
                redeemProtocol = couponHistoryDbRecord.redeemProtocol,
                redeemCoupon = new()
                {
                    couponCode = couponHistoryDbRecord.redeemCoupon.couponCode,
                    createdAt = couponHistoryDbRecord.redeemCoupon.createdAt
                },
                redeemBy = new()
                {
                    username = couponHistoryDbRecord.redeemBy.username
                }
            })
            .ToListAsync();

        return userCoupons;
    }
}