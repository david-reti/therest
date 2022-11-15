# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ENV['seeding'] = 'true'

Permission.create [
    { permission_type: :create_article },
    { permission_type: :edit_own_article },
    { permission_type: :edit_all_articles },
    { permission_type: :delete_own_article },
    { permission_type: :delete_all_articles },
    { permission_type: :create_comment },
    { permission_type: :edit_own_comment },
    { permission_type: :edit_all_comments },
    { permission_type: :delete_own_comment },
    { permission_type: :delete_all_comments }
]

Role.create [
    {   name: 'Admin',
        permissions: [ 
            Permission.create_article.first,
            Permission.edit_all_articles.first, 
            Permission.delete_all_articles.first, 
            Permission.create_comment.first, 
            Permission.edit_own_comment.first,
            Permission.edit_all_comments.first, 
            Permission.delete_all_comments.first 
        ]
    },
    {
        name: 'Reader',
        permissions: [
            Permission.create_comment.first,
            Permission.edit_own_comment.first,
            Permission.delete_own_comment.first
        ]
    }
]

User.create(name: Rails.application.credentials.admin.name, 
            email: Rails.application.credentials.admin.email,
            biography: Rails.application.credentials.admin.biography || "Admin User",
            password_digest: Rails.application.credentials.admin.password_digest,
            roles: [ Role.find_by(name: 'Admin') ])

City.create [
    { name: "Toronto" },
]

Cuisine.create [
    { name: "International" }
    { name: "Japanese" }
]

ENV.delete 'seeding'