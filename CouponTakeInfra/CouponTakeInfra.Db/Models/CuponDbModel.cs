using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CouponTakeInfra.Db.Models;

[Table("Coupons")]
public class CouponDbModel
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("ID", Order = 0)]
    public int id { get; set; }
    
    [Required]
    [Column("CouponCode", Order = 1)]
    public string couponCode { get; set; }

    [Required]
    [Column("Owner", Order = 2)]
    public UserDbModel owner { get; set; }
    
    [Required]
    [Column("CreatedAt", Order = 3)]
    public DateTime createdAt { get; set; }
}