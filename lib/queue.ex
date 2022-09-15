defmodule Queue do
  use GenServer
  require Logger

  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    Logger.info("Iniciando Queue")
    {:ok, state}
  end

  @impl true
  def handle_call({:push, element}, _from, state) do
    new_state = [element | state]
    {:reply, new_state, new_state}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  def enqueue(pid, item) do
    GenServer.cast(pid, {:push, item})
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end
end
