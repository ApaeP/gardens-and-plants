class PlantTagsController < ApplicationController
  def new
    @plant = Plant.find(params[:plant_id])
    @plant_tag = PlantTag.new
  end

  def create
    @plant = Plant.find(params[:plant_id])
    # params[:plant_tag][:tag_id] = ["1", "2", "4"]
    @tags = Tag.where(id: params.dig(:plant_tag, :tag)) # On peut passer un array à where 🥳
    @tags.each do |tag|
      plant_tag = PlantTag.new
      plant_tag.tag = tag
      plant_tag.plant = @plant
      plant_tag.save
    end
    redirect_to garden_path(@plant.garden)

  # voici ce qui aurait pu etre fait pour passer les validations et rollback si une erreur est raised
  #   @plant = Plant.find(params[:plant_id])
  #   @tags = Tag.where(id: params.dig(:plant_tag, :tag))
  #   return render_new if @tags.empty?

  #   ActiveRecord::Base.transaction do
  #     @tags.each do |tag|
  #       plant_tag = PlantTag.new(plant: @plant, tag: tag)
  #       plant_tag.save!
  #     end
  #     redirect_to garden_path(@plant.garden)
  #   end
  # rescue ActiveRecord::RecordInvalid
  #   render_new
  end

  private

  def plant_tag_params
    params.require(:plant_tag).permit(tag_id: [])
  end
end
