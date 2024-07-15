defmodule KV do
  use Application

  @impl true
  def start(_type, _args) do
    # Although we don't use the supervisor name below directly,
    # it can be useful when debugging or introspecting the system.
    KV.Supervisor.start_link(name: KV.Supervisor)
  end

  def repl() do
    with line <- IO.read(:stdio, :line) |> String.trim(),
         {:ok, command} <- KV.Command.parse(line),
         {:ok, result} <- KV.Command.run(command)
    do
      IO.write(result)
    else
      err -> IO.inspect(err)
    end

    repl()
  end

  def start_observer() do
    Mix.ensure_application!(:wx)  # Not necessary on Erlang/OTP 27+
    Mix.ensure_application!(:runtime_tools) # Not necessary on Erlang/OTP 27+

    Mix.ensure_application!(:observer)
    :observer.start()
  end

  @doc """
  Hello world.

  ## Examples

      iex> KV.hello()
      :world

  """
  def hello do
    :world
  end
end
