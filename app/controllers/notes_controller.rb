# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
