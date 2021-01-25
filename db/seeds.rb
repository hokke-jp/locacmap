admin = User.create!(name: '管理ユーザー',
             email: 'historymap@example.com',
             password: 'historymap',
             password_confirmation: 'historymap',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name: '黒田武士',
              email: 'kuroda@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '武田武士',
              email: 'takeda@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '上杉武士',
              email: 'uesugi@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '北条武士',
              email: 'houjou@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '織田武士',
              email: 'oda@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '伊達武士',
              email: 'date@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '大久保利通',
              email: 'okubo@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

User.create!(name: '乃木希典',
              email: 'nogi@example.com',
              password: 'historymap',
              password_confirmation: 'historymap',
              activated: true,
              activated_at: Time.zone.now)

# 50.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n + 1}@railstutorial.org"
#   password = 'password'
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now)
# end

# 時代カテゴリ作成
periods = ['令和','平成','昭和','大正','明治','江戸','安土桃山','室町','鎌倉','平安','奈良','飛鳥','古墳','弥生','縄文','旧石器','人類以前']
periods.each { |period| Period.create!(name: period) }

# 都道府県カテゴリ作成
prefectures = ['北海道','青森県','岩手県','宮城県','秋田県','山形県','福島県','茨城県','栃木県','群馬県','埼玉県','千葉県','東京都','神奈川県','新潟県','富山県','石川県','福井県','山梨県','長野県','岐阜県','静岡県','愛知県','三重県','滋賀県','京都府','大阪府','兵庫県','奈良県','和歌山県','鳥取県','島根県','岡山県','広島県','山口県','徳島県','香川県','愛媛県','高知県','福岡県','佐賀県','長崎県','熊本県','大分県','宮崎県','鹿児島県','沖縄県']
prefectures.each { |prefecture| Prefecture.create!(name: prefecture) }

# マイクロポスト
admin.microposts.create!(title: '初', content: 'よろしく', period_id: 2, prefecture_id: 2, latlng: "(40.64505808040853, 141.45507812499997)")

# users = User.order(:created_at).take(6)
# 35.times do
#   title = Faker::Lorem.sentence(word_count: 2)
#   content = Faker::Lorem.sentence(word_count: 5)
#   users.each { |user| user.microposts.create!(title: title, content: content, period_id: rand(1..17), prefecture_id: rand(1..47)) }
# end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..7]
followers = users[4..9]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
