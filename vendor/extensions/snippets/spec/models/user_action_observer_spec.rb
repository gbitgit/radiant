require 'snippets_spec_helper'

describe UserActionObserver do
  dataset :users, :pages_with_layouts, :snippets
  
  before(:each) do
    @user = users(:existing)
    UserActionObserver.current_user = @user
  end
  
  it 'should observe create' do
    snippet = Snippet.create!(snippet_params)
    snippet.created_by.should == @user
  end
  
  it 'should observe update' do
    [
      snippets(:first)
    ].each do |model|
      model.attributes = model.attributes.dup
      model.save.should == true
      model.updated_by.should == @user
    end
  end
end