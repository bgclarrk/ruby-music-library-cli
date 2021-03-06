class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        user_input = ""
        while user_input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            user_input = gets.chomp

            case user_input
            when "list songs"
                self.list_songs
            when "list artists"
                self.list_artists
            when "list genres"
                self.list_genres
            when "list artist"
                self.list_songs_by_artist
            when "list genre"
                self.list_songs_by_genre
            when "play song"
                self.play_song
            end
        end  
    end

    def list_songs
        Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.sort{|a, b| a.name <=> b.name}.each_with_index do |artist, index|
            puts "#{index + 1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort{|a, b| a.name <=> b.name}.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        i = 1
        puts "Please enter the name of an artist:"
        user_input = gets.chomp
        Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
            if song.artist.name == user_input
                puts "#{i}. #{song.name} - #{song.genre.name}"
                i += 1
            end
        end
    end

    def list_songs_by_genre
        i = 1
        puts "Please enter the name of a genre:"
        user_input = gets.chomp
        Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |song, index|
            if song.genre.name == user_input
                puts "#{i}. #{song.artist.name} - #{song.name}"
                i += 1
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.chomp.to_i
        song_list = Song.all.sort{|a, b| a.name <=> b.name }
        if user_input.between?(1, song_list.count)
            puts "Playing #{song_list[user_input - 1].name} by #{song_list[user_input - 1].artist.name}"
        end
    end

end