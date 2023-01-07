require_relative './user'

class UserRepository

  def all
    users = []
    sql = 'SELECT * FROM users;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each { |entry| 
    user = User.new
    user.id = entry['id'].to_i
    user.username = entry['username']
    user.email = entry['email']
    users << user
    }
    return users
  end



end

