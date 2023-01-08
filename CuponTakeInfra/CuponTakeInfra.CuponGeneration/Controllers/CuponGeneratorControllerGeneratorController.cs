using CuponTakeInfra.CuponGeneration.Exceptions;
using CuponTakeInfra.Db.Models;
using CuponTakeInfra.Db.Repositories;

namespace CuponTakeInfra.CuponGeneration.Controllers;

public class CuponGeneratorController : ICuponGeneratorController
{
    private MainClusterDb _mainClusterDb { get; }
    private ICuponHistoryController _historyController { get; }
    
    public CuponGeneratorController(MainClusterDb mainClusterDb, ICuponHistoryController historyController)
    {
        _mainClusterDb = mainClusterDb;
        _historyController = historyController;
    }
    
    public async Task<Guid> GenerateCupon(int id)
    {
        const int cuponPrice = 100;
            
        UserDbModel? requestedBy = await _mainClusterDb.users.FindAsync(id);
        if(requestedBy is null)
            throw new UserNotRegisteredException(id);
        if(requestedBy.points < cuponPrice)
            throw new NotEnughPointsException();
        
        Guid cuponCode = Guid.NewGuid();
        CuponDbModel cuponDbModel = new()
        {
            cuponCode = cuponCode.ToString(),
            createdAt = DateTime.Now,
            owner = requestedBy
        };

        _mainClusterDb.cupons.Add(cuponDbModel);
        requestedBy.points -= cuponPrice;
        
        int recordedEntites = await _mainClusterDb.SaveChangesAsync();
        if(recordedEntites > 0)
            await _historyController.RegisterCuponRedeem(cuponDbModel, requestedBy);

        return cuponCode;
    }
}