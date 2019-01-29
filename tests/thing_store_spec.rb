require 'minitest/autorun'
require 'thing_store'
require 'db'

describe ThingStore do
  before do
    DB.conn.query('TRUNCATE things')
    @store = ThingStore.new(DB.conn)
  end

  describe '#create' do
    it 'inserts a thing into the database' do
      thing = Thing.new(name: 'some thing')
      @store.create(thing)
      res = DB.conn.query("SELECT '#{thing.id}' FROM things")
      assert_equal res.count, 1
    end
  end

  describe '#get' do
    it 'gets the thing from the database' do
      thing = Thing.new(
        id: '111111111111',
        name: 'some other thing',
      )
      @store.create(thing)
      out = @store.get(thing.id)
      assert_equal(
        [out.id, out.name],
        ['111111111111', 'some other thing']
      )
      assert(!out.created_at.nil?)
    end
  end

  describe '#list' do
    it 'lists all the things in the database' do
      things = [
        Thing.new(id: '111111111111', name: 'some other thing'),
        Thing.new(id: '222222222222', name: 'some thing')
      ]
      things.each { |x| @store.create(x) }
      list = @store.list
      assert_equal(
        list.map { |x| [x.id, x.name] },
        [
          ['111111111111', 'some other thing'],
          ['222222222222', 'some thing'],
        ]
      )
    end
  end
end
