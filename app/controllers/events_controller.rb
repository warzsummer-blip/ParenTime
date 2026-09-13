class EventsController < ApplicationController
  # ログインしていないユーザーはログイン画面へリダイレクト
  before_action :authenticate_user!

  def index
    # ログイン中の教員が作成したイベント一覧を取得
    @events = current_user.events.order(created_at: :desc)
  end

  def show
    # 自分のイベントを取得
    @event = current_user.events.find(params[:id])
    @candidates = @event.candidates.order(:start_at)
    @attendees = @event.attendees
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

  private

  def event_params
    params.require(:event).permit(:title, :description, :slot_duration)
  end
end