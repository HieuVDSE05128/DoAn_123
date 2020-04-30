using PR3M.DBModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PR3M.Models
{
    public class SliderEditViewModel
    {
        public IEnumerable<Slider> Sliders { get; set; }
        public bool IsCreateNew { get; set; }

    }
}