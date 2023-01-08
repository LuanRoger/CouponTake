using CuponTakeInfra.CuponGeneration.Exceptions;
using CuponTakeInfra.Db.Models;
using CuponTakeInfra.Db.Repositories;

namespace CuponTakeInfra.CuponGeneration.Controllers;

public class PointsController : IPointsController
{
    private MainClusterDb _mainClusterDb { get; }

    public PointsController(MainClusterDb mainClusterDb)
    {
        _mainClusterDb = mainClusterDb;
    }
    
    public async Task AlterPoints(int userId, int quantity)
    {
         UserDbModel? foundedUser = await _mainClusterDb.users
             .FindAsync(userId);
         if(foundedUser is null)
             throw new UserNotRegisteredException(userId);
         
        foundedUser.points += quantity;
        await _mainClusterDb.SaveChangesAsync();
    }
}