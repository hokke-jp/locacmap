User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# 時代カテゴリ作成
periods = ['令和','平成','昭和','大正','明治','江戸','安土桃山','室町','鎌倉','平安','奈良','飛鳥','古墳','弥生','縄文','旧石器','人類以前']
periods.each { |period| Period.create!(name: period) }

# マイクロポスト
users = User.order(:created_at).take(6)
35.times do
  title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(title: title, content: content, period_id: rand(1..17)) }
end

# マイクロポストに時代追加
# microposts = Micropost.all
# microposts.each { |micropost| micropost.update_attribute(period_id: rand(0..16)) }

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..30]
followers = users[3..25]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
