# ParenTime
教員（担任）向け日程調整Webアプリケーション
# サービス名 (例: ParenTime)
> 保護者-教員間の複雑な日程調整を3ステップで完結させるWebアプリケーション

[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1.0-red.svg)](https://rubyonrails.org/)
[![Database](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)

## 1.サービス概要
本サービスは、保護者懇談における「保護者ー教員間の日程調整の負担」を解消するためのツールです。
回答者のユーザー登録を不要にし、スマートフォンから直感的に空き時間を回答できます。

- **WebサイトURL**: 
- **テスト用ログイン情報**:
  - Email:
  - Password:

---

## 2.開発背景と課題解決
### 解決したい課題
・紙媒体での集計や調整に時間がかかる
・兄弟姉妹がいる家庭の懇談時間の連続性を各クラス間で行うこと
・スケジュール確定の遅れ
・直前の変更やキャンセル

### 解決策
・URL共有のみで即回答できる機能（ログインハードルの撤廃）
・候補日時ごとの集計結果をビジュアル表示（最適な決定をサポート）

---

## 3.使用技術と選定理由

### バックエンド
- **Ruby 3.3 / Ruby on Rails 7.1**
  - MVCパターンによる見通しの良い設計、およびGem Ecosystem（Devise等）を活用した堅牢かつ迅速な機能実装のため。

### フロントエンド
- **HTML5 / CSS3 / SCSS / jQuery**
  - 非同期通信（Ajax）を軽量かつシンプルに実装するため。
  - レスポンシブ対応（CSS Media Queries）により、保護者がスマホから快適に操作できるUIを構築。

### データベース
- **PostgreSQL**
  - 行事・候補日時・回答データの複雑なリレーション構築に適しており、本番環境への高い親和性とデータ整合性を確保するため。

### 開発環境・CI/CD
- **Docker / Docker Compose**: ローカル開発環境の統一化
- **RSpec**: モデル単体テスト・リクエストテストの自動化
- **RuboCop**: 静的コード解析によるコード品質管理

---

## 4.DB設計（ER図）

```mermaid
erDiagram
    USERS ||--o{ EVENTS : "creates"
    EVENTS ||--|{ CANDIDATES : "has"
    CANDIDATES ||--o{ RESPONSES : "has"

    USERS {
        bigint id PK
        string email
        string encrypted_password
        string name
    }
    EVENTS {
        bigint id PK
        bigint user_id FK
        string title
        text description
        string token
    }
    CANDIDATES {
        bigint id PK
        bigint event_id FK
        datetime start_at
        datetime end_at
    }
    RESPONSES {
        bigint id PK
        bigint candidate_id FK
        string respondent_name
        integer status "0: NG, 1: OK, 2: Pending"
    }
