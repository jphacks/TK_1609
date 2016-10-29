module Api
  module V1
    class RecordsController < ApplicationBaseController
      before_action :set_record, only: [:show, :edit, :update, :destroy]
      def index
        @records = Record.all
      end

      def show
      end

      def new
        @record = Record.new
      end

      def edit
      end

      def create
        @record = Record.new(record_params)
        # music_id = params[:music_id]
        # @music = Music.create(id: music_id)
        respond_to do |format|
          if @record.save
            format.html { redirect_to @record, notice: 'Record was successfully created.' }
            format.json { render :show, status: :created, location: @record }
          else
            format.html { render :new }
            format.json { render json: @record.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        respond_to do |format|
          if @record.update(record_params)
            format.html { redirect_to @record, notice: 'Record was successfully updated.' }
            format.json { render :show, status: :ok, location: @record }
          else
            format.html { render :edit }
            format.json { render json: @record.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @record.destroy
        respond_to do |format|
          format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
          format.json { head :no_content }
        end
      end

      private
        def set_record
          @record = Record.find(params[:id])
        end

        def record_params
          params.require(:record).permit(:title, :introduction, :effect, :movie, :dancer_id, :music_id)
        end
    end
  end
end
