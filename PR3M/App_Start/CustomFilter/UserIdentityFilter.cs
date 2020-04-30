using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PR3M.App_Start.CustomFilter
{
    public class UserIdentityFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            string filterRouteDataValue = filterContext.RouteData.Values["Controller"].ToString();
            if ("/home/index/".Contains(filterContext.HttpContext.Request.Url.AbsolutePath.ToLower())
                || filterRouteDataValue.Equals("Home")
                || filterRouteDataValue.Contains("Public")
                || filterContext.RouteData.Values["Controller"].ToString().Equals("Account")
                || filterContext.HttpContext.Session["currentUser"] != null) return;
            //filterContext?.HttpContext.Response.Redirect("");
            filterContext.Result = new RedirectResult("/Account/Login");
            //"returnUrl=" + filterContext.HttpContext.Request?.Url?.AbsoluteUri ?? "/");
            base.OnActionExecuting(filterContext);
        }
    }
}