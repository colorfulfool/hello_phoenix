defmodule HelloPhoenixWeb.CollectionLive do
  use Phoenix.LiveView
  alias HelloPhoenixWeb, as: Web

  def render(assigns) do
    ~H"""
    <div class="space-y-3">
      <%= for item <- @collection do %>
        <.live_component module={@component} id={item.id} {%{String.to_atom(@prop_name) => item}} />
      <% end %>
    </div>
    """
  end

  def mount(
        :not_mounted_at_router,
        %{"collection" => collection, "component" => component},
        socket
      ) do
    table_name = hd(collection).__meta__.source
    prop_name = table_name |> String.slice(0..-2)

    Web.Endpoint.subscribe(table_name)

    {:ok,
     assign(socket, :collection, collection)
     |> assign(:component, component)
     |> assign(:prop_name, prop_name)}
  end

  def handle_info(
        %{
          topic: _topic,
          event: "item_changed",
          payload: payload
        },
        socket
      ) do
    {%{id: id}, attributes} = Map.split(payload, [:id])

    new_collection =
      Enum.map(socket.assigns.collection, fn item ->
        case item.id do
          ^id -> Map.merge(item, attributes)
          _ -> item
        end
      end)

    {:noreply, assign(socket, :collection, new_collection)}
  end
end
