using CouponTakeInfra.Db.Models;
using Microsoft.EntityFrameworkCore;

namespace CouponTakeInfra.Db.Repositories;

public class MainClusterDb : DbContext
{
    public DbSet<UserDbModel> users { get; set; }
    public DbSet<CouponDbModel> coupons { get; set; }
    public DbSet<RedeemCouponHistory> redeemCouponHistory { get; set; }
    
    public MainClusterDb(DbContextOptions<MainClusterDb> options) : 
        base(options) { }
}