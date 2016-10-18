class UserManualRemindersController < InheritedResources::Base

  private

    def user_manual_reminder_params
      params.require(:user_manual_reminder).permit(:rem_time, :title, :description)
    end
end

