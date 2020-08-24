require_relative 'dbhandler'

class Classes < Dbhandler
    def initialize

    end

    def self.get(id, db)
        if id == :all
            return db.execute('SELECT * FROM classes')
        else
            return db.execute('SELECT * FROM classes WHERE id = ?', id)
        end
    end
end