using CuponTakeInfra.CuponGeneration.Models;
using CuponTakeInfra.Db.Models;
using CuponTakeInfra.Db.Repositories;
using Microsoft.EntityFrameworkCore;

namespace CuponTakeInfra.CuponGeneration.Controllers;

public class CuponHistoryController : ICuponHistoryController
{
    private MainClusterDb _mainClusterDb { get; }
    
    public CuponHistoryController(MainClusterDb mainClusterDb)
    {
        _mainClusterDb = mainClusterDb;
    }

    public async Task RegisterCuponRedeem(CuponDbModel cupon, UserDbModel user)
    {
        RedeemCuponHistory redeemCuponHistory = new()
        {
            redeemProtocol = Guid.NewGuid().ToString(),
            redeemCupon = cupon,
            redeemBy = user
        };
        
        await _mainClusterDb.redeemCuponHistory.AddAsync(redeemCuponHistory);
        await _mainClusterDb.SaveChangesAsync();
    }

    public async Task<List<RedeemCuponReadRequest>> GetHistoryFromUserId(int id, int page, int limitPerPage = 10)
    {
        if(page < 1)
            throw new("The page number can't be less than 1");
        
        List<RedeemCuponReadRequest> userCupons = await _mainClusterDb.redeemCuponHistory
            .Where(cuponRecord => cuponRecord.redeemBy.id == id)
            .Skip(limitPerPage * page - limitPerPage)
            .Take(limitPerPage)
            .Select(cuponHistoryDbRecord => new RedeemCuponReadRequest
            {
                redeemProtocol = cuponHistoryDbRecord.redeemProtocol,
                redeemCupon = new()
                {
                    cuponCode = cuponHistoryDbRecord.redeemCupon.cuponCode,
                    createdAt = cuponHistoryDbRecord.redeemCupon.createdAt
                },
                redeemBy = new()
                {
                    username = cuponHistoryDbRecord.redeemBy.username
                }
            })
            .ToListAsync();

        return userCupons;
    }
}