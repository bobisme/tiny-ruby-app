require_relative 'db'
require_relative 'thing'

class ThingStore
  def initialize
    @conn = DB.conn
  end

  private def record_to_model(record)
    Thing.new(
      id: record['id'],
      name: record['name'],
      created_at: record['created_at'],
    )
  end

  def create(thing)
    @conn
      .prepare(
        %{
          INSERT INTO things (
            id, name
          ) VALUES (
            ?, ?
          )
        }
      ).execute(thing.id, thing.name)
    get(thing.id)
  end

  def list
    @conn
      .query(%{ SELECT * FROM things; })
      .map { |x| record_to_model(x) }
  end

  def get(id)
    @conn
      .prepare(%{ SELECT * FROM things WHERE id=? ORDER BY created_at })
      .execute(id)
      .map { |x| record_to_model(x) }
      .first
  end
end
