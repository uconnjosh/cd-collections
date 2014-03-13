require 'rspec'
require 'cd_keeper'

describe 'Cd_keeper' do
  it 'initialize a new cd keeper' do
    test_cd_keeper = Cd_keeper.new({:name => 'Hip Hop', :description => 'An R & B  collection'})
    test_cd_keeper.should be_an_instance_of Cd_keeper
    test_cd_keeper.name.should eq 'Hip Hop'
  end

  describe '.create' do
    it 'creates a new Cd_keeper' do
      test_keeper = Cd_keeper.create("name", "description")
      Cd_keeper.collections[0].name.should eq "name"
    end
  end

  describe '#add_cd' do
    it 'creates a new CD object' do
      test_keeper = Cd_keeper.create("jazz", "jazz hit")
      test_keeper.add_cd('Kid A', 'Radiohead')
      test_keeper.cds.length.should eq 1
    end
  end

  describe '#search_artist' do
    it 'finds album(s) by artist name' do
      test_keeper = Cd_keeper.create("Jazz", "jazz hits")
      test_keeper.add_cd('Kid A', 'Radiohead')
      test_keeper.add_cd('Thriller', 'Michael Jackson')
      test_keeper.search_artist("Radiohead").should eq ['Kid A']
    end
  end

  describe '#search_album' do
    it 'finds a cd by album name' do
      test_keeper = Cd_keeper.create("Jazz", "jazz hits")
      test_keeper.add_cd('Kid A', 'Radiohead')
      test_keeper.add_cd('Thriller', 'Michael Jackson')
      test_keeper.search_album("Kid A").artist.should eq 'Radiohead'
    end
  end
end



