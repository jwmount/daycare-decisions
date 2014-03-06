ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }


  content :title => proc{ I18n.t("active_admin.dashboard") } do

    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
     columns do

       column do
         panel "Five Most Recently Updated Providers" do
           ul do
             Provider.order("updated_at DESC").limit(5).map do |provider|
               label = "#{provider.name}, #{provider.addresses[0].locality}, #{provider.addresses[0].state}"
               li link_to(label, admin_provider_path(provider))
             end
           end
         end
       end

       column do
         panel "Providers With Vacancies" do
           ul do
             Provider.where(:vacancies => :true).count 
           end
         end
       end

       column do
         panel "Waitlist Applications" do
           ul do
             WaitlistApplication.count
             end
         end
       end

       column do
         panel "Info" do
           para "Welcome to Daycare Decisions."
         end
       end

     end # columns
  end # content


end
