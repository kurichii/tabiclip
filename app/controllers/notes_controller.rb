class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_travel_book, only: %i[ index new create ]
  before_action :set_note, only: %i[ show edit update destroy ]

  def index
    @notes = @travel_book.notes
  end

  def new
    @note = Note.new
  end

  def create
    @note = @travel_book.notes.build(note_params)
    if @note.save
      redirect_to travel_book_notes_path(@travel_book.uuid), notice: t("defaults.flash_message.created", item: Note.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created")
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @note.update(note_params)
      redirect_to note_path(@note), notice: t("defaults.flash_message.updated", item: Note.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Note.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy
    redirect_to travel_book_notes_path(@travel_book.uuid), notice: t("defaults.flash_message.deleted", item: Note.model_name.human)
  end

  private

  def set_travel_book
    @travel_book = current_user.travel_books.find_by(uuid: params[:travel_book_uuid])
  end

  def set_note
    @note = Note.find(params[:id])
    @travel_book = @note.travel_book
  end

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
