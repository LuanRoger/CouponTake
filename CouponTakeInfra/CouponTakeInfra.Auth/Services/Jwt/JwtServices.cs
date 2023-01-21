using System.Security.Claims;
using System.Security.Cryptography;
using CouponTakeInfra.Auth.Services.Jwt.Models;
using Microsoft.IdentityModel.JsonWebTokens;
using Microsoft.IdentityModel.Tokens;

namespace CouponTakeInfra.Auth.Services.Jwt;

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
            Issuer = "CouponTakeInfraAuthService",
            IssuedAt = DateTime.Now,
            Audience = "CouponTakeInfra"
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