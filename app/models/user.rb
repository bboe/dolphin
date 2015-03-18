class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  validates_presence_of :email, :name, :image_url, :provider, :uid
  validates_uniqueness_of :email
  validates_uniqueness_of :uid, scope: :provider

  has_many :dolphins_sent, class_name: :Dolphin, foreign_key: :from_id
  has_many :dolphins_received, class_name: :Dolphin, foreign_key: :to_id

  def self.find_for_google_oauth2(access_token)
    if ENV["GOOGLE_CLIENT_DOMAIN"] && ENV["GOOGLE_CLIENT_DOMAIN"] != access_token.extra.raw_info.hd
      return
    end

    id_args = {provider: access_token.provider, uid: access_token.uid}
    info_args = {name: access_token.info.name, email: access_token.info.email,
                 image_url: access_token.info.image}

    if user = User.find_by(**id_args)
      user.update_attributes(**info_args)
    else
      user = User.create(**info_args.merge!(id_args))
    end

    user
  end

  def normed_image_url
    if image_url == 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=50'
      ''
    else
      image_url
    end
  end
end
