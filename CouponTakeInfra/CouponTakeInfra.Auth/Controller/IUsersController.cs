using CouponTakeInfra.Auth.Models;

namespace CouponTakeInfra.Auth.Controller;

public interface IUsersController
{
    public Task<string> RegisterUser(UserRegisterBody user);
    public Task<UserReadResponse?> GetUserInfo(int id);
}