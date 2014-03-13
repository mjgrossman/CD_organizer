require './lib/artist'
require './lib/album'


def main_menu
  puts "Press 'a' to add a new album or press 'v' to view all albums"
  puts "Press 's' to search for an album by artist name"
  puts "Press 'l' to list out all artists"
  puts "Press 'x' to exit."
  user_input = gets.chomp

  if user_input == 'a'
    add_album
  elsif user_input == 's'
    search_artist
  elsif user_input == 'v'
    view_albums
  elsif user_input == 'l'
    list_menu
  elsif user_input == 'x'
    'Good-bye.'
  else
    'Invalid Choice.'
    main_menu
  end
end

def list_menu
  Artist.all.each_with_index do |artist, index|
    puts "#{index + 1}) #{artist.name}"
  end
  puts "Which artist do you want to see the albums of"
  user_input = gets.chomp
  puts Artist.all[user_input.to_i - 1].titles
  main_menu
end


def view_albums
  Album.all.each do |album|
    puts "#{album.artist.name} - #{album.title}"
  end
  main_menu
end

def search_artist
  puts "Enter the artist name to find all albums:"
  user_input = gets.chomp

  found = Album.search(user_input)
  found.each do |album|
    puts "#{album.artist.name} - #{album.title}"
  end
end


def add_album
  puts 'Enter the artist name:  '
  input_artist = gets.chomp
  puts 'Enter the album name: '
  input_album_name = gets.chomp

  if Artist.all.empty?
    new_artist = Artist.create({:name => input_artist})
    new_album = Album.create({:artist => new_artist, :title => input_album_name})
    new_artist.add_title(new_album.title)
    main_menu
  else
    found = Artist.all.find {|x| x.name == input_artist}
    if found.nil?
      new_artist = Artist.create({:name => input_artist})
      new_album = Album.create({:artist => new_artist, :title => input_album_name})
      new_artist.add_title(new_album.title)
    else
      new_album = Album.create({:artist => found, :title => input_album_name})
      found.add_title(new_album.title)
    end
  end

  # Artist.all.each do |artist|
  #   p artist.name
  #   p artist.titles
  # end
  main_menu
end

main_menu




