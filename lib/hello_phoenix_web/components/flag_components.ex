defmodule HelloPhoenixWeb.FlagComponents do
  use Phoenix.Component

  attr :enabled, :boolean, required: true
  attr :rest, :global

  def toggle(assigns) do
    ~H"""
    <button
      class={"
        w-20 h-12 #{if @enabled, do: "bg-green-500", else: "bg-zinc-200"} 
        rounded-lg p-1 flex transition-all duration-200 relative
      "}
      {@rest}
    >
      <div class={"
        w-10 h-10 bg-white rounded transition-all duration-200 
        absolute #{if @enabled, do: "left-9", else: "left-1"}
      "} />
    </button>
    """
  end
end
