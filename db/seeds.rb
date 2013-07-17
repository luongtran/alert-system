
free_role = Role.create(:name => 'free', :maximum_packages => 1, :unit_amount => 0)
small_role = Role.create(:name => 'small', :maximum_packages => 3, :unit_amount => 5)
medium_role = Role.create(:name => 'medium', :maximum_packages => 10, :unit_amount => 10)
large_role = Role.create(:name => 'large', :maximum_packages => 30, :unit_amount => 15)

user1 = User.find_or_create_by_email :first_name => 'Free', :last_name => 'User', :email => 'h.tluan2605@gmail.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 1, :check_date_time => DateTime.now
user1.add_role :free

user2 = User.find_or_create_by_email :first_name => 'Small', :last_name => 'User', :email => 'ht.luan2605.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 2, :check_date_time => DateTime.now
user2.add_role :small

user3 = User.find_or_create_by_email :first_name => 'Large', :last_name => 'User', :email => 'htl.uan2605.com', :password => '123123', :password_confirmation => '123123', :status => 'normal', :frequency => 3, :check_date_time => DateTime.now
user3.add_role :large

ItemType.create(:name => 'Text')
ItemType.create(:name => 'File')
ItemType.create(:name => 'Image')

#puts " -- > create Homepage content"
#HomePageContent.create :name => 'Default', :title => 'Alert System',
#                       :notepad_notetext => %{<p>Dear everyone,</p>
#                                            <p>Bad things happen. Sometimes, they happen to you. If something does happen, you might wish there was something you had told the people around you. How you feel, what you regret, where the money is stashed.</p>
#<p>For this, you need this site to keep things most important words want to say with your familiers when you can not.</p>
#                                                },
#                       :introduce_lead => "Start your Plan and <br/> keep best stuffs every day!",
#                       :introduce_inf_1 => "Bad things happen. Sometimes, they happen to you. If something does happen, you might wish there was something you had told the people around you.",
#                       :introduce_inf_2 => "You write a few e-mails and choose the recipients. These emails are stored securely, so you can be sure that no-one except the intended recipient will ever read them.",
#                       :introduce_inf_3 => "The emails are sent at certain intervals. By default, the switch will email you 30, 45, and 52 days after you last showed signs of life.",
#                       :signupquick_lead => "Easy to sign up! Choose a membership plan bellow, fill out the form and ...",
#                       :notice => "Notice: this is just to quick way to show you out system work. For more feautures please go to DashBoard page after you login with account!",
#                       :halfpage_lead => "Taking a tour to find out <br/>How the AlertSystem Work!",
#                       :halfpage_content => "Please use your name one you like best. This name will be a default name show on every newsletters - notification email we send to you, or package notifs email to your familiers you assigns",
#                       :pagefoot_inforunit1_head => "Everything started from Idea",
#                       :pagefoot_inforunit1_content => "Bad things happen. Sometimes, they happen to you. If something does happen, you might wish there was something you had told the people around you. How you feel, what you regret, where the money is stashed.",
#                       :pagefoot_inforunit2_head => "Keep your love to familiers",
#                       :pagefoot_inforunit2_content => "Let's us keep watching everyday and send you noticifation over Email - Message - more and more ways in futured. You always know that familiers will have last wish when ever you stop say 'now iam not alive'!",
#                       :pagefoot_inforunit3_head => "Private data 100%",
#                       :pagefoot_inforunit3_content => "We sure all your data save in our system is private with best security! Addition, you also have more and more functions to controll packages - items if upgrade to plane Premium Account.",
#                       :pagefoot_inforunit4_head => "Rich media data",
#                       :pagefoot_inforunit4_content => "From now, we provide 3 kinds of data : Textnote - Image - files (extension: zip, rar, 7zip and extensions not excute). We will try to take more kinds of data in future to you!",
#                       :active => true

AdminUser.create :email => 'admin@example.com', :password => 'password', :password_confirmation => 'password'
puts " -- > Seed completed !"
