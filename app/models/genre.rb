class Genre < ApplicationRecord
  has_many :posts

  def index
    @genres = Genre.all
  end

end
