## Dancer作成
curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=Komiya Shinnosuke' -F 'dancer[email]=Komiya Shinnosuke' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=Komiya Shinnosuke' -F 'dancer[password_confirmation]=Komiya Shinnosuke'

curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=Hara Kazunori' -F 'dancer[email]=Hara Kazunori' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=Hara Kazunori' -F 'dancer[password_confirmation]=Hara Kazunori'

curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=くりす' -F 'dancer[email]=くりす' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=くりす' -F 'dancer[password_confirmation]=くりす'

## login
curl -i -X POST http://localhost:3000/api/v1/login -d 'dancer[email]=Komiya Shinnosuke' -d 'dancer[password]=Komiya Shinnosuke'
## => 64f63a6e02792f3db0d73dd20f6a0964

## ダンサー情報取得
curl -i -X GET -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' http://localhost:3000/api/v1/dancers
## レコード取得
curl -i -X GET -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' http://localhost:3000/api/v1/records

## Record作成
curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ヒップポップ' -d 'record[introduction]=ヒップポップ' -d 'record[effect]=ヒップポップ' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ヒップポップ' -d 'record[dancer_id]=1' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ブレイクダンス' -d 'record[introduction]=ブレイクダンス' -d 'record[effect]=ブレイクダンス' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ブレイクダンス' -d 'record[dancer_id]=1' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ヒップポップ' -d 'record[introduction]=ヒップポップ' -d 'record[effect]=ヒップポップ' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ヒップポップ' -d 'record[dancer_id]=2' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ブレイクダンス' -d 'record[introduction]=ブレイクダンス' -d 'record[effect]=ブレイクダンス' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ブレイクダンス' -d 'record[dancer_id]=3' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ブレイクダンス' -d 'record[introduction]=ブレイクダンス' -d 'record[effect]=ブレイクダンス' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ブレイクダンス' -d 'record[dancer_id]=1' -d 'record[music_id]=3'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ヒップポップ' -d 'record[introduction]=ヒップポップ' -d 'record[effect]=ヒップポップ' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ヒップポップ' -d 'record[dancer_id]=2' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ブレイクダンス' -d 'record[introduction]=ブレイクダンス' -d 'record[effect]=ブレイクダンス' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ブレイクダンス' -d 'record[dancer_id]=3' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ブレイクダンス' -d 'record[introduction]=ブレイクダンス' -d 'record[effect]=ブレイクダンス' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ロックダンス' -d 'record[dancer_id]=1' -d 'record[music_id]=2'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ヒップポップ' -d 'record[introduction]=ヒップポップ' -d 'record[effect]=ヒップポップ' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ヒップポップ' -d 'record[dancer_id]=2' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'record[title]=ロックダンス' -d 'record[introduction]=ロックダンス' -d 'record[effect]=ロックダンス' -d 'record[movie]=@sample_movie.mp4' -d 'record[password_confirmation]=ロックダンス' -d 'record[dancer_id]=3' -d 'record[music_id]=1'

## 曲作成
curl -i -X POST localhost:3000/api/v1/musics -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'music[name]=プリキュア' -d 'music[bpm]=120' -d 'music[file]=hogeeeeee'

curl -i -X POST localhost:3000/api/v1/musics -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'music[name]=あいかつ' -d 'music[bpm]=120' -d 'music[file]=hogeeeeee'

curl -i -X POST localhost:3000/api/v1/musics -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'music[name]=aaaa' -d 'music[bpm]=bbbbbb' -d 'music[file]=ccccccccccccccc'


## Fav作成
curl -i -X POST localhost:3000/api/v1/favorites -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'favorite[dancer_id]=1' -d 'favorite[record_id]=2'

curl -i -X POST localhost:3000/api/v1/favorites -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'favorite[dancer_id]=1' -d 'favorite[record_id]=3'

curl -i -X POST localhost:3000/api/v1/favorites -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'favorite[dancer_id]=1' -d 'favorite[record_id]=4'

## Follow作成
curl -i -X POST localhost:3000/api/v1/follows -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'follow[dancer_id]=1' -d 'follow[follow_id]=2'

curl -i -X POST localhost:3000/api/v1/follows -H 'ACCESS_TOKEN: 64f63a6e02792f3db0d73dd20f6a0964' -d 'follow[dancer_id]=1' -d 'follow[follow_id]=3'
