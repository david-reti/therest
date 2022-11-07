class User < ApplicationRecord
  has_many :articles
  has_and_belongs_to_many :roles
  has_many :permissions, through: :roles
  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: :password_digest_changed?
  validates :roles, length: { minimum: 1 }
  
  has_one_attached :profile_picture

  # Checks if the user has permission to carry out an operation - will return true if the user
  # has the ability to carry out an action on an object they own, or all objects of a particular type
  # permission_type should be a type of permission, like :edit or :create, and object should be an
  # instance of a model like @article
  # Alternatively, pass a full permission type like :create_article to check for it directly
  def has_permission_to(permission_type, object = nil)
    return permissions.find_by permission_type: "#{permission_type}" unless object.present?

    if permission_type == :create
      return permissions.find_by permission_type: "create_#{object.class.name}"
    else
      own_permission = permissions.find_by permission_type: "#{permission_type}_own_#{object.class.name.downcase}"
      
      return true if own_permission.present? && object.user == self
      Rails.logger.debug object.present?
      return permissions.find_by(permission_type: "#{permission_type}_all_#{object.class.name.downcase}s").present?
    end

    Rails.logger.warn "Unknown object type for permission check: #{object.class.name}"
    return false
  end
end
