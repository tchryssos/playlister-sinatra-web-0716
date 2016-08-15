require 'pry'

class Artist<ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

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
