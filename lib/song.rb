require './lib/concerns/findable.rb'
require 'pry'

class Song
    extend Concerns::Findable

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist unless artist == nil
        self.genre = genre unless genre == nil
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.destroy_all
        @@all = []
    end

    def self.create(name)
        name = Song.new(name)
        name.save
        name
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def self.new_from_filename(filename)
        filename = filename.sub(/.mp3/, "").split(" - ")
        filename[0] = Artist.find_or_create_by_name(filename[0])
        filename[1] = Song.find_or_create_by_name(filename[1])
        filename[2] = Genre.find_or_create_by_name(filename[2])
        filename[0].add_song(filename[1])
        filename[2].add_song(filename[1])
        filename[1]
    end

    def self.create_from_filename(filename)
        new_from_filename(filename)
    end

end