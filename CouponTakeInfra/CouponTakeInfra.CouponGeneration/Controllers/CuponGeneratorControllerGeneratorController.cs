using CouponTakeInfra.CouponGeneration.Exceptions;
using CouponTakeInfra.Db.Models;
using CouponTakeInfra.Db.Repositories;

namespace CouponTakeInfra.CouponGeneration.Controllers;

public class CouponGeneratorController : ICouponGeneratorController
{
    private MainClusterDb _mainClusterDb { get; }
    private ICouponHistoryController _historyController { get; }
    
    public CouponGeneratorController(MainClusterDb mainClusterDb, ICouponHistoryController historyController)
    {
        _mainClusterDb = mainClusterDb;
        _historyController = historyController;
    }
    
    public async Task<Guid> GenerateCoupon(int id)
    {
        const int couponPrice = 100;
            
        UserDbModel? requestedBy = await _mainClusterDb.users.FindAsync(id);
        if(requestedBy is null)
            throw new UserNotRegisteredException(id);
        if(requestedBy.points < couponPrice)
            throw new NotEnughPointsException();
        
        Guid couponCode = Guid.NewGuid();
        CouponDbModel couponDbModel = new()
        {
            couponCode = couponCode.ToString(),
            createdAt = DateTime.Now,
            owner = requestedBy
        };

        _mainClusterDb.coupons.Add(couponDbModel);
        requestedBy.points -= couponPrice;
        
        int recordedEntites = await _mainClusterDb.SaveChangesAsync();
        if(recordedEntites > 0)
            await _historyController.RegisterCouponRedeem(couponDbModel, requestedBy);

        return couponCode;
    }
}