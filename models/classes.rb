require_relative 'dbhandler'

class Classes < Dbhandler
    def initialize

    end

    def self.get(name, db)
        if name == :all
            return db.execute('SELECT * FROM classes')
        else
            return db.execute('SELECT * FROM classes WHERE name = ?', name)
        end
    end
end