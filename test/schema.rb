ActiveRecord::Schema.define(:version => 1) do

  create_table "posts", :force => true do |t|
    t.string   "permalink",  :null => false
  end

  add_index "posts", "permalink", :unique => true
end
