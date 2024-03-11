# frozen_string_literal: true

# Cards Controller
class CardsController < ApplicationController
  before_action :set_card, only: %i[show edit update destroy]
  before_action :set_list, only: %i[index new create]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /cards or /cards.json
  def index
    @cards = @list.cards.rank(:row_order)
  end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = authorize @list.cards.new
  end

  # GET /cards/1/edit
  def edit; end

  # POST /cards or /cards.json
  def create
    @card = authorize @list.cards.new(card_params)
    @card.save
    redirect_to board_path @card.list.board
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    @card.update(card_params)
    redirect_back_or_to @card.list.board, status: :see_other
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    list = @card.list
    @card.destroy!
    redirect_to board_path(list.board)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = authorize Card.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def user_not_authorized
      @card = Card.find(params[:id])
      render :show
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:row_order_position, :list_id, :title, :description, :color)
    end
end
