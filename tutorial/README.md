Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

### Flow

こちらを参考に
-> https://zenn.dev/yutaro/articles/dbt_tutorial_with_duckdb#:~:text=%E3%81%A8%E6%80%9D%E3%81%84%E3%81%BE%E3%81%99%E3%80%82-,DuckDB%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB,-%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%81%A7DB

- version 設定 

```
duckdb = 0.10.3
dbt-core = 1.8.9
dbt-duckdb = 1.8.4
```

- duckdb install

```
curl -OL https://github.com/duckdb/duckdb/releases/download/v0.10.3/duckdb_cli-osx-universal.zip
unzip duckdb_cli-osx-universal.zip
```

- dbt version

https://github.com/dbt-labs/dbt-core/releases を参考に2024/12時点のlatestに設定する

```
pip install dbt-core==1.8.9 dbt-duckdb==1.8.4
```

- get toy data

- Desktop/japanr_dbtplyr というディレクトリを作った想定で、以下のようなtreeになる。

```
├── duckdb
├── duckdb_cli-osx-universal.zip
├── logs
│   └── dbt.log
├── tutorial
│   ├── README.md
│   ├── analyses
│   ├── data
│   │   ├── raw_customers.csv
│   │   └── raw_orders.csv
│   ├── dbt_project.yml
│   ├── macros
│   ├── models
│   │   ├── customers.sql
│   │   └── schema.yml
│   ├── seeds
│   ├── snapshots
│   └── tests
└── tutorial.db
```

- この場合 `~/.dbt/profiles.yml` は以下のように設定する

```
tutorial:
  outputs:
    dev:
      type: duckdb
      path: ~/Desktop/japanr_dbtplyr/duckdb/
  target: dev
  ````


  - db　に登録

```
./duckdb tutorial.db

CREATE TABLE raw_customers AS SELECT * FROM 'tutorial/data/raw_customers.csv';
CREATE TABLE raw_orders AS SELECT * FROM 'tutorial/data/raw_orders.csv';
CREATE TABLE raw_payments AS SELECT * FROM 'tutorial/data/raw_payments.csv';

```


- dbt packagesを追加

https://docs.getdbt.com/docs/build/packages

```
dbt deps
```

- dbt docsを生成

```
dbt docs generate
dbt docs serve
```