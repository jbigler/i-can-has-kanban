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
    @list = @board.lists.new(list_params)
    authorize @list

    respond_to do |format|
      if @list.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.before("new-list", partial: "list", locals: { list: @list })
        end
        format.html { redirect_to list_url(@list), notice: "List was successfully created." }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1 or /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("label_#{helpers.dom_id(@list)}", @list.title)
        end
        format.html { redirect_to list_url(@list), notice: "List was successfully updated." }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  # DELETE /lists/1 or /lists/1.json
  def destroy
    board = @list.board
    @list.destroy!

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(helpers.dom_id(@list))
      end
      format.html { redirect_to board_lists_url(board), notice: "List was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_position; end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
      authorize @list
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(:board_id, :title, :row_order_position)
    end
end
