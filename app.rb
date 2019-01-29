require 'json'
require 'sinatra'
require_relative 'thing_store'

class ThingPresenter
  attr_reader :thing

  def initialize(thing)
    @thing = thing
  end

  def to_h
    {
      id: thing.id,
      name: thing.name,
      created_at: thing.created_at.utc.iso8601,
    }
  end

  def to_json
    to_h.to_json
  end
end

class App < Sinatra::Base
  configure do
    set :thing_store, ThingStore.new
  end

  get '/' do
    'hello'
  end

  post '/things' do
    thing = Thing.new(name: params.fetch(:name))
    created = settings.thing_store.create(thing)
    ThingPresenter.new(created).to_json
  end

  get '/things' do
    settings.thing_store.list.map { |x| ThingPresenter.new(x).to_h }.to_json
  end

  get '/things/:id' do
    thing = settings.thing_store.get(params.fetch(:id))
    halt(404) unless thing
    ThingPresenter.new(thing).to_json
  end
end
