class Dbhandler
    
    def self.get        
        db = SQLite3::Database.new('db/project0.db')
        db.results_as_hash = true
        return db
    end

end