class ModernDincharyasController < InheritedResources::Base

  private

    def modern_dincharya_params
      params.require(:modern_dincharya).permit(:sleep_time, :wake_up_time, :break_fast_time, :lunch, :snacks_time, :sports, :hobbies, :dinner)
    end
end

