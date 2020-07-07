# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = Note.where(user_id: current_user.id)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(notes_params)

    if @note.save
      flash[:notice] = t('notes.create.success')
      redirect_to note_path(@note.id)
    else
      render :new
    end
  end

  def show
    @note = Note.find_by(params[:id])
  end

  private

  def notes_params
    params.require(:note).permit(:user_id, :subject, :text)
  end
end
