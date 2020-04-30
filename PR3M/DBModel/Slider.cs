namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Slider")]
    public partial class Slider
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int SliderId { get; set; }

        [Required]
        [StringLength(50)]
        public string SliderName { get; set; }

        public bool IsDelete { get; set; }
    }
}
