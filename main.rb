require './lib/cd_keeper'
def main_menu
  puts "Hello!!! Welcome!\n
       Press C to create an album collection\n
       Press L to view your album collection\n
       Press W to work with a collection\n
       Press X to exit\n"
  main_response = gets.chomp.upcase
  case main_response
  when 'C'
    add_collection
    main_menu
  when 'L'
    list_collections
    main_menu
  when 'W'
    puts 'choose the collection to work with:'
    Cd_keeper.collections.each_with_index do |collection, index|
      puts "#{index + 1}. #{collection.name}"
    end

    collection_menu(Cd_keeper.collections[gets.chomp.to_i - 1])
  when 'X'
    puts "GoodBye!!!"
  else
    'Please enter a valid choice!'
    main_menu
  end
end


def add_collection
    puts 'Enter a name for your CD collection:'
    name = gets.chomp
    puts 'Okay, now enter a description for your CD collection:'
    description = gets.chomp
    new_collection = Cd_keeper.create(name, description)
end

def list_collections
  puts 'Here are all of your music collections:'
  Cd_keeper.collections.each do |collection|
    puts collection.name
  end
  main_menu
end

def collection_menu(collection)
  puts "Please choose from the following options:\n
        Press L to list all the CDs in this collection.\n
        Press S to search for an album or an artist.\n
        Press A to add a CD.\n
        Press M to return to the Collections Menu.\n"
  user_response = gets.chomp.upcase
  case user_response
  when 'L'
    collection.cds.each do |cd|
      puts "#{cd.album_name} by #{cd.artist}"
    end
    collection_menu(collection)
  when 'S'
    puts "Press 1 to search by artist, or 2 for album"
    artist_or_album = gets.chomp
    if artist_or_album == '1'
      puts "Enter the artist's name:"
      collection.search_artist(gets.chomp).each do |album_name|
        puts album_name
      end
      collection_menu(collection)
    elsif artist_or_album == '2'
      puts 'Enter the album name to search'
      found = collection.search_album(gets.chomp.upcase)
      begin
      puts "Found: #{found.album_name} by #{found.artist}"
      rescue
        puts "Sorry, can't find that!"
      end
      collection_menu(collection)
    end

  when 'A'
    puts 'Enter an album name'
    album_name = gets.chomp.upcase
    puts "Got it! Now enter the artist's name"
    artist = gets.chomp.upcase
    collection.add_cd(album_name, artist)
    puts "Album added!"
    collection_menu(collection)
  when 'M'
    main_menu
  else
    puts "Please choose a valid option:\n"
    collection_menu(collection)
  end
end

main_menu

