class Song<ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

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
