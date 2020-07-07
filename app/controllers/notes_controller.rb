# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = Note.where(user_id: current_user.id)
  end
end
