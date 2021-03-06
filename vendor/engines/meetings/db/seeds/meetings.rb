User.all.each do |user|
  if user.plugins.where(:name => 'meetings').blank?
    user.plugins.create(:name => 'meetings',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

page = Page.create(
  :title => 'Meetings',
  :link_url => '/meetings',
  :deletable => false,
  :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
  :menu_match => '^/meetings(\/|\/.+?|)$'
)
Page.default_parts.each do |default_page_part|
  page.parts.create(:title => default_page_part, :body => nil)
end
