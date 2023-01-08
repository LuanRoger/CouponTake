using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CuponTakeInfra.Db.Models;

[Table("RedeemCuponHistory")]
public class RedeemCuponHistory
{
    [Key]
    [Required]
    [Column("Protocol", Order = 0)]
    public string redeemProtocol { get; set; }

    [Required]
    [Column("Cupon", Order = 1)]
    public CuponDbModel redeemCupon { get; set; }
    
    [Required]
    [Column("RedeemBy", Order = 2)]
    public UserDbModel redeemBy { get; set; }
}