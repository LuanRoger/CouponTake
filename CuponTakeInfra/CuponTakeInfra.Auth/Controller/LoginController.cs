using CuponTakeInfra.Auth.Models;
using CuponTakeInfra.Auth.Services.Jwt;
using CuponTakeInfra.Auth.Services.Security;
using CuponTakeInfra.Db.Models;
using CuponTakeInfra.Db.Repositories;
using Microsoft.EntityFrameworkCore;

namespace CuponTakeInfra.Auth.Controller;

public class LoginController : ILoginController
{
    private MainClusterDb _mainClusterDb { get; }
    private JwtServices _jwtServices { get; }

    public LoginController(MainClusterDb mainClusterDb, JwtServices jwtServices)
    {
        _mainClusterDb = mainClusterDb;
        _jwtServices = jwtServices;
    }
    
    public async Task<string?> AuthenticateUser(UserLoginBody user)
    {
        UserDbModel? foundedUser = await _mainClusterDb.users
            .FirstOrDefaultAsync(dbUser => dbUser.username == user.username);
        if(foundedUser is null) return null;
        
        RelatedInformation relatedInformation = new();
        relatedInformation.AddInformation(foundedUser.username);
        bool valid = SecurityService.ValidateHash(foundedUser.password, user.password, relatedInformation);

        return valid ? _jwtServices.GenerateToken(foundedUser.id) : null;
    }
}