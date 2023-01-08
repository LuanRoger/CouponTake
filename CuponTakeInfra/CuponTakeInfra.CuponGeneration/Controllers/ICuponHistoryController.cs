using CuponTakeInfra.CuponGeneration.Models;
using CuponTakeInfra.Db.Models;

namespace CuponTakeInfra.CuponGeneration.Controllers;

public interface ICuponHistoryController
{
    public Task RegisterCuponRedeem(CuponDbModel cupon, UserDbModel user);
    public Task<List<RedeemCuponReadRequest>> GetHistoryFromUserId(int id, int page, int limitPerPage);
}