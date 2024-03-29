# frozen_string_literal: true

# Boards Controller
class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  before_action :set_workspace, only: %i[index new create]

  # GET /boards or /boards.json
  def index
    @boards = @workspace.boards.all
  end

  # GET /boards/1 or /boards/1.json
  def show
    @board = Board.where(id: params[:id]).preload(sorted_lists: :sorted_cards).first
    authorize @board
  end

  # GET /boards/new
  def new
    @board = @workspace.boards.new
    authorize @board
  end

  # GET /boards/1/edit
  def edit; end

  # POST /boards or /boards.json
  def create
    @board = @workspace.boards.new(board_params)
    authorize @board

    respond_to do |format|
      if @board.save
        format.html { redirect_to workspace_url(@workspace), notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    workspace = @board.workspace
    @board.destroy!

    respond_to do |format|
      format.html { redirect_to workspace_url(workspace), notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
      authorize @board
    end

    def set_workspace
      @workspace = Current.user.workspaces.find(params[:workspace_id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:workspace_id, :name)
    end
end
