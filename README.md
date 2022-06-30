# テーブルスキーマについて

## ①Userモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  password  |  string  |  

<br>

## ②Taskモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  title |  string  |
|  content  |  string  |
|  deadline  |  datetime  |
|  status  |  string  |
|  priority  |  string  |

<br>

## ③Labelモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  name  |  string  |
|  user.id  |  bigint |

<br>

## ④Middleモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task.id  |  bigint  |
|  label.id  |  bigint  |

<br>

# Herokuのデプロイ手順
1.rootの設定 config/routes.rb

```
root 'tasks#index'
```
<br>

2.Herokuに新しいアプリケーションを作成
```
$ heroku create
```
<br>

3.コミット
```
$ git add -A
$ git commit -m "init"
```
<br>

4.Herokuにデプロイ
```
$ git push heroku master
```
<br>

5.データベースの移行
```
$ heroku run rails db:migrate
```