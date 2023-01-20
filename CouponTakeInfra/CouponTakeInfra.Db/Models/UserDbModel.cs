using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CouponTakeInfra.Db.Models;

[Table("Users")]
public class UserDbModel
{
    [Required]
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("ID", Order = 0)]
    public int id { get; set; }
    
    [Required]
    [MaxLength(50)]
    [Column("Username", Order = 1)]
    public string username { get; set; }
    
    [Required]
    [MaxLength(90)]
    [Column("Password", Order = 2)]
    public string password { get; set; }
    
    [Required]
    [Column("Points", Order = 3)]
    public int points { get; set; }
}