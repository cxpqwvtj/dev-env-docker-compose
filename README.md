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

プロジェクト毎のサービス起動(仮)

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
