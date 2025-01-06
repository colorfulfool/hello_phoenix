defmodule HelloPhoenixWeb.FlagComponents do
  use Phoenix.Component

  attr :enabled, :boolean, required: true
  attr :rest, :global

  def toggle(assigns) do
    ~H"""
    <button
      class={"w-20 h-12 #{if @enabled, do: "bg-green-500", else: "bg-zinc-200"} rounded-lg p-1 flex #{@enabled && "justify-end"}"}
      {@rest}
    >
      <div class="w-10 h-10 bg-white rounded" />
    </button>
    """
  end
end
