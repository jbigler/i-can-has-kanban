# frozen_string_literal: true

# Lists Controller
class ListsController < ApplicationController
  before_action :set_board, only: %i[index new create]
  before_action :set_list, only: %i[show edit update destroy]

  # GET /lists or /lists.json
  def index
    @lists = @board.lists.rank(:row_order)
  end

  # GET /lists/1 or /lists/1.json
  def show; end

  # GET /lists/new
  def new
    @list = @board.lists.new
    authorize @list
  end

  # GET /lists/1/edit
  def edit; end

  # POST /lists or /lists.json
  def create
    @list = authorize @board.lists.new(list_params)
    @list.save
    redirect_to @board
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    @list.update(list_params)
    redirect_back_or_to @list.board, status: :see_other
  end

  # DELETE /lists/1 or /lists/1.json
  def destroy
    board = @list.board
    @list.destroy!
    redirect_to board_path(board)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = authorize List.find(params[:id])
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:board_id, :title, :row_order_position)
    end
end
