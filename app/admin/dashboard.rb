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
               label = ["#{provider.name}"]
               unless provider.addresses.empty?
                 label << ["#{provider.addresses[0].locality}"] unless provider.addresses[0].nil?
                 label << ["#{provider.addresses[0].state}"] unless provider.addresses[0].state.nil?
               end
               li link_to(label.join(', '), admin_provider_path(provider))
             end
           end
         end
       end

       column do
         panel "Current Statistics" do
           h6 "Providers" 
           ul do
             li "Total: #{Provider.count}"
               ul  do
                 li "New South Wales: #{Address.where(:state => 'NSW').count}"
                 li "Northern Territories: #{Address.where(:state => 'NT').count}"
                 li "Queensland: #{Address.where(:state => 'QLD').count}"
                 li "South Australia: #{Address.where(:state => 'SA').count}"
                 li "Victoria: #{Address.where(:state => 'VIC').count}"
                 li "Western Australia: #{Address.where(:state => 'WA').count}"
               end
             li "Total Places: #{Provider.sum(:approved_places)}"
             li "Total Vacancies: #{Provider.where(:vacancies => :true).count}"
           end
           h6 "Agencies" 
           ul do
             li "Total: #{Agency.count}"
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
         panel "Announcements" do
           para "Welcome to Daycare Decisions."
           para "Data Collection begins in April."
         end
       end

     end # columns
  end # content


end
