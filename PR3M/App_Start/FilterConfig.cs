using PR3M.App_Start.CustomFilter;
using System.Web;
using System.Web.Mvc;

namespace PR3M
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());

            filters.Add(new UserIdentityFilter());
        }
    }
}
