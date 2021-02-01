admin = User.create!(name: '管理ユーザー',
                    email: 'historymap@example.com',
                    password: 'historymap',
                    password_confirmation: 'historymap',
                    admin: true,
                    activated: true,
                    activated_at: Time.zone.now)

kyusyu = User.create!(name: '九州男児',
                      email: 'kyusyu@example.com',
                      password: 'historymap',
                      password_confirmation: 'historymap',
                      activated: true,
                      activated_at: Time.zone.now)

shikoku = User.create!(name: 'お遍路坊主',
                      email: 'shikoku@example.com',
                      password: 'historymap',
                      password_confirmation: 'historymap',
                      activated: true,
                      activated_at: Time.zone.now)

tyugoku = User.create!(name: '山陰山陽の虎',
                      email: 'tyugoku@example.com',
                      password: 'historymap',
                      password_confirmation: 'historymap',
                      activated: true,
                      activated_at: Time.zone.now)

kinki = User.create!(name: '上方',
                    email: 'kinki@example.com',
                    password: 'historymap',
                    password_confirmation: 'historymap',
                    activated: true,
                    activated_at: Time.zone.now)

tyubu = User.create!(name: '中部オンエア',
                    email: 'tyubu@example.com',
                    password: 'historymap',
                    password_confirmation: 'historymap',
                    activated: true,
                    activated_at: Time.zone.now)

kanto = User.create!(name: '江戸っ子',
                    email: 'kanto@example.com',
                    password: 'historymap',
                    password_confirmation: 'historymap',
                    activated: true,
                    activated_at: Time.zone.now)

tohoku = User.create!(name: '伊達男',
                      email: 'tohoku@example.com',
                      password: 'historymap',
                      password_confirmation: 'historymap',
                      activated: true,
                      activated_at: Time.zone.now)

hokkaido = User.create!(name: '松山千春',
                        email: 'hokkaido@example.com',
                        password: 'historymap',
                        password_confirmation: 'historymap',
                        activated: true,
                        activated_at: Time.zone.now)


# 時代カテゴリ作成
periods = ['令和','平成','昭和','大正','明治','江戸','安土桃山','室町','鎌倉','平安','奈良','飛鳥','古墳','弥生','縄文','旧石器','人類以前']
periods.each { |period| Period.create!(name: period) }


# 都道府県カテゴリ作成
prefectures = ['北海道','青森県','岩手県','宮城県','秋田県','山形県','福島県','茨城県','栃木県','群馬県','埼玉県','千葉県','東京都','神奈川県','新潟県','富山県','石川県','福井県','山梨県','長野県','岐阜県','静岡県','愛知県','三重県','滋賀県','京都府','大阪府','兵庫県','奈良県','和歌山県','鳥取県','島根県','岡山県','広島県','山口県','徳島県','香川県','愛媛県','高知県','福岡県','佐賀県','長崎県','熊本県','大分県','宮崎県','鹿児島県','沖縄県']
prefectures.each { |prefecture| Prefecture.create!(name: prefecture) }


# マイクロポスト
admin.microposts.create!(title: '葛飾北斎「神奈川沖浪裏」に似た構図が見られる地、千葉県銚子市', content: '海外でも人気な葛飾北斎の通称「波」。実際に描かれた場所については神奈川沖の船上と考えられています。写真は『産経新聞社「美しい日本を撮ろう」フォトコンテスト』で滑方清さんが撮影された一枚です。', period_id: 6, prefecture_id: 12, latlng: "(35.78257336213532, 140.82770410416438)", created_at: 2.month.ago)

kyusyu.microposts.create!(title: '天孫降臨。日本の歴史が始まった土地。', content: '天照大神の孫に当たる瓊瓊杵尊(ニニギノミコト)が降り立った土地です。瓊瓊杵尊は初代天皇・神武天皇の曾祖父に当たる方です。写真は宮崎県高千穂町にある「天孫降臨の滝」です。', period_id: 14, prefecture_id: 45, latlng: "(32.740212975906154, 131.30097750103604)", created_at: 1.month.ago)

shikoku.microposts.create!(title: '弘法大師が悟りを開いた場所。御厨人窟(みくろど)', content: '真言宗の開祖であり「弘法大師（こうぼうだいし）」として知られる空海の修行地。この場所からは空と海しか見えないため空海と名乗ったと言われています。', period_id: 10, prefecture_id: 39, latlng: "(33.25229209144667, 134.18097052003787)", created_at: 2.week.ago)

tyugoku.microposts.create!(title: '伝説の怪物・八俣遠呂智(ヤマタオロチ)がいたとされる山。', content: '一度は聞いたことがある八俣遠呂智伝説。ちなみに古事記によると"ノ"は添えないそうです。須佐之男命が対峙し、その体から出てきた剣が今も、三種の神器の一つとして皇室で受け継がれています。', period_id: 14, prefecture_id: 32, latlng: "(35.33710732807216, 132.87221059002144)", created_at: 1.week.ago)

kinki.microposts.create!(title: '民のかまど。仁徳天皇のお墓。', content: '民家のかまどの煙が登らないのを見た仁徳天皇は、「これは民が貧しいからである。3年間の徴税を禁止し、免税とする」と仰られ、税を免除されました。それから3年経ちだんだんと煙が登ってきましたが、仁徳天皇はそれでも税をとりません。仁徳天皇の御殿は雨漏りしていたそうです。ついに耐え兼ねた民が自ら税を納めたというのが民の竈の話です。こんな君主をいただけてとても幸運です。', period_id: 13, prefecture_id: 27, latlng: "(34.56223299851912, 135.48615136207565)", created_at: 5.day.ago)

tyubu.microposts.create!(title: '川中島の今の姿', content: '戦国時代の最強武将は？と問われるとおそらく武田信玄か上杉謙信この二人のどちらかになるのではないでしょうか。川中島はそんな二人が奪い合い、火花を散らした土地です。写真は最激戦だった第四次合戦の戦場だった八幡原(はちまんぱら)の今の姿です。', period_id: 7, prefecture_id: 20, latlng: "(35.33710732807216, 132.87221059002144)", created_at: 4.day.ago)

kanto.microposts.create!(title: '北条政子の墓、鎌倉・寿福寺', content: '北条政子と言えば尼将軍として鎌倉幕府を支えた女性で、「最後の詞」演説では女性でこんな演説ができる人物がいたのかと驚いたことを覚えています。彼女は後世「日本三大悪女」の一人に数えられますが、悪女と言えば私利私欲で動く人物に聞こえますが、私はそういう人物ではなかったと勝手に想像しています。', period_id: 9, prefecture_id: 14, latlng: "(35.32464311408548, 139.54775182181524)", created_at: 3.day.ago)

tohoku.microposts.create!(title: '後藤新平旧宅', content: '後藤新平といえば、当時戊辰戦争の直後でまだまだ東北出身者が活躍しにくかった頃、己の力だけで出世し、初代満鉄総裁や内務大臣として関東大震災の復興に当たった人物です。「金を残して死ぬ者は下だ。仕事を残して死ぬ者は中だ。人を残して死ぬ者は上だ。」', period_id: 5, prefecture_id: 3, latlng: "(39.14421784534702, 141.1383988379313)", created_at: 2.day.ago)

hokkaido.microposts.create!(title: '榎本軍鷲ノ木上陸地跡', content: '国道5号から1本海側の道に下りると、駒ヶ岳と噴火湾を眺望できる場所に辿り着きます。1868（明治元）年10月20日、徳川家臣の榎本武揚が軍艦8隻、2500～3000人の兵を率いて上陸。22日に先発隊が官軍の攻撃を受けて応戦したため、土方歳三と大島圭介の2隊に分かれて一路、箱館を目指しました。ここから箱館戦争が始まった、歴史上の要所です。', period_id: 5, prefecture_id: 1, latlng: "(35.33710732807216, 132.87221059002144)")

def image_path(n)
  Rails.root.join("db/images", "img_#{n}.jpg")
end
microposts = Micropost.all.reverse_order
microposts.each.with_index(1) { |micropost, n|
  micropost.image.attach(io: File.open(image_path(n)),
                         filename: "#{micropost.user.name}_#{micropost.id}.png")
}

# 初期ユーザーフォロー関係
users = User.all
user  = users.first
following = users[2..7]
followers = users[4..9]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# 「行きたい！」初期設定
(1..8).each { |n| admin.goings.create!(micropost_id: n) }
(2..9).each { |n| kyusyu.goings.create!(micropost_id: n) }
(1..9).each { |n| shikoku.goings.create!(micropost_id: n) }
(5..9).each { |n| tyugoku.goings.create!(micropost_id: n) }
(1..4).each { |n| kinki.goings.create!(micropost_id: n) }
(3..6).each { |n| tyubu.goings.create!(micropost_id: n) }
(4..7).each { |n| kanto.goings.create!(micropost_id: n) }
(5..8).each { |n| tohoku.goings.create!(micropost_id: n) }