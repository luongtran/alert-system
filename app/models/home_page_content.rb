class HomePageContent < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :title, :notepad_notetext, :introduce_lead,
                  :introduce_inf_1, :introduce_inf_2, :introduce_inf_3, :signupquick_lead,
                  :notice, :halfpage_lead, :halfpage_content,
                  :pagefoot_inforunit1_head, :pagefoot_inforunit1_content,
                  :pagefoot_inforunit2_head, :pagefoot_inforunit2_content,
                  :pagefoot_inforunit3_head, :pagefoot_inforunit3_content,
                  :pagefoot_inforunit4_head, :pagefoot_inforunit4_content, :active

end
