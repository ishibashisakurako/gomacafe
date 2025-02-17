# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

genre_names = %w(
  バレンタイン
  クリスマス
  ハロウィン
  誕生日
  春
  夏
  秋
  冬
)

genre_names.each { |name| Genre.find_or_create_by(name: name) }

other_names = %w(
  簡単、初心者向け
  アレルギー対応
  オーブン不使用
)

other_names.each { |name| Other.find_or_create_by(name: name) }

