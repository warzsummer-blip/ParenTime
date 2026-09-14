# 既存データのクリア（順序依存を防ぐためリセット）
Response.destroy_all
Attendee.destroy_all
Candidate.destroy_all
Event.destroy_all
User.destroy_all

puts "旧データを消去しました。"

# 1. テスト用教員の作成
teacher = User.create!(
  email: "teacher@example.com",
  password: "password",
  password_confirmation: "password"
)
puts "教員ユーザーを作成しました: teacher@example.com / password"

# 2. テスト用イベントの作成
event = Event.create!(
  user: teacher,
  title: "2026年度 後期 保護者個人懇談会",
  description: "各クラスごとに希望日時を集計し、懇談日時を決定します。",
  slot_duration: 15
)
puts "イベントを作成しました: #{event.title}"

# 3. 候補日時（Candidate）の作成（10/15 の 4枠）
c1 = event.candidates.create!(start_at: "2026-10-15 13:00:00", end_at: "2026-10-15 13:15:00")
c2 = event.candidates.create!(start_at: "2026-10-15 13:15:00", end_at: "2026-10-15 13:30:00")
c3 = event.candidates.create!(start_at: "2026-10-15 13:30:00", end_at: "2026-10-15 13:45:00")
c4 = event.candidates.create!(start_at: "2026-10-15 13:45:00", end_at: "2026-10-15 14:00:00")
candidates = [c1, c2, c3, c4]
puts "候補日時枠を4つ作成しました。"

# 4. テスト用保護者（Attendee）と希望回答（Response）の作成

# 【1年1組データ】
attendees_class1 = [
  { parent: "佐藤 健",   child: "佐藤 一郎", responses: { c1.id => "ok",      c2.id => "pending", c3.id => "ng",      c4.id => "ng" } },
  { parent: "鈴木 恵",   child: "鈴木 二郎", responses: { c1.id => "ok",      c2.id => "ok",      c3.id => "pending", c4.id => "ng" } },
  { parent: "高橋 花",   child: "高橋 三郎", responses: { c1.id => "pending", c2.id => "ok",      c3.id => "ok",      c4.id => "ok" } }
]

attendees_class1.each do |data|
  attendee = event.attendees.create!(
    parent_name: data[:parent],
    child_name: data[:child],
    grade_class: "1年1組"
  )
  data[:responses].each do |candidate_id, status|
    attendee.responses.create!(candidate_id: candidate_id, status: status)
  end
end

# 【1年2組データ】（※同じ日時枠に対して異なる希望回答をテスト）
attendees_class2 = [
  { parent: "田中 誠",   child: "田中 四郎", responses: { c1.id => "ok",      c2.id => "ng",      c3.id => "ng",      c4.id => "pending" } },
  { parent: "渡辺 裕子", child: "渡辺 五月", responses: { c1.id => "pending", c2.id => "ok",      c3.id => "ok",      c4.id => "ng" } },
  { parent: "伊藤 順",   child: "伊藤 六郎", responses: { c1.id => "ok",      c2.id => "ok",      c3.id => "pending", c4.id => "ok" } }
]

attendees_class2.each do |data|
  attendee = event.attendees.create!(
    parent_name: data[:parent],
    child_name: data[:child],
    grade_class: "1年2組"
  )
  data[:responses].each do |candidate_id, status|
    attendee.responses.create!(candidate_id: candidate_id, status: status)
  end
end

puts "1年1組（3名）と 1年2組（3名）の回答データを投入しました。"