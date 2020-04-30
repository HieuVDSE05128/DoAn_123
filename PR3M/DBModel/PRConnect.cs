namespace PR3M.DBModel
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class PRConnect : DbContext
    {
        public PRConnect()
            : base("name=PRConnect")
        {
        }

        public virtual DbSet<FileInDB> FileInDBs { get; set; }
        public virtual DbSet<Folder> Folders { get; set; }
        public virtual DbSet<LogAction> LogActions { get; set; }
        public virtual DbSet<LogActionType> LogActionTypes { get; set; }
        public virtual DbSet<LogoAvartarImage> LogoAvartarImages { get; set; }
        public virtual DbSet<Material> Materials { get; set; }
        public virtual DbSet<Post> Posts { get; set; }
        public virtual DbSet<PRSystem> PRSystems { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<Slider> Sliders { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<FileInDB>()
                .Property(e => e.MIMEType)
                .IsUnicode(false);

            modelBuilder.Entity<FileInDB>()
                .Property(e => e.LaunchedBy)
                .IsUnicode(false);

            modelBuilder.Entity<FileInDB>()
                .Property(e => e.LastEditBy)
                .IsUnicode(false);

            modelBuilder.Entity<Folder>()
                .Property(e => e.CreateBy)
                .IsUnicode(false);

            modelBuilder.Entity<Folder>()
                .HasMany(e => e.FileInDBs)
                .WithRequired(e => e.Folder)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Folder>()
                .HasMany(e => e.Folder1)
                .WithOptional(e => e.Folder2)
                .HasForeignKey(e => e.ParrentId);

            modelBuilder.Entity<LogAction>()
                .Property(e => e.LogCreateBy)
                .IsUnicode(false);

            modelBuilder.Entity<LogActionType>()
                .Property(e => e.LogActionTypeName)
                .IsUnicode(false);

            modelBuilder.Entity<LogActionType>()
                .HasMany(e => e.LogActions)
                .WithRequired(e => e.LogActionType)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<LogoAvartarImage>()
                .Property(e => e.LastChangeBy)
                .IsUnicode(false);

            modelBuilder.Entity<Material>()
                .Property(e => e.CreateBy)
                .IsUnicode(false);

            modelBuilder.Entity<Material>()
                .Property(e => e.MaterialType)
                .IsUnicode(false);

            modelBuilder.Entity<Material>()
                .Property(e => e.MaterialMD5Encrypt)
                .IsUnicode(false);

            modelBuilder.Entity<Material>()
                .Property(e => e.MIMEType)
                .IsUnicode(false);

            modelBuilder.Entity<Material>()
                .Property(e => e.ImageAvatar)
                .IsUnicode(false);

            modelBuilder.Entity<Material>()
                .HasMany(e => e.LogoAvartarImages)
                .WithRequired(e => e.Material)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Post>()
                .Property(e => e.PostEngTitle)
                .IsUnicode(false);

            modelBuilder.Entity<Post>()
                .Property(e => e.CreateBy)
                .IsUnicode(false);

            modelBuilder.Entity<Post>()
                .HasOptional(e => e.LogoAvartarImage)
                .WithRequired(e => e.Post);

            modelBuilder.Entity<Post>()
                .HasMany(e => e.Materials)
                .WithRequired(e => e.Post)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PRSystem>()
                .Property(e => e.PRSystemName)
                .IsUnicode(false);

            modelBuilder.Entity<PRSystem>()
                .HasMany(e => e.Folders)
                .WithRequired(e => e.PRSystem)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PRSystem>()
                .HasMany(e => e.Posts)
                .WithRequired(e => e.PRSystem)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<PRSystem>()
                .HasMany(e => e.Users)
                .WithRequired(e => e.PRSystem)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Role>()
                .Property(e => e.RoleName)
                .IsUnicode(false);

            modelBuilder.Entity<Role>()
                .HasMany(e => e.Users)
                .WithRequired(e => e.Role)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Slider>()
                .Property(e => e.SliderName)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.UsernameId)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .Property(e => e.Email)
                .IsUnicode(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.FileInDBs)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.LaunchedBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.FileInDBs1)
                .WithRequired(e => e.User1)
                .HasForeignKey(e => e.LastEditBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Folders)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.CreateBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.LogoAvartarImages)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.LastChangeBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Materials)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.CreateBy)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<User>()
                .HasMany(e => e.Posts)
                .WithRequired(e => e.User)
                .HasForeignKey(e => e.CreateBy)
                .WillCascadeOnDelete(false);
        }
    }
}
