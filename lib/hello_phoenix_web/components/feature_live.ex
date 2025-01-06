defmodule HelloPhoenixWeb.FeatureLive do
  use Phoenix.LiveComponent

  import HelloPhoenixWeb.FlagComponents

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
    flag_state = Map.update!(socket.assigns.flag_state, :enabled, &(!&1))
    {:noreply, assign(socket, :flag_state, flag_state)}
  end
end
