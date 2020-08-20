class Dbhandler
    
    def self.get        
        db = SQLite3::Database.new('db/project0.db')
        db.results_as_hash = true
        return db
    end

    def self.orienter(type, arr)
        answer = []

        if type == :students
            for student in arr do
                answer << Student.new(student['id'], student['name'], nil)
            end
        end

        return answer
    end

end