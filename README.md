# dev-env-docker-compose

## できること

- 開発でよく利用するWebアプリ(開発環境)をサクッと構築できる

## ターゲット

- 開発で利用するWebアプリを手動でインストールしている方
- 開発ツールをサクッとインストールしたいエンジニア
- Dockerコマンドを知っている、もしくは興味がある方

## 使い方

- Dockerインストール
- Dockerのネットワーク作成
```
docker network create reverse_proxy
docker network create backbone
```
- start-all-service.sh を実行
```
./start-all-service.sh
```
- アクセス
  - http://localhost

## docker-composeで設定予定のサービス

### プロジェクト毎ではなく、一度だけ立ち上げる

- LDAP
- nginx
- Zabbix

### プロジェクト毎に立ち上げる

- Redmine(PostgreSQL)
- GitLab(PostgreSQL)
- ownCloud
- Rocket.Chat(MongoDB)
- Jenkins
- Subversion
- SonarQube(PostgreSQL)
- Kibana(ElasticSearch/fluentd)

## URL

- プロジェクト名をコンテキストパスとする
- 各サービスのURLは以下の予定
  - redmine
  - gitlab
  - owncloud
  - rocketchat
  - jenkins
  - svn
  - kibana

e.g)http(s)://hostname/projectname/redmine

## composeファイル単位の個別起動

アカウント管理用コンテナ起動

```
cd ldap
docker-compose up -d
cd ..
```

プロジェクト毎のサービス起動

```
cd project
docker-compose up -d
cd ..
```

リバースプロキシ起動

```
cd proxy
docker-compose up -d
cd ..
```

## 各サービスの初期設定

### Redmine

- adminでログイン
- <kbd>管理</kbd> <kbd>LDAP認証</kbd> <kbd>新しい認証方式</kbd>
  - 名称:ldap(任意)
  - ホスト:openldap
  - ポート:389
  - 検索範囲:dc=example,dc=com
  - あわせてユーザーを作成にチェック (チェックしないと先にRedmineユーザーの作成が必要)
  - ログイン属性:cn
  - 名前属性:sn
  - 苗字属性:givenName
  - メール属性:mail

### GitLab

- root:5iveL!fe でログイン
- Admin管理画面から <kbd>Settings</kbd> <kbd>Sign-in Restrictions</kbd>
  - <kbd>Sign-up enabled</kbd>のチェックを外す

### Jenkins

- <kbd>Jenkinsの管理</kbd> <kbd>グローバルセキュリティの設定</kbd> <kbd>セキュリティを有効化</kbd>にチェック <kbd>LDAP</kbd>にチェック
  - <kbd>サーバー</kbd> openldap
  - <kbd>root DN</kbd> dc=example,dc=com
  - <kbd>Display Name LDAP attribute</kbd> displayName
  - <kbd>Email Address LDAP attribute</kbd> mail

### Rocket.Chat

- admin:adminでログイン
- 管理者画面を開く
- LDAP選択
  - <kbd>有効にする</kbd> True
  - <kbd>ホスト</kbd> openldap
  - <kbd>ポート</kbd> 389
  - <kbd>ドメインベース</kbd> dc=example,dc=com
  - <kbd>ドメイン検索ユーザー</kbd> 空白
  - <kbd>ドメイン検索ユーザー ID</kbd> cn,mail
  - <kbd>ドメイン検索の objectclass</kbd> inetOrgPerson
  - <kbd>ドメイン検索の objectCategory</kbd> 空白
  - <kbd>ユーザー名フィールド</kbd> #{sn}#{givenName}
  - <kbd>データを同期する</kbd> はい
  - <kbd>ユーザーのアバターを同期する</kbd> いいえ
  - <kbd>ユーザーデータのフィールドマップ</kbd> {"cn":"name", "mail":"email"}
- LDAP認証のみにする
  - <kbd>アカウント</kbd> <kbd>Registration</kbd> をEXPAND <kbd>登録フォームへのアクセス</kbd> を <kbd>無効</kbd> に変更

### ownCloud

- adminでログイン(初回ログインユーザーがadmin権限となる)
- 左上のメニューから、<kbd>アプリ</kbd> を選択
- <kbd>無効なアプリ</kbd> <kbd>LDAP user and group backend</kbd> を <kbd>有効</kbd> にする
- 右上メニューから <kbd>管理</kbd> 画面を開く
- LDAP設定を行う
  - <kbd>サーバー</kbd>タブ
    - <kbd>ホスト</kbd> openldap
    - <kbd>ポート</kbd> 389
    - <kbd>ベースDN</kbd> dc=example,dc=com
  - <kbd>ログイン属性</kbd>タブ
    - <kbd>LDAP/ADユーザー名</kbd> チェック無し
    - <kbd>その他の属性</kbd> cn
- 右上メニューから<kbd>ユーザー</kbd>を選択し、LDAPに登録したユーザーが表示されれば成功
