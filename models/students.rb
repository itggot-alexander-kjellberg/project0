require_relative 'dbhandler'

class Student < Dbhandler
    attr_reader :id, :name, :char

    def initialize(id, name, char)
        @id = id
        @name = name
        @db = Dbhandler.new
        @char = char
    end

    def self.get(id, db)
        if id == :all
            db.execute('SELECT * FROM personer')
        else
            db.execute('SELECT * FROM personer WHERE id = ?', id)
        end
    end
    
    def self.search(name, db)
        return db.execute('SELECT * FROM personer WHERE name LIKE ?', "%#{name}%")
    end
end