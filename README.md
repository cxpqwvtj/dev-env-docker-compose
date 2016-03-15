# dev-env-docker-compose

## docker-composeで設定予定のサービス

### プロジェクト毎ではなく、一度だけ立ち上げる

- LDAP
- nginx
- Zabbix

### プロジェクト毎に立ち上げる

- Redmine(MySQL)
- Subversion
- Jenkins
- GitLab
- Rocket.Chat(MongoDB)
- Kibana(ElasticSearch/fluentd)

## URL

- プロジェクト名をコンテキストパスとする
- 各サービスのURLは以下の予定
  - redmine
  - svn
  - jenkins
  - gitlab
  - rocketchat
  - kibana

e.g)http(s)://hostname/projectname/redmine
