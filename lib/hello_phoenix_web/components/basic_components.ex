defmodule HelloPhoenixWeb.BasicComponents do
  use Phoenix.Component

  attr :href, :any, required: true
  attr :match, :list, default: []
  attr :conn, :any, required: true
  slot :inner_block, required: true

  def naviagation_link(assigns) do
    assigns =
      assigns
      |> assign(:active?, assigns.conn.request_path in ([assigns.href] ++ assigns.match))

    ~H"""
    <.link href={@href} class={"font-medium #{@active? && "bg-zinc-200"} rounded px-2"}>
      {render_slot(@inner_block)}
    </.link>
    """
  end
end
