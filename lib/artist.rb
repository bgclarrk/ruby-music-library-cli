require './lib/concerns/findable.rb'

class Artist
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
        name = Artist.new(name)
        name.save
        name
    end

    def songs
        @songs
    end

    def add_song(song)
        song.artist = self unless song.artist != nil
        @songs << song unless @songs.include?(song)
    end

    def genres
        genres = @songs.collect { |song| song.genre }
        genres.uniq
    end

end