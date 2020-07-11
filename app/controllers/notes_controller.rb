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
    @note.user_id = current_user.id

    if @note.save
      flash[:notice] = t('notes.create.success')
      redirect_to note_path(@note.id)
    else
      render :new
    end
  end

  def edit
    @note = Note.find_by(params[:id])
  end

  def update
    @note = Note.find_by(params[:id])

    if @note.update(notes_params)
      flash[:notice] = t('notes.update.success')
      redirect_to note_path(@note.id)
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find_by(params[:id])

    if @note.nil?
      flash[:alert] = t('notes.destroy.fail')
    else
      @note.destroy
      flash[:notice] = t('notes.destroy.success')
    end

    redirect_to root_path
  end

  def show
    @note = Note.find_by(params[:id])
  end

  private

  def notes_params
    params.require(:note).permit(:user_id, :subject, :text)
  end
end
