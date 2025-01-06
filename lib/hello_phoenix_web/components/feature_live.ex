defmodule HelloPhoenixWeb.FeatureLive do
  use Phoenix.LiveComponent

  import HelloPhoenixWeb.FlagComponents
  alias HelloPhoenix.HelloPhoenixWeb

  def render(assigns) do
    ~H"""
    <div class="flex justify-between">
      <div>
        <div class="font-bold">{@flag_state.flag.name}</div>
        <div>{@flag_state.flag.description}</div>
      </div>
      <.toggle enabled={@flag_state.enabled} phx-click="toggle" phx-target={@myself} />
    </div>
    """
  end

  def handle_event("toggle", _params, socket) do
    new_enabled = !socket.assigns.flag_state.enabled
    HelloPhoenixWeb.set_flag_state_enabled(socket.assigns.flag_state.id, new_enabled)
    new_flag_state = Map.put(socket.assigns.flag_state, :enabled, new_enabled)
    {:noreply, assign(socket, :flag_state, new_flag_state)}
  end
end
