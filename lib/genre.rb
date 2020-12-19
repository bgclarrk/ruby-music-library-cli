require './lib/concerns/findable.rb'

class Genre
    extend Concerns::Findable

    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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
        name = Genre.new(name)
        name.save
        name
    end

    def songs
        @songs
    end

    def add_song(song)
        song.genre = self unless song.genre != nil
        @songs << song unless @songs.include?(song)
    end

    def artists
        artists = @songs.collect { |song| song.artist }
        artists.uniq
    end

end