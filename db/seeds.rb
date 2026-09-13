# 既存データをリセット（親から順に削除）
Response.destroy_all
Attendee.destroy_all
Candidate.destroy_all
Event.destroy_all
User.destroy_all

puts "データを削除しました。新しいデータを追加します..."

# 1. 教員（ユーザー）の作成
teacher = User.create!(
  name: "山田 太郎先生",
  email: "teacher@example.com",
  password: "password",
  password_confirmation: "password"
)

# 2. イベント（行事）の作成
event = Event.create!(
  user: teacher,
  title: "令和８年度 11月保護者懇談",
  description: "11月の保護者懇談の日程調整です。ご都合の良い日時を選択してください。",
  slot_duration: 15
)

# 3. 候補日時の作成 (例: 3つの枠)
candidate1 = Candidate.create!(
  event: event,
  start_at: DateTime.new(2024, 10, 15, 13, 0),
  end_at: DateTime.new(2024, 10, 15, 13, 15)
)

candidate2 = Candidate.create!(
  event: event,
  start_at: DateTime.new(2024, 10, 15, 13, 15),
  end_at: DateTime.new(2024, 10, 15, 13, 30)
)

candidate3 = Candidate.create!(
  event: event,
  start_at: DateTime.new(2024, 10, 15, 13, 30),
  end_at: DateTime.new(2024, 10, 15, 13, 45)
)

# 4. 参加保護者の作成
attendee = Attendee.create!(
  event: event,
  user: teacher,
  parent_name: "佐藤 花子",
  child_name: "佐藤 一郎",
  grade_class: "3年1組",
  sibling_info: "弟（1年2組）がいます",
  note: "少し早めの時間帯を希望します。"
)

# 5. 保護者回答の作成
Response.create!(attendee: attendee, candidate: candidate1, status: :ok)
Response.create!(attendee: attendee, candidate: candidate2, status: :pending)
Response.create!(attendee: attendee, candidate: candidate3, status: :ng)

puts "テストデータの作成が完了しました！"