using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CuponTakeInfra.Db.Models;

[Table("Cupons")]
public class CuponDbModel
{
    [Key]
    [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
    [Column("ID", Order = 0)]
    public int id { get; set; }
    
    [Required]
    [Column("CuponCode", Order = 1)]
    public string cuponCode { get; set; }

    [Required]
    [Column("Owner", Order = 2)]
    public UserDbModel owner { get; set; }
    
    [Required]
    [Column("CreatedAt", Order = 3)]
    public DateTime createdAt { get; set; }
}