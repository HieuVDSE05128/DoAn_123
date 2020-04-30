using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(PR3M.Startup))]
namespace PR3M
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
