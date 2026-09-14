class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:show, :confirm_attendee, :auto_schedule, :reset_schedule]

  def index
    @events = current_user.events.order(created_at: :desc)
  end

  def show
    @candidates = @event.candidates.order(:start_at)
    @attendees = @event.attendees.includes(responses: :candidate, confirmed_candidate: :responses)
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "行事を作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 手動確定
  def confirm_attendee
    @attendee = @event.attendees.find(params[:attendee_id])
    if @attendee.update(confirmed_candidate_id: params[:confirmed_candidate_id])
      redirect_to @event, notice: "#{@attendee.child_name} さんの日時を確定しました。"
    else
      redirect_to @event, alert: "日時の確定に失敗しました。"
    end
  end

  # ★ 一括自動確定アクション
  def auto_schedule
    AutoScheduler.new(@event).call
    redirect_to @event, notice: "希望調査に基づき、自動で日程調整を行いました！"
  end

  # ★ 一括リセットアクション（やり直したい時用）
  def reset_schedule
    @event.attendees.update_all(confirmed_candidate_id: nil)
    redirect_to @event, notice: "すべての確定日程をリセットしました。"
  end

  private

  def set_event
    @event = current_user.events.find(params[:id] || params[:event_id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :slot_duration)
  end
end