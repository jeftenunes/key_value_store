defmodule KeyValueStore.Boundary.ServerProcess do
  @moduledoc """
  Documentation for `KeyValueStore.Boundary.ServerProcess`.

  O server process generico deve realizar as seguintes funcoes:any()
  => Startar um processo separado
  => Implementar um loop infinito nesse processo
  => Manter o estado do processo
  => Reagir a mensagens
  => Enviar uma resposta ao caller
  """

  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init()
      loop(callback_module, initial_state)
    end)
  end

  defp loop(callback_module, current_state) do
    receive do
      {req, caller} ->
        {res, new_state} = callback_module.handle_call(req, current_state)
        send(caller, {:response, res})

        loop(callback_module, new_state)
    end
  end

  def call(server_pid, request) do
    send(server_pid, {request, self()})

    receive do
      {:response, res} ->
        res
    end
  end
end
