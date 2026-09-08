# ParenTime
教員（担任）向け日程調整Webアプリケーション
# サービス名 (例: ParenTime)
> 保護者-教員間の複雑な日程調整Webアプリケーション

[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.1.0-red.svg)](https://rubyonrails.org/)
[![Database](https://img.shields.io/badge/PostgreSQL-16-blue.svg)](https://www.postgresql.org/)

## 1.サービス概要
本サービスは、保護者懇談における「保護者と教員間の日程調整の負担」を解消するためのツールです。
保護者のユーザー登録を不要にし、スマートフォンから直感的に都合のよい日時を回答できます。

- **WebサイトURL**: 
- **テスト用ログイン情報**:
  - Email:
  - Password:

---

## 2.開発背景と課題解決
### 解決したい課題
・紙媒体での集計や調整に時間がかかる  
・兄弟姉妹が別クラスに在籍している場合でも、懇談時間が連続するよう調整する  
・スケジュール確定の遅れ  
・直前の変更やキャンセル  
・教員側の回収・集計・日程調整の負担  

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
- 
- 
- 
---

## 4.DB設計（ER図）

```mermaid
erDiagram
    USERS ||--o{ EVENTS : "creates"
    EVENTS ||--|{ CANDIDATES : "has"
    EVENTS ||--o{ ATTENDEES : "receives"
    ATTENDEES ||--|{ RESPONSES : "makes"
    CANDIDATES ||--o{ RESPONSES : "has"

    USERS {
        bigint id PK
        string email "教員ログイン用メール"
        string encrypted_password "暗号化パスワード"
        string name "教員名"
    }

    EVENTS {
        bigint id PK
        bigint user_id FK
        string title "イベント名（例: 10月保護者懇談）"
        text description "案内文"
        integer slot_duration "枠の時間（例: 15分）"
        string token "保護者共有用URLトークン"
    }

    CANDIDATES {
        bigint id PK
        bigint event_id FK
        datetime start_at "開始日時（例: 10/1 10:00）"
        datetime end_at "終了日時（例: 10/1 10:15）"
    }

    ATTENDEES {
        bigint id PK
        bigint event_id FK
        bigint confirmed_candidate_id FK "確定した候補枠ID（未確定ならNULL）"
        string parent_name "保護者名"
        string child_name "児童名"
        string grade_class "クラス（例: 3年1組）"
        string sibling_info "兄弟・姉妹の情報（任意）"
        string note "備考・連絡事項"
    }

    RESPONSES {
        bigint id PK
        bigint attendee_id FK
        bigint candidate_id FK
        integer status "0: NG, 1: OK, 2: Pending(可)"
    }
