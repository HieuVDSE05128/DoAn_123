using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using PR3M.DBModel;
namespace PR3M.Models
{
    public class HomeViewModels
    {
        public IEnumerable<Post> Posts { get; set; }

        public IEnumerable<Post> LogoPost { get; set; }

        public List<LogoAvartarImage> LogoImage { get; set; }
    }

    public class HomeSearchViewModels
    {
        public int ObjectSearchId { get; set; }
        public string ObjectSearchDisplayName { get; set; }
        public int ObjectSearchType { get; set; }
        public string ObjectSearchImageDisplay { get; set; }
        public int ObjectTypeHandle { get; set; }
    }

    public class HomePartialViewModels
    {
        public Post Post { get; set; }
        public IEnumerable<Material> Materials { get; set; }

    }

}