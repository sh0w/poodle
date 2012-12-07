class User < ActiveRecord::Base
  has_many :activities
  has_many :comments

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable



  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :firstname, :lastname, :description, :profile_private,
                  :provider, :uid, :avatar

  has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "40x40>" }

  validates_presence_of :username, :email

  # attr_accessible :title, :body
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.new(username:auth.extra.raw_info.name.parameterize,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
      )

      # we want to make sure facebook users won't have to confirm the email address:
      user.skip_confirmation!

      user.save
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  def thumb
      image_tag @agent.avatar.url(:medium), :class => "user_thumb"
  end
end
