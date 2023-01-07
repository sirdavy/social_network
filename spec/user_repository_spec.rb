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

    it 'gets a single user when passed id' do
      repo = UserRepository.new
      sing_user = repo.find(1)
      expect(sing_user.id).to eq 1
      expect(sing_user.username).to eq 'Hannibal'
      expect(sing_user.email).to eq 'hannibubs@lector.com'
    end

    it 'creates a new user' do
      repo = UserRepository.new
      new_user = User.new
      new_user.username = 'Basil'
      new_user.email = 'baz@fawltytowers.co.uk'
      repo.create(new_user)
      sing_user = repo.find(3)
      expect(sing_user.id).to eq 3
      expect(sing_user.username).to eq 'Basil'
      expect(sing_user.email).to eq 'baz@fawltytowers.co.uk'
    end

    it 'deletes a user' do
      repo = UserRepository.new
      repo.delete(1)
      all_users = repo.all 
      expect(all_users[0].id).to eq 2
      expect(all_users[0].username).to eq 'Darth'
      expect(all_users[0].email).to eq 'darthur@vader.net'
    end


end









