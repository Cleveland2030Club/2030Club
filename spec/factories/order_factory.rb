Factory.define :order do |f|
  f.amount 70
  f.after_build do |order|
    order.customer = Factory.build(:user)
    order.items << Factory.build(:item)
  end
end
