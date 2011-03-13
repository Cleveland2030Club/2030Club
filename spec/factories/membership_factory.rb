Factory.define :membership do |f|
  f.name 'Standard membership'
  f.after_build do |m|
    m.items = [Factory.build(:item, :product => m)] 
  end
end
