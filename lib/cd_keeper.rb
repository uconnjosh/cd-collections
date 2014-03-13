require './lib/compact_disk'

class Cd_keeper
  attr_reader :name, :description, :cds

  @@collections = []

  def Cd_keeper.collections
    @@collections
  end

  def Cd_keeper.create(name, description)
    new_collection = Cd_keeper.new({:name => name, :description => description})
    @@collections << new_collection
    new_collection
  end

  def initialize(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @cds = []
  end

  def add_cd(album_name, artist)
    @cds << Compact_disk.new({:album_name => album_name, :artist => artist})
  end

  def search_artist(artist_name)
    matched_artists = []
    @cds.collect do |cd|
      if cd.artist == artist_name
        matched_artists << cd.album_name
      end
    end
    matched_artists
  end

  def search_album(album_name)
    @cds.find  {|cd| cd.album_name == album_name}
  end
end
