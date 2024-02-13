class CardsController < ApplicationController
  before_action :set_card, only: %i[show edit update destroy]
  before_action :set_list, only: %i[index new create]

  # GET /cards or /cards.json
  def index
    @cards = @list.cards.rank(:row_order)
  end

  # GET /cards/1 or /cards/1.json
  def show; end

  # GET /cards/new
  def new
    @card = @list.cards.new
  end

  # GET /cards/1/edit
  def edit; end

  # POST /cards or /cards.json
  def create
    @card = @list.cards.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        # format.json { render :show, status: :ok, location: @card }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    list = @card.list
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to list_cards_url(list), notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:row_order_position, :list_id, :title, :description)
  end
end
