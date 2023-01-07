require 'user_repository'
require 'user'

describe UserRepository do

  def reset_social_network_tables
    seed_sql = File.read('spec/sn_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
      reset_social_network_tables
  end

  it 'Gets all users' do
    repo = UserRepository.new
    all_users = repo.all
    expect(all_users.length).to eq 2
    expect(all_users[0].id).to eq 1
    expect(all_users[0].username).to eq 'Hannibal'
    expect(all_users[0].email).to eq 'hannibubs@lector.com'
    expect(all_users[1].id).to eq 2
    expect(all_users[1].username).to eq 'Darth'
    expect(all_users[1].email).to eq 'darthur@vader.net'
  end

end

# 1
# 



# # 2
# # Get a single user

# repo = UserRepository.new.new

# sing_user = repo.find(1)

# sing_user.id # =>  1
# sing_user.username# =>   'Hannibal'
# sing_user.email # =>   'hannibubs@lector.com'


# # 3
# # Creates a new user

# repo = UserRepository.new.new
# new_user = User.new
# new_user.username = 'Basil'
# new_user.email = 'baz@fawltytowers.co.uk'
# repo.create(new_user)
# repo.all # includes new_user

# # 4
# # Deletes a user

# repo = UserRepository.new.new
# repo.delete(1)
# repo.all # => not include  'Hannibal', 'hannibubs@lector.com'



