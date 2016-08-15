class Genre<ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def slug
    slugged_name=self.name.tr(" ","-").downcase
    slugged_name
  end

  def self.find_by_slug(slug)
    unslugged_name=slug.to_s.tr("-"," ").split.map {|word| word.capitalize}.join(' ')
    # self.find_by(name:"#{unslugged_name}")
    self.where("name LIKE ?", "%#{unslugged_name}").first
  end
end
