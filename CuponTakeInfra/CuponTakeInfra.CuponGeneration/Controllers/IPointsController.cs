namespace CuponTakeInfra.CuponGeneration.Controllers;

public interface IPointsController
{
    public Task AlterPoints(int userId, int quantity);
}