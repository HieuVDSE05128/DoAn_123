namespace PR3M.DBModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("LogAction")]
    public partial class LogAction
    {
        public int LogActionId { get; set; }

        [Required]
        [StringLength(50)]
        public string LogCreateBy { get; set; }

        public int LogObjectId { get; set; }

        public int LogObjectType { get; set; }

        public int LogActionTypeId { get; set; }

        public DateTime LogActionTime { get; set; }

        public virtual LogActionType LogActionType { get; set; }
    }
}
