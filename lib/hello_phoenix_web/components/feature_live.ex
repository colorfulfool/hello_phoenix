defmodule HelloPhoenixWeb.FeatureLive do
  use Phoenix.LiveComponent

  import HelloPhoenixWeb.FlagComponents
  import HelloPhoenixWeb.CoreComponents

  alias HelloPhoenixWeb, as: Web
  alias HelloPhoenix.HelloPhoenixWeb
  alias Phoenix.LiveView.JS

  def render(assigns) do
    assigns =
      assign(assigns, :modal_id, "confirm-#{assigns.flag_state.id}")
      |> assign(:action_name, if(assigns.flag_state.enabled, do: "disable", else: "enable"))
      |> assign(:keep_name, if(assigns.flag_state.enabled, do: "enabled", else: "disabled"))

    ~H"""
    <div>
      <div class="flex justify-between">
        <div>
          <div class="font-bold">{@flag_state.flag.name}</div>
          <div>{@flag_state.flag.description}</div>
        </div>
        <.toggle
          enabled={@flag_state.enabled}
          phx-click={show_modal(%JS{}, @modal_id)}
          phx-target={@myself}
        />
      </div>

      <.modal id={@modal_id}>
        <div class="space-y-3">
          <div>
            Are you sure you want to {@action_name} <strong>{@flag_state.flag.name}</strong>?
          </div>
          <button
            class="px-3 py-1 bg-green-500 rounded text-white font-bold"
            phx-click={JS.push("toggle", target: @myself) |> hide_modal(@modal_id)}
          >
            Yes, {@action_name}
          </button>
          <button class="px-3 py-1 bg-zinc-200 rounded font-bold" phx-click={hide_modal(@modal_id)}>
            No, keep {@keep_name}
          </button>
        </div>
      </.modal>
    </div>
    """
  end

  def handle_event("toggle", _params, socket) do
    id = socket.assigns.flag_state.id
    new_enabled = !socket.assigns.flag_state.enabled

    HelloPhoenixWeb.set_flag_state_enabled(id, new_enabled)

    Web.Endpoint.broadcast("flag_states", "item_changed", %{
      :id => id,
      :enabled => new_enabled
    })

    {:noreply, socket}
  end
end
