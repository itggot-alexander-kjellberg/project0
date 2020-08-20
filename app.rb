require 'json'

class Site < Sinatra::Base

    def getPeople()
        return @db.execute("SELECT * FROM personer")
    end

    before do
        @db = SQLite3::Database.new('db/project0.db')
    end

    get '/' do
        @personer = getPeople()
        slim :index 
    end

    post '/search_name/:name' do
        names = @db.execute("SELECT * FROM personer WHERE name LIKE ?", "%#{params[:name]}%")
        return names.to_json
    end
end

