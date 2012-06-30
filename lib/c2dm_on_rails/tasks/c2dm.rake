namespace :c2dm do
  
  namespace :notifications do
    
    desc "Deliver all unsent gcm notifications."
    task :deliver => [:environment] do
      C2dm::Notification.send_notifications
    end
    
  end
  
  namespace :group_notifications do
    
    desc "Deliver all unsent gcm group notifications."
    task :deliver => [:environment] do
      C2dm::Group.all.each do |group|
        group.send_notifications
      end
    end
    
  end
  
end
