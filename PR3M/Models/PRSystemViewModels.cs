using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PR3M.Models
{
    public class PRSystemViewModels
    {
    }

    public class PRSystemCreateViewModels
    {
        [Display(Name = "Tên đơn vị")]
        public string PRSystemName { get; set; }

        [Display(Name ="Tên đơn vị bằng tiếng Việt")]
        public string PRSystemVName { get; set; }

        [Display(Name ="Đơn vị được tự quyết")]
        public bool PRSystemIndependent { get; set; }
    }
}