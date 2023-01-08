namespace CuponTakeInfra.CuponGeneration.Controllers;

public interface ICuponGeneratorController
{
    public Task<Guid> GenerateCupon(int id);
}