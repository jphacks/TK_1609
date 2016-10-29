## Dancer作成
curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=hoge' -F 'dancer[email]=hoge' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=hoge' -F 'dancer[password_confirmation]=hoge'

curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=Komiya Shinnosuke' -F 'dancer[email]=Komiya Shinnosuke' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=Komiya Shinnosuke' -F 'dancer[password_confirmation]=Komiya Shinnosuke'

curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=Hara Kazunori' -F 'dancer[email]=Hara Kazunori' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=Hara Kazunori' -F 'dancer[password_confirmation]=Hara Kazunori'

curl -i -X POST http://localhost:3000/api/v1/dancers -F 'dancer[name]=くりす' -F 'dancer[email]=くりす' -F 'dancer[image]=@sample.jpeg' -F 'dancer[password]=くりす' -F 'dancer[password_confirmation]=くりす'

## login
curl -i -X POST http://localhost:3000/api/v1/login -d 'dancer[email]=hoge' -d 'dancer[password]=hoge'
## => 5a1895693fd080f3ae3b6a6d0fa788dd

## ダンサー情報取得
curl -i -X GET -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' http://localhost:3000/api/v1/dancers

## Record作成
curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=があああああ' -d 'record[introduction]=があああああ' -d 'record[effect]=があああああ' -d 'record[movie]=があああああ' -d 'record[password_confirmation]=があああああ' -d 'record[dancer_id]=1' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=にぽおおお' -d 'record[introduction]=にぽおおお' -d 'record[effect]=にぽおおお' -d 'record[movie]=にぽおおお' -d 'record[password_confirmation]=にぽおおお' -d 'record[dancer_id]=1' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=があああああ' -d 'record[introduction]=があああああ' -d 'record[effect]=があああああ' -d 'record[movie]=があああああ' -d 'record[password_confirmation]=があああああ' -d 'record[dancer_id]=2' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=にぽおおお' -d 'record[introduction]=にぽおおお' -d 'record[effect]=にぽおおお' -d 'record[movie]=にぽおおお' -d 'record[password_confirmation]=にぽおおお' -d 'record[dancer_id]=3' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=にぽおおお' -d 'record[introduction]=にぽおおお' -d 'record[effect]=にぽおおお' -d 'record[movie]=にぽおおお' -d 'record[password_confirmation]=にぽおおお' -d 'record[dancer_id]=1' -d 'record[music_id]=3'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=があああああ' -d 'record[introduction]=があああああ' -d 'record[effect]=があああああ' -d 'record[movie]=があああああ' -d 'record[password_confirmation]=があああああ' -d 'record[dancer_id]=2' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=にぽおおお' -d 'record[introduction]=にぽおおお' -d 'record[effect]=にぽおおお' -d 'record[movie]=にぽおおお' -d 'record[password_confirmation]=にぽおおお' -d 'record[dancer_id]=3' -d 'record[music_id]=1'


curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=にぽおおお' -d 'record[introduction]=にぽおおお' -d 'record[effect]=にぽおおお' -d 'record[movie]=にぽおおお' -d 'record[password_confirmation]=にぽおおお' -d 'record[dancer_id]=1' -d 'record[music_id]=2'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=があああああ' -d 'record[introduction]=があああああ' -d 'record[effect]=があああああ' -d 'record[movie]=があああああ' -d 'record[password_confirmation]=があああああ' -d 'record[dancer_id]=2' -d 'record[music_id]=1'

curl -i -X POST localhost:3000/api/v1/records -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'record[title]=にぽおおお' -d 'record[introduction]=にぽおおお' -d 'record[effect]=にぽおおお' -d 'record[movie]=にぽおおお' -d 'record[password_confirmation]=にぽおおお' -d 'record[dancer_id]=3' -d 'record[music_id]=1'

## 曲作成
curl -i -X POST localhost:3000/api/v1/musics -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'music[name]=プリキュア' -d 'music[bpm]=120' -d 'music[file]=hogeeeeee'

curl -i -X POST localhost:3000/api/v1/musics -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'music[name]=あいかつ' -d 'music[bpm]=120' -d 'music[file]=hogeeeeee'

## Fav作成
curl -i -X POST localhost:3000/api/v1/favorites -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'favorite[dancer_id]=1' -d 'favorite[record_id]=2'


## Follow作成
curl -i -X POST localhost:3000/api/v1/follows -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'follow[dancer_id]=1' -d 'follow[follow_id]=2'

curl -i -X POST localhost:3000/api/v1/follows -H 'ACCESS_TOKEN: 5a1895693fd080f3ae3b6a6d0fa788dd' -d 'follow[dancer_id]=1' -d 'follow[follow_id]=3'
