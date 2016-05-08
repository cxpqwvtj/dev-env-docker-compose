# dev-env-docker-compose

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

## 起動

ネットワーク作成

```
docker network create reverse_proxy
docker network create backbone
```

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

### Rocket.Chat

- adminでログイン(初回ログインユーザーがadmin権限となる)
- 管理者画面を開く
- LDAP選択
  - Enable:True
  - Host:openldap
  - Domain Base:dc=example,dc=com
  - Domain Search Object Class:inetOrgPerson
  - Username Field:#{sn} #{givenName}
  - Sync Data:True
  - Sync User Avatar:False
  - User Data Field Map:{"cn":"name", "mail":"email"}
- LDAP認証のみにする
  - <kbd>Accounts</kbd> <kbd>Registration Form</kbd> を <kbd>Disabled</kbd> に変更

### ownCloud

- adminでログイン(初回ログインユーザーがadmin権限となる)
- 左上のメニューから、<kbd>アプリ</kbd> を選択
- <kbd>無効なアプリ</kbd> <kbd>LDAP user and group backend</kbd> を <kbd>有効</kbd> にする
- 右上メニューから <kbd>管理</kbd> 画面を開く
- LDAP設定を行う
  - ホスト:openldap
  - ベースDN:dc=example,dc=com

### Jenkins

- <kbd>Jenkinsの管理</kbd> <kbd>グローバルセキュリティの設定</kbd> <kbd>セキュリティを有効化</kbd>にチェック <kbd>LDAP</kbd>にチェック
  - サーバー:openldap
  - root DN:dc=example,dc=com
  - Display Name LDAP attribute:displayName
  - Email Address LDAP attribute:mail
