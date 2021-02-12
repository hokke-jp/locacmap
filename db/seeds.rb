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

kinki = User.create!(name: '平八郎',
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

# 初期ユーザーアイコン
def avatar_path(n)
  Rails.root.join("db/avatars", "avatar_#{n}.jpg")
end
users = User.all.order(id: :asc)
users.each.with_index(1) { |user, n|
  user.avatar.attach(io: File.open(avatar_path(n)),
                    filename: "avatar_#{user.id}.jpg")
}


# 時代カテゴリ作成
periods = ['令和','平成','昭和','大正','明治','江戸','安土桃山','室町','鎌倉','平安','奈良','飛鳥','古墳','弥生','縄文','旧石器','人類以前']
periods.each { |period| Period.create!(name: period) }


# 都道府県カテゴリ作成
prefectures = ['北海道','青森県','岩手県','宮城県','秋田県','山形県','福島県','茨城県','栃木県','群馬県','埼玉県','千葉県','東京都','神奈川県','新潟県','富山県','石川県','福井県','山梨県','長野県','岐阜県','静岡県','愛知県','三重県','滋賀県','京都府','大阪府','兵庫県','奈良県','和歌山県','鳥取県','島根県','岡山県','広島県','山口県','徳島県','香川県','愛媛県','高知県','福岡県','佐賀県','長崎県','熊本県','大分県','宮崎県','鹿児島県','沖縄県']
prefectures.each { |prefecture| Prefecture.create!(name: prefecture) }


# マイクロポスト
admin.microposts.create!(title: '葛飾北斎「神奈川沖浪裏」に似た構図が見られる地、千葉県銚子市', content: '海外でも人気な葛飾北斎の通称「波」。実際に描かれた場所については神奈川沖の船上と考えられています。写真は『産経新聞社「美しい日本を撮ろう」フォトコンテスト』で滑方清さんが撮影された一枚です。', period_id: 6, prefecture_id: 12, latlng: "(35.733200186434594, 140.82821442048603)", created_at: 5.day.ago)

kyusyu.microposts.create!(title: '天孫降臨。日本の歴史が始まった土地。', content: '天照大神の孫に当たる瓊瓊杵尊(ニニギノミコト)が降り立った土地です。瓊瓊杵尊は初代天皇・神武天皇の曾祖父に当たる方です。写真は宮崎県高千穂町にある「天孫降臨の滝」です。', period_id: 14, prefecture_id: 45, latlng: "(32.740212975906154, 131.30097750103604)", created_at: 3.day.ago)

shikoku.microposts.create!(title: '弘法大師が悟りを開いた場所。御厨人窟(みくろど)', content: '真言宗の開祖であり「弘法大師（こうぼうだいし）」として知られる平安時代の僧侶・空海の修行地。この場所からは空と海しか見えないため「空海」と名乗ったと言われています。', period_id: 10, prefecture_id: 39, latlng: "(33.25229209144667, 134.18097052003787)", created_at: 4.day.ago)

tyugoku.microposts.create!(title: '伝説の怪物・八俣遠呂智(ヤマタオロチ)がいたとされる山。', content: '一度は聞いたことがある八俣遠呂智伝説。ちなみに古事記によると"ノ"は添えないそうです。須佐之男命が対峙し、その体から出てきた剣が今も、三種の神器の一つとして皇室で受け継がれています。', period_id: 14, prefecture_id: 32, latlng: "(35.33710732807216, 132.87221059002144)", created_at: 1.week.ago)

kinki.microposts.create!(title: '民のかまど。仁徳天皇のお墓。', content: '民家のかまどの煙が登らないのを見た仁徳天皇は、「これは民が貧しいからである。3年間の徴税を禁止し、免税とする」と仰られ、税を免除されました。それから3年経ちだんだんと煙が登ってきましたが、仁徳天皇はそれでも税をとりません。この時の仁徳天皇の御殿は雨漏りしていたそうです。ついに耐え兼ねた民が自ら税を納めたというのが民のかまどの話です。', period_id: 13, prefecture_id: 27, latlng: "(34.56223299851912, 135.48615136207565)", created_at: 2.month.ago)

tyubu.microposts.create!(title: '川中島の今の姿', content: '戦国時代の最強武将と名高い武田信玄と上杉謙信。川中島はそんな二人が奪い合い、火花を散らした土地です。写真は最激戦だった第四次川中島の戦いの戦場だった八幡原(はちまんぱら)の今の姿です。', period_id: 7, prefecture_id: 20, latlng: "(36.59151319574407, 138.18662666216196)", created_at: 2.week.ago)

kanto.microposts.create!(title: '北条政子の墓、鎌倉・寿福寺', content: '北条政子と言えば尼将軍として鎌倉幕府を支えた女性で、「最後の詞」演説が有名だと思います。彼女は後世「日本三大悪女」の一人に数えられますが、悪女と言えば私利私欲で動く人物に聞こえますが、私はそういう人物ではなかったと勝手に想像しています。', period_id: 9, prefecture_id: 14, latlng: "(35.32464311408548, 139.54775182181524)", created_at: 1.month.ago)

tohoku.microposts.create!(title: '後藤新平旧宅', content: '後藤新平といえば、明治初期、戊辰戦争の直後でまだまだ東北出身者が活躍しにくかった頃、己の力だけで出世し、初代満鉄総裁や内務大臣として関東大震災の復興に当たった人物です。「金を残して死ぬ者は下だ。仕事を残して死ぬ者は中だ。人を残して死ぬ者は上だ。」', period_id: 5, prefecture_id: 3, latlng: "(39.14421784534702, 141.1383988379313)", created_at: 2.day.ago)

hokkaido.microposts.create!(title: '榎本軍鷲ノ木上陸地跡', content: '国道5号から1本海側の道に下りると、駒ヶ岳と噴火湾を眺望できる場所に辿り着きます。1868（明治元）年10月20日、徳川家臣の榎本武揚が軍艦8隻、2500～3000人の兵を率いて上陸。22日に先発隊が官軍の攻撃を受けて応戦したため、土方歳三と大島圭介の2隊に分かれて一路、箱館を目指しました。ここから箱館戦争が始まった、歴史上の要所です。', period_id: 5, prefecture_id: 1, latlng: "(42.12087974336119, 140.5386761425863)")

kyusyu.microposts.create!(title: '蒙古襲来から日本を守った「元寇防塁」', content: '13世紀の初め，チンギス・ハンはアジアからヨーロッパにまたがる強大なモンゴル帝国を打ち立てました。その孫，5代皇帝フビライは，国名を元に新ため，日本に使者を送り，通交を求めました。しかし，鎌倉幕府の時の執権・北条時宗がこれに応じず使者を切り捨てました。これはモンゴルからの使者はただの使者ではなくスパイ活動も行っていたためと言われています。この時時宗はまだ18歳だったそうです。その後、フビライは日本に二度も攻め込み，武士たちと激しい戦いを繰り広げました。元寇の実際の戦闘における日本と元との勝敗については諸説あり、はっきりは分かりませんが、私の個人的考えでは、戦闘でも日本が元を圧倒しており、神風伝説は当時の朝廷が鎌倉幕府の権威を恐れ、自分たちの祈りのおかげで勝てたと宣伝するために大袈裟に広めたという説を信じています。', period_id: 9, prefecture_id: 40, latlng: "(33.59141030769767, 130.30867960215858)", created_at: 1.hour.ago)

kyusyu.microposts.create!(title: '福岡・久留米が生んだ天才「田中久重」', content: '田中久重は寛政11年（1799年）、筑後国久留米で生まれ、幼い頃から物づくりの才能があり、五穀神社（久留米市通外町）の祭礼では当時流行していたからくり人形の新しい仕掛けを次々と考案して大評判となり、「からくり儀右衛門」と呼ばれるようになる。20代に入ると九州各地や大阪・京都・江戸でも興行を行い、各地にその名を知られるようになる。彼の作で現存するからくり人形として有名なものに「弓曳童子」と「文字書き人形」があり、からくり人形の最高傑作といわれている。天保5年（1834年）には上方へ上り、大坂船場の伏見町（大阪市中央区伏見町）に居を構えた。同年に折りたたみ式の「懐中燭台」、天保8年（1837年）に圧縮空気により灯油を補給する灯明の「無尽灯」などを考案した。その後京都へ移り、弘化4年（1847年）に天文学を学ぶために土御門家に入門。嘉永2年（1849年）には、優れた職人に与えられる「近江大掾」（おうみだいじょう）の称号を得た。翌嘉永3年（1850年）には、天動説を具現化した須弥山儀（しゅみせんぎ）を完成させた。この頃に蘭学者の廣瀨元恭が営む「時習堂」（じしゅうどう）に入門し、様々な西洋の技術を学ぶ。嘉永4年（1851年）には、季節によって昼夜の時刻の長さの違う不定時法に対応して文字盤の間隔が全自動で動くなどの、様々な仕掛けを施した「万年自鳴鐘」を完成させた。これは江戸時代において当時の最新技術を結集させた時計であり、二組の（真鍮で作られた二重）ゼンマイを動力に、六面の時計を同時に動かします。さらに鐘を鳴らし、干支や七曜、二十四節気、月の満ち欠けも表示します。機構の精巧さもさることながら、優美さと気品を漂わす伝統工芸品としても高い精度を誇っており、2006年には国の重要文化財に指定されました。久重はその後も活躍を続け、佐賀藩では当時最新鋭のアームストロング砲の開発や、蒸気船の製造、反射炉の設計など様々な活躍を見せた。晩年には電信機関係の製作所・田中製作所を設立し、これは後の東芝の土台となる会社となる。写真はそんな久重の故郷、久留米にある、久重が作成した「太鼓時計」をモチーフにした「からくり太鼓時計」', period_id: 6, prefecture_id: 40, latlng: "(33.3208085, 130.5018159)", created_at: 3.hour.ago)

# micropostの写真
def image_path(n)
  Rails.root.join("db/images", "img_#{n}.jpg")
end
microposts = Micropost.all.reorder(id: :asc)
microposts.each.with_index(1) { |micropost, n|
  micropost.image.attach(io: File.open(image_path(n)),
                         filename: "micropost_image_#{micropost.id}.jpg")
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