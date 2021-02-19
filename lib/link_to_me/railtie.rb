module LinkToMe
  class Railtie < Rails::Railtie
    initializer "link_to_me.configure_rails_initialization" do
      ActiveSupport.on_load(:action_view) do
        ActionView::Helpers::UrlHelper.send(:include, LinkToMe)
      end
    end
  end
end
