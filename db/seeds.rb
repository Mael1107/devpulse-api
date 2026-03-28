Snapshot.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('snapshots')

user = User.create!(
  github_uid: "123456",
  username: "Mael1107",
  avatar_url: "https://github.com/Mael1107.png"
)

puts "Usuário criado: #{user.username}"


30.times do |i|
  user.snapshots.create!(
    date: i.days.ago.to_date,
    commits_count: rand(0..15),
    repos_count: rand(5..12),
    languages: {
      "TypeScript" => rand(25..45),
      "Ruby" => rand(15..35),
      "JavaScript" => rand(10..25),
      "CSS" => rand(5..15)
    }
  )
end

puts "#{user.snapshots.count} snapshots criados!"