using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PR3M.DBModel.DAO
{
    public class PostDAO
    {

        public bool ChangePostionUpOfPost(PRConnect db, int id)
        {
            var post = db.Posts.Find(id);
            //neu position of material la min (nho nhat la 1) trong position thi tra ve false
            //1. get min
            int minPosition = db.Posts.Where(p => p.IsInLogoPost == post.IsInLogoPost && p.PostId != 0).Min(p => p.Position);
            //2. compare min
            if (post.Position > minPosition)
            {
                //tìm ra bản ghi có position gần nhất với bản ghi hiện tại
                //=> tìm ra bản ghi có position lớn nhất trong những bản ghi có position < position đang xử lý (Phải cùng 1 loại post)
                var postSelectToChange = db.Posts.Where(p => p.IsInLogoPost == post.IsInLogoPost && p.PostId != 0).OrderByDescending(p => p.Position).First(p => p.Position < post.Position);
                //Trường hợp tìm được
                if (postSelectToChange != null)
                {
                    //Đổi 2 giá trị position cho nhau
                    int temp = post.Position;
                    post.Position = postSelectToChange.Position;
                    postSelectToChange.Position = temp;
                    //Lưu lại trong DB
                    db.SaveChanges();
                    //Trả về kết quả true
                    return true;
                }
            }
            //Trong mọi trường hợp khác đều trả về false
            return false;
        }

        public bool ChangePostionDownOfPost(PRConnect db, int id)
        {
            var post = db.Posts.Find(id);
            //neu position of material la max trong position thi tra ve false
            //1. get min
            int maxPosition = db.Posts.Where(p => p.IsInLogoPost == post.IsInLogoPost && p.PostId != 0).Max(p => p.Position);
            //2. compare min
            if (post.Position < maxPosition)
            {
                //tìm ra bản ghi có position gần nhất với bản ghi hiện tại
                //=> tìm ra bản ghi có position lớn nhất trong những bản ghi có position < position đang xử lý (Phải cùng 1 loại post)
                var postSelectToChange = db.Posts.Where(p => p.IsInLogoPost == post.IsInLogoPost && p.PostId != 0).OrderBy(p => p.Position).First(p => p.Position > post.Position);
                //Trường hợp tìm được
                if (postSelectToChange != null)
                {
                    //Đổi 2 giá trị position cho nhau
                    int temp = post.Position;
                    post.Position = postSelectToChange.Position;
                    postSelectToChange.Position = temp;
                    //Lưu lại trong DB
                    db.SaveChanges();
                    //Trả về kết quả true
                    return true;
                }
            }
            //Trong mọi trường hợp khác đều trả về false
            return false;
        }
    }
}