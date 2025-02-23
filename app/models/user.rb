class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :columns, dependent: :destroy

  has_many :posts, dependent: :destroy

  has_many :post_comments, dependent: :destroy

  has_one_attached :profile_image

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  validates :name, presence: true

#active_relationships(activeは活動的 フォローしているuserと関連づける foreign_key(外部キー)はフォロワー、連動したら削除)
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
#passive_relationships(passiveは受け身 フォローされているuserと関連づける foreign_key(外部キー)はフォロー、連動したら削除)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

#フォローしたuserを取得　throuth(これを通して)active_relationshipsを通して/source(源) フォローされたuser
  has_many :followings, through: :active_relationships, source: :followed
#フォローされたuserを取得　throuth(これを通して)passive_relationshipsを通して/source(源) フォローしたuser
  has_many :followers, through: :passive_relationships, source: :follower

#指定したuserをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

#指定したユーザーのフォローを解除
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

#指定したuserをフォローしているか判定(真偽で trueとかのやつ？) include(含む)
  def following?(user)
    followings.include?(user)
  end


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(word)
    if word
      User.where(['name LIKE ?', "%#{word}%"])
    
    else
      User.all
    end
  end

   

end