# README

## 仕様

### トップページ
- ブランド一覧(名前のみでよい)を表示する
  - 名前はリンクになっており、下に記すブランドの店舗一覧ページに遷移する
- ブランドの店舗一覧ページ
  - `/aqua`, `/tvb` のようにブランドごとに固有のパスとする
    - パスは管理画面でブランドを新規に作成するときに管理者が入力する
      - ブランド作成後のパスの変更は不可
 - そのブランドの店舗一覧(名前のみでよい)を表示する
 - 店舗の並び順は管理画面から変更可能

### 管理者専用ページ
- 特権管理者と一般管理者(後述)しかアクセスできない
- 特権管理者
  - 1名のみでユーザ名 `admin`、パスワード `UMtDj4ZBv%&d@Tzh` で認証を行う
  - 全ての操作が行える
- 一般管理者
  - 特権管理者がユーザ名とパスワードを指定して作成する
    - そのユーザ名とパスワードで認証を行う
  - ブランドの新規作成と店舗の並び順の変更のみを行える

## Usage

環境: rbenv

```
$ cd your-project-path
$ bin/rails db:create
$ bin/rails db:migrate
$ bin/rails db:seed_fu
$ bin/rails s
```

環境: Docker

```
TODO
```

### 管理画面

http://localhost:3000/admin

- id: admin
- password: UMtDj4ZBv%&d@Tzh

### ブランド・店舗画面

http://localhost:3000


## 長期的かつ複数人体制で開発速度を落とさない設計

- Rubocopでコーディング規約に遵守したコードベースになるようにした
- CircleCIでRubocopのチェック、テストの実行ができるようにしている
- 複数人体制になれば必ずfeatureブランチを切りPull Requestし、コードレビューを経てmasterにマージすることを想定している
- コントローラにindex, show, new, edit, create, update, destory以外のアクションは極力使わない
  - RESTに関係ないアクションは極力生やさないようにしている
  - いわゆるDHHのコントローラの書き方(参考: https://postd.cc/how-dhh-organizes-his-rails-controllers/)
- 設計パターン
  - Skinny Controller, Fat Modelが基本
  - 今回は小規模な仕様なので使わなかったがモデルが太るのならDecoratorを使用する
  - form object(ActiveModelをincludeしたクラス)を使用してファットモデルには対応する
  - サービスクラスを使うのはあまり評判が良くないので避けたい
    - モデルとコントローラ間の中間層としてサービスクラスが必要ならサービスの名前の付け方、規約を曖昧にせず使う
