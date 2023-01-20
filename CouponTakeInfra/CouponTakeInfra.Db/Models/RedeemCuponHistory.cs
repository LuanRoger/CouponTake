using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CouponTakeInfra.Db.Models;

[Table("RedeemCouponHistory")]
public class RedeemCouponHistory
{
    [Key]
    [Required]
    [Column("Protocol", Order = 0)]
    public string redeemProtocol { get; set; }

    [Required]
    [Column("Coupon", Order = 1)]
    public CouponDbModel redeemCoupon { get; set; }
    
    [Required]
    [Column("RedeemBy", Order = 2)]
    public UserDbModel redeemBy { get; set; }
}