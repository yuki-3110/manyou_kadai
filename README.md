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

## ④middleモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task.id  |  bigint  |
|  label.id  |  bigint  |
