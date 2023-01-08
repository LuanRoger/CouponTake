namespace CuponTakeInfra.Auth.Services.Jwt.Models;

public class JwtPublicSettings : IJwtSettings
{
    public string key { get; }

    public JwtPublicSettings(string key)
    {
        this.key = key;
    }
}