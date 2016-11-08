class Mobile::V1::ActivitiesController < InheritedResources::Base

  private

    def activity_params
      params.require(:activity).permit(:name, :description, :image, :imageable_id, :imageable_type)
    end
end

