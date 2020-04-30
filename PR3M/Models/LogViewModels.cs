using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PR3M.Models
{
    public class LogViewModels
    {
        [Key]
        [Required]
        public int LogId { get; set; }
        public string UsernameId { get; set; }
        [Display(Name = "Tên")]
        public string UserFullName { get; set; }
        [Display(Name = "Tài nguyên")]
        public string ObjectName { get; set; }
        [Display(Name = "Loại")]
        public string ObjectType { get; set; }
        [Display(Name = "Hành động")]
        public string ActionName { get; set; }
        [Display(Name = "Thời gian")]
        public DateTime ActionTime { get; set; }

    }




}