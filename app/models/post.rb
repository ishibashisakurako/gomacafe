class Post < ApplicationRecord
  has_one_attached :image

  enum status: { draft: 0, publish: 1, secret: 2 }

  scope :draft_posts, -> { where(status: 'draft') }
  scope :publish_posts, -> { where(status: 'publish') }
  scope :secret_posts, -> { where(status: 'secret') }

  validates :title, presence: true
  validates :material, presence: true
  validates :recipe, presence: true

  belongs_to :user
  has_many :post_comments, dependent: :destroy #コメントと1:Nの関係
  has_many :favorites, dependent: :destroy

  belongs_to :genre, optional: true
  belongs_to :other, optional: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
    end
    

    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
    end

    def self.looks(word)
      if word
        Post.where(['title LIKE ?', "%#{word}%"])

      else
        @post = Post.all
      end
    end

end
