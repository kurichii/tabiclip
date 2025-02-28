class RemindersController < ApplicationController
  def create
    @list_item = ListItem.find(params[:list_item_id])
    @check_list = @list_item.check_list
    @reminder = @list_item.build_reminder(reminder_params)
      if @reminder.save
        flash.now.notice = t("defaults.flash_message.created", item: Reminder.model_name.human)
        render turbo_stream: [
          # turbo_stream.remove("reminder_modal"),
          turbo_stream.replace("list_item_#{@list_item.id}", partial: "list_items/list_item", locals: { list_item: @list_item, reminder: @reminder }),
          turbo_stream.update("flash_messages", partial: "shared/flash_message")
        ]
      else
        # flash.now.alert = t("defaults.flash_message.not_created", item: Reminder.model_name.human)
        render turbo_stream: [
          turbo_stream.update("reminder_form_#{@list_item.id}", partial: "reminders/form", locals: { list_item: @list_item, reminder: @reminder }),
          turbo_stream.update("flash_messages", partial: "shared/flash_message"),
        ]
      end
  end

  def update
    @reminder = Reminder.find(params[:id])
    @list_item = @reminder.list_item
    @check_list = @list_item.check_list

    if @reminder.update(reminder_params)
      flash.now.notice = t("defaults.flash_message.updated", item: Reminder.model_name.human)
      render turbo_stream: [
        # turbo_stream.remove("reminder_modal"),
        turbo_stream.replace("list_item_#{@list_item.id}", partial: "list_items/list_item", locals: { list_item: @list_item, reminder: @reminder }),
        turbo_stream.update("flash_messages", partial: "shared/flash_message")
      ]
    else
      # flash.now.alert = t("defaults.flash_message.not_updated", item: Reminder.model_name.human)
      render turbo_stream: [
        turbo_stream.update("reminder_form_#{@list_item.id}", partial: "reminders/form", locals: { list_item: @list_item, reminder: @reminder }),
        turbo_stream.update("flash_messages", partial: "shared/flash_message"),
        # turbo_stream.replace("modal", partial: "reminders/modal", locals: { list_item: @list_item, reminder: @reminder }),
        # turbo_stream.update("flash_messages", partial: "shared/flash_message")
      ]
    end
  end

  private
  def reminder_params
    params.require(:reminder).permit(:reminder_date)
  end
end
