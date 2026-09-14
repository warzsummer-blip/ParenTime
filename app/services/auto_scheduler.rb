class AutoScheduler
  def initialize(event)
    @event = event
  end

  def call
    # クラス（grade_class）ごとに保護者をグループ化
    attendees_by_class = @event.attendees.includes(:responses).group_by(&:grade_class)
    candidates = @event.candidates.order(:start_at).to_a

    # 全体で枠が重複しないように管理するSet
    assigned_candidate_ids = Set.new

    attendees_by_class.each do |_grade_class, attendees|
      # 1段階目: 「◯ (ok)」を出している保護者を優先割り当て
      assign_responses(attendees, assigned_candidate_ids, status: "ok")

      # 2段階目: まだ未決定の保護者に「△ (pending)」を割り当て
      unassigned = attendees.select { |a| a.confirmed_candidate_id.nil? }
      assign_responses(unassigned, assigned_candidate_ids, status: "pending")
    end

    true
  end

  private

  def assign_responses(attendees, assigned_candidate_ids, status:)
    attendees.each do |attendee|
      next if attendee.confirmed_candidate_id.present?

      response = attendee.responses.find do |r|
        r.status == status && !assigned_candidate_ids.include?(r.candidate_id)
      end

      if response
        attendee.update(confirmed_candidate_id: response.candidate_id)
        assigned_candidate_ids.add(response.candidate_id)
      end
    end
  end
end