defmodule KeyValueStore do
  alias KeyValueStore.Boundary, as: Boundary

  def start, do: Boundary.start()
  def get(store_pid, key), do: Boundary.get(store_pid, key)
  def put(store_pid, key, value), do: Boundary.put(store_pid, {key, value})
end
