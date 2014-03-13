class Compact_disk
  attr_reader :album_name, :artist

  def initialize(attributes)
    @album_name = attributes[:album_name]
    @artist = attributes[:artist]
  end
end
