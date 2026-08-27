# ParenTime
保護者向け日程調整Webアプリケーション
# サービス名 (例: parent-scheduler)
> 保護者間の複雑な日程調整を3ステップで完結させるWebアプリケーション

[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1.0-red.svg)](https://rubyonrails.org/)
[![Database](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)

## 📌 サービス概要
本サービスは、PTA活動や子ども会の行事における「保護者同士の日程調整の負担」を解消するためのツールです。
回答者のユーザー登録を不要にし、スマートフォンから直感的に空き時間を回答できます。

- **WebサイトURL**: https://your-app-domain.com
- **テスト用ログイン情報**:
  - Email: `guest@example.com`
  - Password: `password1234`

---

## 💡 開発背景と課題解決
### 解決したい課題
LINEグループや紙による日程調整は、「メッセージが埋もれる」「全員の回答確認に時間がかかる」「プライベートな予定を提示しづらい」という問題がありました。

### 解決策
- URL共有のみで即回答できる機能（ログインハードルの撤廃）
- 候補日時ごとの集計結果をビジュアル表示（最適な決定をサポート）

---

## 🛠️ 使用技術と選定理由

### バックエンド
- **Ruby 3.3 / Ruby on Rails 7.1**
  - MVCパターンによる見通しの良い設計、およびGem Ecosystem（Devise等）を活用した堅牢かつ迅速な機能実装のため。

### フロントエンド
- **HTML5 / CSS3 / SCSS / jQuery**
  - ドム操作や非同期通信（Ajax）を軽量かつシンプルに実装するため。
  - レスポンシブ対応（CSS Media Queries）により、保護者がスマホから快適に操作できるUIを構築。

### データベース
- **PostgreSQL**
  - 行事・候補日時・回答データの複雑なリレーション構築に適しており、本番環境への高い親和性とデータ整合性を確保するため。

### 開発環境・CI/CD
- **Docker / Docker Compose**: ローカル開発環境の統一化
- **RSpec**: モデル単体テスト・リクエストテストの自動化
- **RuboCop**: 静的コード解析によるコード品質管理

---

## 🏗️ DB設計（ER図）

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
