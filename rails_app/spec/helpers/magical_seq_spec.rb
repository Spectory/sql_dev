require 'spec_helper'

describe 'magical_seq' do
  before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  it 'is should increment increment magical_magical_id for Charms & Potion' do
    base_magical_id = (Potion.create(name: 'p1')).magical_id
    expect(Charm.create(name: 'c1').magical_id).to be(base_magical_id + 1)
    expect(Charm.create(name: 'c1').magical_id).to be(base_magical_id + 2)
    expect(Potion.create(name: 'p2').magical_id).to be(base_magical_id + 3)
  end
end
