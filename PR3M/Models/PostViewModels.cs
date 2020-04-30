using PR3M.DBModel;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace PR3M.Models
{
    public class PostPublishedViewModels
    {
        public IEnumerable<Post> post { get; set; }
        public Post logo { get; set; }
    }

    public class PostCreateViewModels
    {
        [Required]
        [Display(Name = "Title")]
        public string PostTitle { get; set; }

        [Display(Name = "English Title")]
        public string PostEngTitle { get; set; }

        [Required]
        [Display(Name = "Campus/System")]
        public int PRSystemId { get; set; }
    }

    public class PostLogoCreateViewModels
    {
        [Required]
        [Display(Name = "Title")]
        public string PostTitle { get; set; }

        [Required]
        [Display(Name = "Campus/System")]
        public int PRSystemId { get; set; }
    }

    public class PostLogoEditViewModel
    {
        [Required]
        public int PostId { get; set; }

        public string PostTitle { get; set; }

        public string PostEngTitle { get; set; }

        public bool IsPublic { get; set; }
    }

    public class PostEditViewModel
    {
        [Required]
        public int PostId { get; set; }

        public string PostTitle { get; set; }

        public string PostEngTitle { get; set; }

        public bool IsPublic { get; set; }

        public IEnumerable<Material> Materials { get; set; }

        public bool IsLogo { get; set; }
    }

    public class PostLogoChooseAvatarImageViewModel
    {
        public int PostId { get; set; }
        public IEnumerable<Material> ImageForLogoChoose { get; set; }

        public int? MaterialChoose { get; set; }

    }


}