using System.Security.Claims;
using System.Security.Cryptography;
using CuponTakeInfra.Auth.Services.Jwt.Models;
using Microsoft.IdentityModel.JsonWebTokens;
using Microsoft.IdentityModel.Tokens;

namespace CuponTakeInfra.Auth.Services.Jwt;

public class JwtServices
{
    private IJwtSettings publicKeyJwtSettings { get; }
    public JwtServices(JwtPublicSettings publicKeyJwtSettings)
    {
        this.publicKeyJwtSettings = publicKeyJwtSettings;
    }
    
    public string GenerateToken(int userId)
    {
        JsonWebTokenHandler jwtHandler = new();
        string jwt = jwtHandler.CreateToken(new SecurityTokenDescriptor
        {
            Subject = new(new []
            {
                new Claim("ID", userId.ToString()),
            }),
            SigningCredentials = new(new RsaSecurityKey(CreateRsaCertificate()), 
                SecurityAlgorithms.RsaSha256),
            Expires = DateTime.Now.AddDays(1),
            Issuer = "CuponTakeInfraAuthService",
            IssuedAt = DateTime.Now,
            Audience = "CuponTakeInfra"
        });
        
        return jwt;
    }
    
    private RSA CreateRsaCertificate()
    {
        RSA key = RSA.Create();
        key.ImportFromPem(publicKeyJwtSettings.key);

        return key;
    }
}