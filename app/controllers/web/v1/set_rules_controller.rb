class Web::V1::SetRulesController < ApplicationController
  before_action :set_set_rule, only: [:show, :update, :destroy]

  # GET /web/v1/set_rules
  # GET /web/v1/set_rules.json
  def index
    @set_rules = SetRule.all.order("updated_at DESC").order("created_at DESC")

    render json: @set_rules
  end

  # GET /web/v1/set_rules/1
  # GET /web/v1/set_rules/1.json
  def show
    render json: @set_rule
  end

  # POST /web/v1/set_rules
  # POST /web/v1/set_rules.json
  def create
    @set_rule = SetRule.new(set_rule_params)

    if @set_rule.save
      render json: @set_rule, status: :created
    else
      render json: @set_rule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web/v1/set_rules/1
  # PATCH/PUT /web/v1/set_rules/1.json
  def update
    @set_rule = SetRule.find(params[:id])

    if @set_rule.update(set_rule_params)
      head :no_content
    else
      render json: @set_rule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web/v1/set_rules/1
  # DELETE /web/v1/set_rules/1.json
  def destroy
    @set_rule.destroy

    head :no_content
  end

  private

    def set_set_rule
      @set_rule = SetRule.find(params[:id])
    end

    def set_rule_params
      params.require(:set_rule).permit(:days, :category, :active)
    end
end
