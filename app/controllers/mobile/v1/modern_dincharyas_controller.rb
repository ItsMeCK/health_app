class ModernDincharyasController < InheritedResources::Base

  private

    def modern_dincharya_params
      params.require(:modern_dincharya).permit(:title, :reminder_time, :description)
    end
end

