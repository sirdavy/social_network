
describe StudentRepository do

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

  before(:each) do 
    reset_students_table
  end


  
end

#   # 1
# # Gets all posts

# repo = PostRepository.new
# all_posts = repo.all
# all_posts.length # =>  2
# all_posts[0].id # =>  1
# all_posts[0].title # =>  'Great nibbles'
# all_posts[0].content # => 'Liver, fava beans, chianti'
# all_posts[0].views # => 10
# all_posts[0].user_id # => 1
# all_posts[1].id # =>  1
# all_posts[1].title # =>  'Why everyone sucks'
# all_posts[1].content # => 'Is it just me or do...'
# all_posts[1].views # => 9
# all_posts[1].user_id # => 2

# # 2
# # Gets a single post

# repo = PostRepository.new
# sing_post = repo.find(1)
# sing_post.id # =>  1
# sing_post.title # =>  'Great nibbles'
# sing_post.content # => 'Liver, fava beans, chianti'
# sing_post.views # => 10
# sing_post.user_id # => 1


# # 3
# # Creates a new post
# repo = PostRepository.new
# new_post = Post.new
# new_post.title # => 'Problems with staff'
# new_post.content = 'He's from Barcelona'
# new_post.views # => 20
# new_post.user_id # => 3
# repo.create(new_user)
# repo.all # includes new_user

# # 4
# # Deletes a post
# repo = StudentRepository.new
# repo.delete(1)
# repo.all # => not include  'Great nibbles', 'Liver, fava beans, chianti'
