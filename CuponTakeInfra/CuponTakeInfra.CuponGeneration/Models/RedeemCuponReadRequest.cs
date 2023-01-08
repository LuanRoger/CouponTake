namespace CuponTakeInfra.CuponGeneration.Models;

public class RedeemCuponReadRequest
{
    public string redeemProtocol { get; init; }
    public required CuponRead redeemCupon { get; init; }
    public required UserRead redeemBy { get; init; }
}