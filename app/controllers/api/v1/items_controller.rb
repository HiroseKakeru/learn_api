module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: [:show, :update, :destroy]

      # GET /api/v1/items
      def index
        items = Item.all
        render json: { status: 'SUCCESS', message: 'Loaded items', data: items }
      end

      # GET /api/v1/items/:id
      def show
        render json: { status: 'SUCCESS', message: 'Loaded the post', data: @item }
      end

      # POST /api/v1/items
      def create
        post = Item.new(item_params)
        if post.save
          render json: { status: 'SUCCESS', data: @item }
        else
          render json: { status: 'ERROR', data: @item.errors }
        end
      end

      # PUT /api/v1/items/:id
      def update
        if @item.update(item_params)
          render json: { status: 'SUCCESS', message: 'Updated the post', data: @item }
        else
          render json: { status: 'SUCCESS', message: 'Not updated', data: @item.errors }
        end
      end
      
      # DELETE /api/v1/items/:id
      def destroy
        @item.destroy
        render json: { status: 'SUCCESS', message: 'Deleted the post', data: @item }
      end

      private

      def set_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name)
      end
    end
  end
end
