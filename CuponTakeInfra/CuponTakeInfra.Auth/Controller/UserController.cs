using CuponTakeInfra.Auth.Exceptions;
using CuponTakeInfra.Auth.Models;
using CuponTakeInfra.Auth.Services.Jwt;
using CuponTakeInfra.Auth.Services.Security;
using CuponTakeInfra.Db.Models;
using CuponTakeInfra.Db.Repositories;

namespace CuponTakeInfra.Auth.Controller;

public class UserController : IUsersController
{
    private MainClusterDb _mainClusterDb { get; }
    private JwtServices _jwtServices { get; }
    
    public UserController(MainClusterDb mainClusterDb, JwtServices jwtServices)
    {
        _mainClusterDb = mainClusterDb;
        _jwtServices = jwtServices;
    }

    public async Task<string> RegisterUser(UserRegisterBody user)
    {
        List<UserDbModel> repeatedUsers = _mainClusterDb.users
            .Where(dbUser => dbUser.username == user.username).ToList();
        if(repeatedUsers.Count > 0)
            throw new SameUserNameException(user.username);
        
        RelatedInformation userInformation = new();
        userInformation.AddInformation(user.username);
        string hashedPassword = SecurityService.GenerateHash(user.password, userInformation);
        UserDbModel dbModel = new()
        {
            username = user.username,
            password = hashedPassword
        };

        var userDbEntry = await _mainClusterDb.users.AddAsync(dbModel).AsTask();
        await _mainClusterDb.SaveChangesAsync();
        
        return _jwtServices.GenerateToken(userDbEntry.Entity.id);
    }

    public async Task<UserReadResponse?> GetUserInfo(int id)
    {
        UserDbModel? userDbModel = await _mainClusterDb.users.FindAsync(id);
        if(userDbModel is null) 
            return null;
        
        return new()
        {
            username = userDbModel.username,
            points = userDbModel.points
        };
    }
}