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
                answer << Student.new(student['id'], student['name'], nil, student['class'])
            end
        end

        return answer
    end

    def self.removeStudent(id)
        Dbhandler.get.execute("DELETE FROM students WHERE id = ?;", id)
        Dbhandler.get.execute("DELETE FROM student_trait_connection WHERE student_id = ?;", id)
    end

end