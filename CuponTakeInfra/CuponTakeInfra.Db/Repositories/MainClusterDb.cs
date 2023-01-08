using CuponTakeInfra.Db.Models;
using Microsoft.EntityFrameworkCore;

namespace CuponTakeInfra.Db.Repositories;

public class MainClusterDb : DbContext
{
    public DbSet<UserDbModel> users { get; set; }
    public DbSet<CuponDbModel> cupons { get; set; }
    public DbSet<RedeemCuponHistory> redeemCuponHistory { get; set; }
    
    public MainClusterDb(DbContextOptions<MainClusterDb> options) : 
        base(options) { }
}