defmodule KeyValueStore.Boundary do
  alias KeyValueStore.Boundary.ServerProcess, as: ServerProcess

  def start, do: ServerProcess.start(KeyValueStore.Core.KeyValueStoreCore)

  def get(pid, key), do: ServerProcess.call(pid, {:get, key})
  def put(pid, {key, value}), do: ServerProcess.call(pid, {:put, key, value})
end
