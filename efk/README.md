# kibana上の Dev Tools で叩くためのコマンドメモ

- マッピング確認

```
GET /_mapping
```

- マッピングテンプレート作成

```
PUT /_template/logstash 
{
  "template": "logstash-*",
  "mappings": {
    "fluent": {
      "properties": {
        "location": {
          "type": "geo_point"
        }
      }
    }
  }
}
```

- マッピングテンプレート確認

```
GET _template/logstash
```

- 対象インデックスのマッピング確認

```
GET /logstash-XXXX.XX.XX
```
