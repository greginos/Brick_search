class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]

  def index
    @boxes = []
    Box.all.each do |box|
      if box.parts.length.positive?
        @boxes << box
      end
    end
    @boxes
    # @boxes = Box.all.sample(100)
    # @boxes = Box.all
  end

  def find_compatibilities(box)
    @boxes = Box.all
    @boxes.each do |a_box|
      @array1 = box.parts
      @array2 = a_box.parts
      @intersection = @array1 & @array2
      if !@intersection.empty?
        puts "#{@intersection.size} Matches Found."
      else
        puts "No Matches Found."
      end
    end
  end

  def show
    # ...
  end

  def edit
    # ...
  end

  def update
    # ...
  end

  def destroy
    @box.destroy
  end

  private

  def set_box
    @box = Box.find(params[:id])
  end
end
