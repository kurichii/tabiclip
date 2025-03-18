class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @notes = @travel_book.notes
  end

  def new
    @travel_book = current_user.travel_books.find(params[:travel_book_id])
    @note = Note.new
  end

  def create
    @travel_book = current_user.travel_books.find(params[:travel_book_id])

    @note = @travel_book.notes.build(note_params)
    if @note.save
      redirect_to travel_book_notes_path(@travel_book), notice: t("defaults.flash_message.created")
    else
      flash.now[:alert] = t("defaults.flash_message.not_created")
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
    @travel_book = @note.travel_book
  end

  def edit
    @note = Note.find(params[:id])
    @travel_book = @note.travel_book
  end

  def update
    @note = Note.find(params[:id])
    @travel_book = @note.travel_book
    if @note.update(note_params)
      redirect_to note_path(@note), notice: t("defaults.flash_message.updated", item: Note.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Note.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @travel_book = @note.travel_book
    @note.destroy
    redirect_to travel_book_notes_path(@travel_book), notice: t("defaults.flash_message.deleted", item: Note.model_name.human)
  end

  private

  def note_params
    params.require(:note).permit(:title, :body)
  end
end
